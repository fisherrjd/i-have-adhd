<p align="center">
    <a href="https://github.com/fisherrjd/i-have-adhd"> <img src="/logo.png" alt="i-have-adhd" width="140" /></a>
</p>
<p align="center">
  <strong align="center">ADHD 친화적인 출력. ADHD 진단은 필요 없어요!</strong>
</p>
<p align="center">
  <a href="/LICENSE"><img src="https://img.shields.io/github/license/fisherrjd/i-have-adhd?style=flat" alt="License"></a>
</p>

<p align="center">
  <a href="/README.md">English</a> ·
  <a href="README.zh-CN.md">简体</a> ·
  <a href="README.ja.md">日本語</a> ·
  <strong>한국어</strong> ·
  <a href="README.vi.md">Tiếng Việt</a> ·
  <a href="README.pt-BR.md">Português (BR)</a>
</p>


## 설치

<details>
<summary><strong>Claude Code</strong></summary>

```bash
claude plugin marketplace add fisherrjd/i-have-adhd
claude plugin install i-have-adhd@i-have-adhd
```

그런 다음 `/i-have-adhd`를 입력하세요. 로컬에 클론할 필요 없습니다. Claude Code가 저장소를 받아 최신 상태로 유지합니다.

이 포크는 기본적으로 항상 켜져 있습니다. 모든 세션이 룰셋이 로드된 상태로 시작합니다. 끄고 싶다면 `touch ~/.claude/.i-have-adhd-off` ([INSTALL.md](/INSTALL.md) 참고).

</details>

<details>
<summary><strong>Codex</strong></summary>

```bash
codex plugin marketplace add fisherrjd/i-have-adhd --ref main
codex plugin add i-have-adhd@i-have-adhd
```

`$i-have-adhd`를 입력하면 출력 스타일이 명시적으로 적용됩니다. Codex가 이 스킬이 도움이 될 만한 작업을 감지하면 자동으로 호출되기도 합니다.

</details>

다른 코딩 에이전트 설치 방법은 [INSTALL.md](/INSTALL.md)를 참고하세요.

## 왜 포크했나

[ayghri의 i-have-adhd](https://github.com/ayghri/i-have-adhd)는 정말 큰 도움이 됐지만, 제 두뇌가 작동하는 방식에 맞게 손볼 필요가 있었습니다. 메시지를 짧게 만드는 것만으로는 부족했어요. 특히 분량이 큰 내용은 고개만 끄덕이며 넘기지 않고 정말로 검토하도록 가끔은 옆구리를 찔러줄 무언가가 필요합니다. 이 포크는 그 보강 장치를 더합니다:

- **기본적으로 항상 켜짐.** 룰셋이 모든 세션 시작 시 로드됩니다. 끄려면 `touch ~/.claude/.i-have-adhd-off`.
- **리뷰 세션 (규칙 10).** 결정할 항목이 5개를 넘으면, 어시스턴트가 목록을 한꺼번에 쏟아내는 대신 하나씩 짚어보자고 제안합니다.
- **아무것도 누락하지 않음 (규칙 9).** 잘라낸 목록은 전체 내용을 파일에 기록해야 합니다. "15개 더 있어요"는 약속이 아니라 파일 경로여야 합니다.

## 무슨 일을 하나

코딩 어시스턴트가 답을 긴 글 속에 묻어두지 못하게 막는 스킬입니다. **행동 우선**, 단계는 **번호로**, "도움이 되었기를!" 같은 군더더기 없음.


## 무엇이 달라지는가

<table>
<tr>
<td width="50%">

## Before

> 좋은 질문이네요! 한번 생각해볼게요. 인증 흐름에는 미들웨어, 토큰 검증, 쿠키 처리 같은 여러 부분이 있어요. `src/auth.ts`를 살펴보면 `verifyToken` 함수(42~58번째 줄 근처)가 구버전 `jsonwebtoken` API를 쓰는 것 같아요. 한 가지 방법은 패키지를 업데이트하고 그 함수를 다시 작성하는 거예요. 변경 후에는 인증 테스트를 돌려서 문제가 없는지 확인해야 해요. 아, 그리고 하나 더, 전체 의존성 버전도 살펴보시면 좋을 것 같아요. 도움이 되었기를! 더 깊이 파고 싶으시면 알려주세요.

</td>

<td width="50%">

## After

> `npm install jsonwebtoken@latest` 실행 후 `src/auth.ts:42`를 수정하세요.
>
> 1. `src/auth.ts` 열기
> 2. `verifyToken`(42~58줄)을 아래 스니펫으로 교체
> 3. `npm test -- auth.spec.ts` 실행
>
> 다음 단계: 테스트가 실패하면 첫 번째 실패 줄을 붙여넣어 주세요.

</td>
</tr>
</table>

## 규칙

11가지 규칙. 전문은 [SKILL.md](/skills/i-have-adhd/SKILL.md)에 있습니다.

1. 다음 행동부터 말하기.
2. 다단계 작업은 번호로.
3. 한 가지 구체적인 다음 단계로 끝내기.
4. 엉뚱한 이야기 자르기.
5. 매 턴마다 현재 상태 다시 알리기.
6. 시간은 분 단위로 정확하게 ("조금" ❌).
7. 진전 사항을 눈에 띄게.
8. 오류는 담백하게.
9. 목록은 최대 5개 항목, 전체 목록은 파일에 기록.
10. 결정할 항목이 5개를 넘으면 하나씩 짚어보는 리뷰 세션 제안.
11. 서론, 요약, 마무리 인사 없음.

## 커스터마이즈

저장소를 포크해 `skills/i-have-adhd/SKILL.md`를 수정한 다음, 본인 복사본으로 교체하세요:

```bash
claude plugin uninstall i-have-adhd            # 먼저 업스트림 버전 제거
claude plugin marketplace remove i-have-adhd   # 포크와 업스트림이 같은 이름을 씁니다
claude plugin marketplace add <your-username>/i-have-adhd
claude plugin install i-have-adhd@i-have-adhd
```

Claude Code를 재시작한 뒤 `/i-have-adhd`를 다시 호출하세요.

## 크레딧

[ayghri/i-have-adhd](https://github.com/ayghri/i-have-adhd)에서 포크했습니다. 구조와 룰셋 대부분은 원저자의 것입니다.

J. Russell Ramsay와 Anthony L. Rostain의 *The Adult ADHD Tool Kit*을 느슨하게 참고했습니다. 사람이 하루를 어떻게 꾸려야 하는가가 아니라 **LLM이 어떻게 응답해야 하는가**에 맞춰 재해석했습니다.

## 라이선스

MIT.

"좋은 질문이네요!" 없는 답변을 한 번이라도 받았다면 Star ⭐ 부탁드립니다.
