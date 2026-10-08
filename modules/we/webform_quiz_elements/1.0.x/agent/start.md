<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webform Quiz Elements (webform_quiz_elements) — agent index

Turns a **Webform** into a scored quiz by adding three Webform element plugins: a question element
(`quiz_element_radios` — radio buttons with a per-option correct-answer + feedback map), a
per-question result element (`webform_quiz_elements_result`), and a total-score element
(`webform_quiz_elements_score`). The correct-answer key lives in each question element's
`#quiz__options` property, which is part of the Webform's configuration; all scoring is computed
server-side in `WebformQuizElementsTrait` (`getWebformQuizCorrectAnswersCount` /
`getWebformQuizScore`), and the answer key is never emitted into the rendered question markup or any
JavaScript. Result and score elements default to `DISPLAY_ON_VIEW`, so feedback shows only after
submission (e.g. the confirmation page or a later wizard page). Everything the module does is element
plugins plus a little theme/token glue on top of Webform.

- **Depends on:** `webform` (composer `drupal/webform:^6`; installed here as 6.3.0).
- **Core:** `^10.1 || ^11` (info.yml); composer requires `drupal/core:^10.2||^11`. **PHP:** `>=8.1`.
  **Package:** Webform.
- **Settings page / configure route:** none (`configure: null`) — configured per element inside the
  Webform element edit forms, not on a module settings page.
- **Permissions:** none of its own (relies on Webform's `administer webform` / element access).
- **Drush:** none. **Config schema:** none shipped. **Plugin types defined:** none — it provides
  *instances* of Webform's existing element plugin type (`@WebformElement`), not a new type.
- **Provides:** 3 Webform element plugins, 2 render/theme elements, 1 token, 1 CSS library.

## What you'd do → where
- Add/understand the quiz elements, the `quiz__options` YAML format, validation, scoring math and
  rendering → `agent/plugins/webform-elements.md`.

## Key facts (real machine names)
- Webform element plugins (id → class, `src/Plugin/WebformElement/`):
  - `quiz_element_radios` → `QuizElementRadios` (extends webform `Radios`); adds property
    `quiz__options`. Category "Quiz elements", label "Radios (quiz element)".
  - `webform_quiz_elements_result` → `WebformQuizElementsResult`; props `source`, `display_on`.
    Label "Result (per quiz element)".
  - `webform_quiz_elements_score` → `WebformQuizElementsScore`; props `passing_score_percentage`
    (default 100), `feedback_message_pass`, `feedback_message_fail`, `display_on`. Label
    "Quiz total score".
- Render elements (`@FormElement`, `src/Element/`): `webform_quiz_elements_result`
  (`WebformQuizElementResult`), `webform_quiz_elements_score` (`WebformQuizElementScore`).
- Theme hooks → templates: `webform_quiz_elements_result` → `templates/webform-quiz-elements-result.html.twig`;
  `webform_quiz_elements_score` → `templates/webform-quiz-elements-score.html.twig`.
- Token: `[webform:quiz_elements_count]` (count of quiz question elements on the webform).
- Library: `webform_quiz_elements/styles` (`css/styles.css`).
- Interface constants (`Plugin/WebformQuizElementsInterface`):
  `QUIZ_ELEMENTS = ['quiz_element_radios']`,
  `QUIZ_RENDERED_ELEMENTS = ['webform_quiz_elements_score', 'webform_quiz_elements_result']`.
- Hooks (`webform_quiz_elements.module`, `.tokens.inc`): `hook_help`, `hook_theme`,
  `hook_preprocess_webform_confirmation` (attaches the styles library), `hook_token_info`,
  `hook_token_info_alter`, `hook_tokens`, `hook_theme_suggestions_HOOK` (empty).
- No routes, services, permissions, drush commands, or `.install`.
