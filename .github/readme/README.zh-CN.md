<p align="center">
    <a href="https://github.com/fisherrjd/i-have-adhd"> <img src="/logo.png" alt="i-have-adhd" width="140" /></a>
</p>
<p align="center">
  <strong align="center">对 ADHD 友好的输出。无需确诊 ADHD！</strong>
</p>
<p align="center">
  <a href="/LICENSE"><img src="https://img.shields.io/github/license/fisherrjd/i-have-adhd?style=flat" alt="许可证"></a>
</p>

<p align="center">
  <a href="/README.md">English</a> ·
  <strong>简体中文</strong> ·
  <a href="README.ja.md">日本語</a> ·
  <a href="README.ko.md">한국어</a> ·
  <a href="README.vi.md">Tiếng Việt</a> ·
  <a href="README.pt-BR.md">Português (BR)</a>
</p>


## 安装

<details>
<summary><strong>Claude Code</strong></summary>

```bash
claude plugin marketplace add fisherrjd/i-have-adhd
claude plugin install i-have-adhd@i-have-adhd
```

然后输入 `/i-have-adhd`。无需在本地克隆：Claude Code 会获取该仓库并保持更新。

本 fork 默认全程开启：每次会话开始时都会加载规则集。运行 `touch ~/.claude/.i-have-adhd-off` 即可退出（参见 [INSTALL.md](/INSTALL.md)）。

</details>

<details>
<summary><strong>Codex</strong></summary>

```bash
codex plugin marketplace add fisherrjd/i-have-adhd --ref main
codex plugin add i-have-adhd@i-have-adhd
```

然后输入 `$i-have-adhd`，显式应用这种输出风格。当 Codex 发现某项任务适合使用此技能时，也可以隐式调用它。

</details>

其他编程智能体的安装说明位于 [INSTALL.md](/INSTALL.md)。

## 为什么要 fork

[ayghri 的 i-have-adhd](https://github.com/ayghri/i-have-adhd) 曾是我的救星，但它需要针对我的大脑运作方式做些调整。仅仅缩短消息还不够：我有时需要被推一把，才能真正审阅眼前的内容，尤其是较大的部分，而不是心不在焉地点头附和。这个 fork 补上了这种强化：

- **默认全程开启。** 规则集在每次会话开始时加载；运行 `touch ~/.claude/.i-have-adhd-off` 即可退出。
- **审阅会话（规则 10）。** 决策项超过五个时，助手会提议逐项过一遍，而不是一次性抛出整个列表。
- **不遗漏任何内容（规则 9）。** 被截断的列表必须把完整清单记录到文件中，这样“还有 15 项”就是一个文件路径，而不是一句空头承诺。

## 功能

这是一个面向编程助手的技能，阻止它把答案藏在冗长文字中。行动优先。步骤编号。不说“希望这能帮到你！”


## 有什么变化


<table>
<tr>
<td width="50%">

## 之前

> 问得好！让我想一想。你的身份验证流程包含几个环节：中间件、令牌验证和 Cookie 处理。查看 `src/auth.ts` 后，`verifyToken` 函数（大约第 42–58 行）似乎使用了旧版 `jsonwebtoken` API。一种做法是升级这个包并重写该函数。完成修改后，你需要运行身份验证测试，确认没有破坏任何功能。顺便一提，你可能还想整体检查一下依赖版本。希望这能帮到你！如果你想进一步研究，请告诉我。

</td>

<td width="50%">

## 之后

> 运行 `npm install jsonwebtoken@latest`，然后编辑 `src/auth.ts:42`。
>
> 1. 打开 `src/auth.ts`
> 2. 将 `verifyToken`（第 42–58 行）替换为下面的代码片段
> 3. 运行 `npm test -- auth.spec.ts`
>
> 下一步：如果有测试失败，请粘贴第一行报错。

</td>
</tr>
</table>


## 规则

共 11 条规则。完整内容见 [SKILL.md](/skills/i-have-adhd/SKILL.md)。

1. 先说下一步行动。
2. 多步骤任务使用编号。
3. 以一个具体的下一步结束。
4. 避免离题。
5. 每轮都重述当前状态。
6. 给出明确的时间估计（用分钟，不说“一会儿”）。
7. 让成果清晰可见。
8. 客观陈述错误。
9. 每个列表最多 5 项；完整清单记录到文件中。
10. 决策项超过 5 个时，提议逐项审阅。
11. 不写开场白、回顾或结束语。

## 自定义

Fork 此仓库，编辑 `skills/i-have-adhd/SKILL.md`，然后换成你的副本：

```bash
claude plugin uninstall i-have-adhd            # 先移除上游副本：
claude plugin marketplace remove i-have-adhd   # fork 与上游使用相同名称
claude plugin marketplace add <your-username>/i-have-adhd
claude plugin install i-have-adhd@i-have-adhd
```

重启 Claude Code，然后再次调用 `/i-have-adhd`。

## 致谢

Fork 自 [ayghri/i-have-adhd](https://github.com/ayghri/i-have-adhd)；整体结构和大部分规则集都出自他们之手。

内容大致参考 J. Russell Ramsay 和 Anthony L. Rostain 所著的 *The Adult ADHD Tool Kit*。本技能针对 LLM 应如何回应进行了改编，而不是教人们如何安排日常生活。

## 许可证

MIT。

如果它让你少滚动一次屏幕、跳过一句“问得好！”，请点亮 Star ⭐
