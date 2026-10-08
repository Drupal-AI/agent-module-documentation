<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webform element plugins

The module registers three `@WebformElement` plugins (instances of Webform's element plugin type,
`plugin.manager.webform.element`) plus two matching `@FormElement` render elements. There is no new
plugin type, no plugin manager, and no config schema of its own. Quiz elements are added and
configured entirely inside the Webform UI element edit forms
(`admin/structure/webform/manage/{webform}/element/...`).

## `quiz_element_radios` — the question (`QuizElementRadios`)

`src/Plugin/WebformElement/QuizElementRadios.php`, **extends webform `Radios`**. It behaves exactly
like a normal Webform radios element for the person filling it in — `prepare()` (line 35) forces
`$element['#type'] = 'radios'` before calling `parent::prepare()`, so no quiz metadata is added to
the rendered inputs. `buildHtml()` returns `[]` (line 74), and the added `processQuizOptions()`
callback (line 57) is effectively a no-op that only iterates. The only added property is
`quiz__options`, defined in `defineDefaultProperties()` (line 26) and marked translatable
(`defineTranslatableProperties()`, line 81).

### `quiz__options` config format

A YAML map keyed by the element's option values (must match `#options` one-for-one). Each entry needs
two keys:

- `is_correct` — bool, whether this option is the correct answer.
- `feedback` — string shown on the result element for the selected answer.

```yaml
q1:
  '#type': quiz_element_radios
  '#title': 'What is the capital of the UK?'
  '#required': true
  '#options':
    value1: 'London'
    value2: 'Paris'
    value3: 'Madrid'
  '#quiz__options':
    value1: { is_correct: true,  feedback: 'Correct. London is the capital of the UK.' }
    value2: { is_correct: false, feedback: 'Incorrect. Paris is the capital of France.' }
    value3: { is_correct: false, feedback: 'Incorrect. Madrid is the capital of Spain.' }
```

In the element edit form (`form()`, line 91) `quiz__options` is a required `webform_codemirror`
(`#mode => yaml`) textarea. `validateConfigurationForm()` (line 119) enforces:

1. `quiz__options` not empty.
2. `count(#options) === count(#quiz__options)`.
3. `array_keys(#options) === array_keys(#quiz__options)` (same keys, same order).
4. Every quiz option has both `is_correct` and `feedback` set.

Note the validator does not stop you marking multiple options `is_correct: true` even though the UI
help says "Only one option can be marked as correct" — enforcement of a single correct answer is not
implemented.

## `webform_quiz_elements_result` — per-question result (`WebformQuizElementsResult`)

`src/Plugin/WebformElement/WebformQuizElementsResult.php`, extends `WebformElementBase`, implements
`WebformElementDisplayOnInterface` (`use WebformDisplayOnTrait`) and `WebformQuizElementsInterface`.
`isInput()` / `isContainer()` both return `FALSE`. Properties (`defineDefaultProperties()`, line 29):

- `source` — the machine key of the `quiz_element_radios` question this result reflects. The edit
  form (`form()`, line 117) populates the select from `getWebformQuizElementsAsOptions()`, i.e. only
  elements whose plugin id is in `QUIZ_ELEMENTS`. Required.
- `display_on` — one of Webform's display-on values; **default `DISPLAY_ON_VIEW`**.

Rendering: `prepare()` sets `#access = FALSE` unless the element is displayed on `form`; when a
`#source` is set it merges in `getElementVariables()` (line 144), producing render variables
`#quiz_title` and `#quiz_options` (via `getQuizOptionsWithFeedback()` in the trait). `buildHtml()`
(line 70) returns those same variables only when displayed on `view`. `buildText()` (line 83)
produces a one-line plain-text summary (`Quiz result: Question: … Your answer: … Result:
CORRECT/INCORRECT Feedback: …`) for text/email output. Theme hook `webform_quiz_elements_result`
(template `templates/webform-quiz-elements-result.html.twig`) renders a `<ul>` of options; the
selected one is marked `messages--status` (correct) or `messages--error` (incorrect) and its
`feedback` is shown.

## `webform_quiz_elements_score` — total score (`WebformQuizElementsScore`)

`src/Plugin/WebformElement/WebformQuizElementsScore.php`, same base/interfaces as the result element.
Properties (`defineDefaultProperties()`, line 29):

- `passing_score_percentage` — int 1–100, **default 100**. Required in the edit form (`number`).
- `feedback_message_pass` / `feedback_message_fail` — textareas shown when the user passes / fails
  (both required, both translatable).
- `display_on` — default `DISPLAY_ON_VIEW`.

Rendering merges `getElementVariables()` (line 178) into the element, giving `#quiz_title`,
`#quiz_total_questions_count`, `#quiz_correct_answers_count`, `#quiz_score`, `#quiz_is_pass`,
`#quiz_feedback_message`. Theme hook `webform_quiz_elements_score` (template
`templates/webform-quiz-elements-score.html.twig`) prints "You have answered X out of Y" and the
pass/fail message. `buildText()` (line 93) emits a plain-text equivalent.

## Scoring logic (`WebformQuizElementsTrait`)

`src/Plugin/WebformElement/WebformQuizElementsTrait.php`. All computation is server-side, reading the
saved `WebformSubmission` and the webform's element config:

- `getWebformQuizElementsCount()` — number of `quiz_element_radios` elements (the denominator).
- `getWebformQuizCorrectAnswersCount()` — increments when the submitted answer key exists and
  `$element['#quiz__options'][$answer]['is_correct']` is truthy (line 62).
- `getWebformQuizScore()` — `correct / total * 100` (0 if no questions).
- pass = `score >= passing_score_percentage` (default 100).
- `getQuizOptionsWithFeedback()` — builds the per-option display array (`is_selected`, `is_correct`,
  `feedback`) used by the result template.

## Where the answer key lives (mechanism, not a warning)

`#quiz__options` (with `is_correct`) is an element property on the question element and is stored in
the webform config entity. It is read only server-side for scoring; because it is a `#`-prefixed
render property it is not output when the question renders as radios, and the module ships no
JavaScript, so the correct answer is not present in the form page's HTML/JS before submission.
Feedback and correctness become visible only through the result/score elements, which default to
`DISPLAY_ON_VIEW` (post-submission). Editing quiz options requires Webform admin/element-edit access.

## Token

`[webform:quiz_elements_count]` (`webform_quiz_elements.tokens.inc`) — resolves to the count of quiz
question elements on the webform via `_webform_quiz_elements_count()`. Handy for
"Question 1 out of [webform:quiz_elements_count]" text.

## Library / confirmation

`webform_quiz_elements/styles` (`css/styles.css`) is attached by both render elements' `getInfo()`
and, on the confirmation page, by `hook_preprocess_webform_confirmation()` when the webform contains
any `QUIZ_RENDERED_ELEMENTS` (score/result) element.

## Minimal working quiz

See `docs/example.yml` (and `tests/fixtures/config/sample_quiz.yml`) in the module for a complete,
importable two-question quiz: `quiz_element_radios` questions, one `webform_quiz_elements_score`, and
one `webform_quiz_elements_result` per question (each with `#source` pointing at its question). To
show results on the confirmation page, set the webform's confirmation message to
`[webform_submission:values:html]`. A multi-page quiz can put the question on one page and its result
element on the next (results need the submission postback).
