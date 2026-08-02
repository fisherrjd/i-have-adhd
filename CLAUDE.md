# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

A cross-agent plugin that shapes assistant output for ADHD readers. The entire product is one prompt file — `skills/i-have-adhd/SKILL.md` (10 output rules + override conditions + pre-send check). Everything else is packaging that delivers that file to different agent hosts, plus an eval harness that measures whether the skill actually improves responses.

## Critical invariant: SKILL.md has a mirror

`.cursor/skills/i-have-adhd/SKILL.md` must be a byte-identical copy of `skills/i-have-adhd/SKILL.md`. It is a real file, not a symlink (so Windows clones and GitHub ZIP downloads work). CI fails on any drift. After editing the canonical file, always run:

```bash
cp skills/i-have-adhd/SKILL.md .cursor/skills/i-have-adhd/SKILL.md
```

## Commands

No build step, no lint config, no dependencies — the Python code is stdlib-only.

```bash
# All tests
python3 -m unittest discover -s tests

# Single test
python3 -m unittest tests.test_run_evals.EvaluationHarnessTest.test_score_summary_applies_weights_and_release_gates

# Validate the eval case catalog
python3 scripts/run_evals.py validate

# Run an eval condition (see evals/README.md for full workflow)
python3 scripts/run_evals.py run --runner claude --condition baseline --output evals/results/responses.jsonl

# Aggregate judged scores and apply the release gate
python3 scripts/run_evals.py score evals/results/scores.jsonl
```

## Architecture

**Canonical skill** — `skills/i-have-adhd/SKILL.md`. Frontmatter sets `disable-model-invocation: true` on purpose: the skill is activated only by the user (`/i-have-adhd`) or by the always-on hook, never auto-invoked by the model.

**Per-host packaging** (all point at the same SKILL.md content):
- Claude Code: `.claude-plugin/plugin.json` + `.claude-plugin/marketplace.json`
- Codex: `.codex-plugin/plugin.json` (`skills: ./skills/`)
- Gemini CLI: `gemini-extension.json` + `GEMINI.md` (imports the skill via `@./skills/i-have-adhd/SKILL.md`)
- Antigravity: root `plugin.json`
- Cursor: the `.cursor/skills/` mirror described above
- Other agent formats: `skills/i-have-adhd/agents/` (openai.yaml, gemini.toml), `.agents/plugins/marketplace.json`

**Always-on mechanism** — `hooks/hooks.json` registers a SessionStart hook running `hooks/always-on.sh` (pure POSIX sh, no Node/Python dependency). In this fork it fires on **every** session, injecting the SKILL.md body (frontmatter stripped via awk), unless the user opts out by creating `$CLAUDE_CONFIG_DIR/.i-have-adhd-off`. (Upstream is the inverse: opt-in via `.i-have-adhd-always`.) It must never block session start: every failure path exits 0. Keep those properties when editing it.

**Eval harness** — `scripts/run_evals.py` (single file; subcommands `validate`, `plan`, `run`, `score`). Design points that matter when modifying it:
- Paired comparison: baseline (bare prompt) vs candidate (prompt wrapped with the skill text). Conditions are only comparable when judged on identical `(case, trial)` rows; `_check_pairing` enforces this.
- Runner isolation is load-bearing: runners in `evals/runners.example.json` disable user config (`--setting-sources ""` for Claude, `--ignore-user-config --ephemeral` for Codex). Without it, the operator's own always-on flag would inject the skill into the *baseline* condition and the eval would measure the skill against itself. Runners also pin `--model` explicitly — keep a pin.
- Cost safety: `--budget-usd` is capped at 25; runners that don't report dollar cost are rejected unless `--allow-unmetered`. Runs are resumable — completed `(case, trial, condition, runner)` rows in the output file are skipped.
- Scoring: weights and the release gate (no blockers; correctness/safety within 0.1 of baseline; weighted score must beat baseline) live in `WEIGHTS` and `summarize_scores`; the human-facing contract is `evals/rubric.md`. Tests in `tests/test_run_evals.py` cover the harness and also assert the case catalog stays ≥12 cases across ≥8 categories.

## CI (GitHub Actions)

- `plugin-load-check.yml` — installs the plugin from the checkout into a scratch `CLAUDE_CONFIG_DIR` and fails unless `claude plugin list` shows it enabled. Catches load-layer breakage (e.g. malformed hooks.json) that schema checks miss.
- `cursor-skill-sync.yml` — the byte-identical mirror check described above.
- `claude.yml` — @claude mention handler on issues/PRs.

## Translated READMEs

`README.md` has translations in `.github/readme/` (zh-CN, ja, ko, vi, pt-BR). Structural changes to the English README should be mirrored there — history shows drift gets fixed in follow-up commits, so update them in the same PR when feasible.
