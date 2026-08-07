#!/usr/bin/env sh
# SessionStart hook: injects the full i-have-adhd ruleset on every session.
# Emits JSON so the user sees a visible "ADHD MODE ACTIVE" banner
# (systemMessage) while the ruleset goes to the model (additionalContext).
# This fork is always-on by default; opt out by creating
# $CLAUDE_CONFIG_DIR/.i-have-adhd-off (default ~/.claude).
# Never blocks session start: any failure exits 0.
#
# POSIX fallback for environments where the default Node hook cannot run. It
# works with sh on macOS/Linux and Git Bash on Windows without a Node install.

claude_dir="${CLAUDE_CONFIG_DIR:-$HOME/.claude}"
off_path="$claude_dir/.i-have-adhd-off"

# Opt-out flag silences the hook entirely.
[ -f "$off_path" ] && exit 0

# $0 is the absolute script path substituted into hooks.json by Claude Code,
# so resolve SKILL.md relative to it instead of trusting an exported env var.
script_dir=$(dirname -- "$0")
skill_path="$script_dir/../skills/i-have-adhd/SKILL.md"
[ -f "$skill_path" ] || exit 0

# Strip a leading YAML frontmatter block (--- ... --- at the very top of file).
# An unterminated fence is not frontmatter, so the whole file is kept unless the
# closing delimiter exists (two passes; matches the Node and PowerShell hooks).
body=$(awk '
  NR == FNR {
    if (NR == 1 && $0 ~ /^---[[:space:]]*$/) { in_fm = 1; next }
    if (in_fm && $0 ~ /^---[[:space:]]*$/)   { in_fm = 0; closed = 1 }
    next
  }
  FNR == 1 { strip = closed }
  strip && FNR == 1 && $0 ~ /^---[[:space:]]*$/ { skipping = 1; next }
  skipping && $0 ~ /^---[[:space:]]*$/          { skipping = 0; next }
  !skipping { print }
' "$skill_path" "$skill_path") || exit 0

context=$(printf 'ADHD MODE ACTIVE (always-on). The ruleset below applies to every response. "stop adhd mode" turns it off for this session; touch %s to turn always-on off for good.\n\n%s\n' \
  "$off_path" "$body")

# JSON-escape the context: backslash, double quote, tab, CR; each line ends
# with a literal \n. Only these appear in practice; other control chars would
# need \u escapes.
esc=$(printf '%s\n' "$context" | awk '
  {
    gsub(/\\/, "\\\\")
    gsub(/"/, "\\\"")
    gsub(/\t/, "\\t")
    gsub(/\r/, "\\r")
    printf "%s\\n", $0
  }
') || exit 0

printf '{"systemMessage":"ADHD MODE ACTIVE (always-on). \\"stop adhd mode\\" pauses it for this session.","hookSpecificOutput":{"hookEventName":"SessionStart","additionalContext":"%s"}}\n' \
  "$esc"
