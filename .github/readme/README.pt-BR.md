<p align="center">
    <a href="https://github.com/fisherrjd/i-have-adhd"> <img src="/logo.png" alt="i-have-adhd" width="140" /></a>
</p>
<p align="center">
  <strong align="center">Respostas amigáveis para quem tem TDAH. Sem precisar de diagnóstico!</strong>
</p>
<p align="center">
  <a href="/LICENSE"><img src="https://img.shields.io/github/license/fisherrjd/i-have-adhd?style=flat" alt="Licença"></a>
</p>

<p align="center">
  <a href="/README.md">English</a> ·
  <a href="README.zh-CN.md">简体中文</a> ·
  <a href="README.ja.md">日本語</a> ·
  <a href="README.ko.md">한국어</a> ·
  <a href="README.vi.md">Tiếng Việt</a> ·
  <strong>Português (BR)</strong>
</p>


## Instalação

<details>
<summary><strong>Claude Code</strong></summary>

```bash
claude plugin marketplace add fisherrjd/i-have-adhd
claude plugin install i-have-adhd@i-have-adhd
```

Depois digite `/i-have-adhd`. Não precisa clonar nada localmente: o Claude Code baixa o repositório e o mantém atualizado.

Este fork vem sempre ativo por padrão: toda sessão começa com o conjunto de regras carregado. Para desativar, use `touch ~/.claude/.i-have-adhd-off` (veja o [INSTALL.md](/INSTALL.md)).

</details>

<details>
<summary><strong>Codex</strong></summary>

```bash
codex plugin marketplace add fisherrjd/i-have-adhd --ref main
codex plugin add i-have-adhd@i-have-adhd
```

Depois digite `$i-have-adhd` para aplicar o estilo de resposta explicitamente. A skill também pode ser invocada implicitamente quando o Codex identifica uma tarefa que se beneficia dela.

</details>

As instruções de instalação para outros assistentes de código estão no [INSTALL.md](/INSTALL.md).

## Por que este fork

O [i-have-adhd do ayghri](https://github.com/ayghri/i-have-adhd) foi um salva-vidas, mas precisava de ajustes para o jeito como o meu cérebro funciona. Mensagens mais curtas, sozinhas, não bastavam: às vezes eu preciso de um empurrão para realmente revisar o que está na minha frente, especialmente as partes maiores, em vez de só ir concordando. Este fork adiciona esse reforço:

- **Sempre ativo por padrão.** O conjunto de regras carrega no início de toda sessão; desative com `touch ~/.claude/.i-have-adhd-off`.
- **Sessões de revisão (regra 10).** Passando de cinco itens de decisão, o assistente se oferece para percorrê-los um de cada vez em vez de despejar a lista inteira.
- **Nada se perde (regra 9).** Listas limitadas precisam registrar o conjunto completo em um arquivo, para que "tem mais 15" seja um caminho, não uma promessa.

## O que ela faz

Uma skill para o seu assistente de código que impede que ele enterre a resposta. Ação primeiro. Passos numerados. Nada de "Espero ter ajudado!"


## O que muda


<table>
<tr>
<td width="50%">

## Antes

> Ótima pergunta! Deixa eu pensar sobre isso. Seu fluxo de autenticação tem algumas partes envolvidas: o middleware, a verificação do token e o tratamento do cookie. Olhando o `src/auth.ts`, a função `verifyToken` (por volta das linhas 42-58) parece estar usando uma API antiga do `jsonwebtoken`. Uma abordagem seria atualizar o pacote e reescrever essa função. Depois da mudança, você vai querer rodar os testes de autenticação para confirmar que nada quebrou. Aliás, talvez valha a pena revisar as versões das suas dependências no geral. Espero ter ajudado! Me avise se quiser se aprofundar.

</td>

<td width="50%">

## Depois

> Rode `npm install jsonwebtoken@latest` e depois edite `src/auth.ts:42`.
>
> 1. Abra `src/auth.ts`
> 2. Substitua `verifyToken` (linhas 42–58) pelo trecho abaixo
> 3. Rode `npm test -- auth.spec.ts`
>
> Próximo passo: cole a primeira linha de falha se algum teste quebrar.

</td>
</tr>
</table>


## As regras

11 regras. Texto completo no [SKILL.md](/skills/i-have-adhd/SKILL.md).

1. Comece pela próxima ação.
2. Numere tarefas de múltiplos passos.
3. Termine com um próximo passo concreto.
4. Corte as tangentes.
5. Reafirme o estado atual a cada turno.
6. Estimativas de tempo específicas (minutos, não "um pouco").
7. Deixe as conquistas visíveis.
8. Erros relatados de forma objetiva.
9. Limite listas a 5 itens; registre a lista completa em um arquivo.
10. Passando de 5 itens de decisão, ofereça uma sessão de revisão um de cada vez.
11. Sem preâmbulo. Sem recapitulação. Sem frases de encerramento.

## Personalize

Faça um fork, edite `skills/i-have-adhd/SKILL.md` e troque pela sua cópia:

```bash
claude plugin uninstall i-have-adhd            # remova a cópia do upstream primeiro:
claude plugin marketplace remove i-have-adhd   # fork e upstream compartilham o mesmo nome
claude plugin marketplace add <seu-usuario>/i-have-adhd
claude plugin install i-have-adhd@i-have-adhd
```

Reinicie o Claude Code e invoque `/i-have-adhd` de novo.

## Créditos

Fork de [ayghri/i-have-adhd](https://github.com/ayghri/i-have-adhd); a estrutura e a maior parte do conjunto de regras são deles.

Baseado livremente em *The Adult ADHD Tool Kit*, de J. Russell Ramsay e Anthony L. Rostain. Adaptado para como um LLM deveria responder, não para como uma pessoa deveria organizar o dia.

## Licença

MIT.

Dê uma ⭐ se isso te poupou de rolar a tela por mais um "Ótima pergunta!"
