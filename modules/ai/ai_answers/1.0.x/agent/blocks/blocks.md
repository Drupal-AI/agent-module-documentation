<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Answers — Question & Answer blocks and their JS runtime

Two Block plugins (`src/Plugin/Block/`), both cacheable static shells that attach a library +
`drupalSettings` and let the answer arrive over the API. Theme hooks + Twig in
`src/Hook/AiAnswersThemeHooks.php` and `templates/`.

## Answer block — `AnswerBlock` (`ai_answers_answer`, category "AI")

Renders the response container (`#theme => 'ai_answers_answer'`) and attaches library
`ai_answers/answer` (`js/ai_answers.markdown.js` + `js/ai_answers.answer.js` + CSS). Settings
(`block.settings.ai_answers_answer` schema; `blockForm()`):

- `agent` — the `ai_agent` id (select lists only agents enabled via `getEnabledAgentIds()`).
- `allow_follow_up`, `show_references`, `references_label` (default "Sources"), `show_feedback`,
  `empty_message`.
- `instance_uuid` — a per-placement UUID minted on first save; the wrapper DOM id is
  `ai-answers-answer-<uuid>` (shown in the form to copy into a Question block's `target`). Falls back
  to a per-render id if never saved.

`drupalSettings.aiAnswers.answer[<id>]` carries `{ agent, allowFollowUp, showReferences,
showFeedback, urls: { question, feedback } }`. Cache tag `config:ai_agent.ai_agent.<id>` +
`languages:language_interface` context.

## Question block — `QuestionBlock` (`ai_answers_question`, category "AI")

Renders a question input (`#theme => 'ai_answers_question'`) + library `ai_answers/question`.
Settings (`block.settings.ai_answers_question`): `target` (the Answer block's DOM id, selected from
placed Answer blocks by `getAnswerBlockOptions()`), `target_url` (optional internal path for
cross-page handoff), `placeholder`, `submit_label`, `suggested_questions` (one per line → clickable
chips via `getSuggestedQuestions()`).

## JS runtime

- `js/ai_answers.question.js` (`Drupal.behaviors.aiAnswersQuestion`) — on submit resolves the target
  Answer element by DOM id and calls `Drupal.aiAnswers.answer.ask(targetEl, question, true)` (always
  a new conversation), or falls back to an `ai-answers:ask` CustomEvent. If the target isn't on the
  page and a `target_url` is set, it navigates there with `#ai-answers-ask=<target>:<question>` in
  the fragment. Suggested-question chips fill the input and submit.
- `js/ai_answers.answer.js` (`Drupal.behaviors.aiAnswersAnswer`) — fetches the CSRF token once from
  `/session/token`, POSTs to the `question` url with `Accept: text/event-stream` and
  `X-CSRF-Token`, parses SSE frames (`parseFrames`), streams `token` text into the answer element as
  **`textContent`** (never markup) during streaming, and on `done` calls `renderAnswer()`. Handles
  conversation continuity per root, follow-up form submit, the cross-page handoff fragment, and
  thumbs feedback (`renderFeedback()` → POST to the `feedback` url).
- `js/ai_answers.markdown.js` (`Drupal.aiAnswers.markdownToHtml`) — a tiny no-dependency
  Markdown→HTML converter used by `renderAnswer()`. It **HTML-escapes the raw model text first**
  (`escapeHtml`, also stripping NUL), then emits only its own allowlisted tags (headings, `p`, `br`,
  `strong`, `em`, `code`, `pre`, `ul`, `ol`, `li`, `a`). Link hrefs pass `sanitizeHref()` (decodes a
  few entities, strips control chars, allows only root-relative/fragment/`https?:`/`mailto:` and
  schemeless relative paths — everything else renders as plain text) and are re-escaped for the
  quoted attribute. So raw model HTML never reaches `innerHTML` as live markup.
- After rendering, `linkifyCitations()` walks the DOM text nodes (skipping `code`/`pre`/`a`) and
  turns in-range `[n]` markers into `<sup><a href="#<rootId>-ref-<n>">` citation links; out-of-range
  markers are dropped.
- Reference bodies: `renderReferences()` sets `reference.rendered` as `innerHTML` — this is
  **server-rendered Drupal entity markup** produced by `AnswerService` in an isolated render context
  with entity view-access checks (see `api/endpoints.md`), then re-attaches behaviours. The question
  text and reference labels are always set via `textContent`.

## Theme hooks (`AiAnswersThemeHooks::theme()`)

`ai_answers_question` and `ai_answers_answer`, both overridable Twig templates in `templates/`. The
answer template is a static shell with `data-ai-answers-role="…"` slots (`transcript`,
`turn-template`, `references`, `feedback`, `follow-up`) the JS clones/fills; preserve those
attributes and the `hidden`/ARIA attributes when overriding.
