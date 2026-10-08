# How AJAX Quiz works (hooks)

All logic lives in `ajax_quiz.module`; there is no `src/`. Two moving parts:

## 1. `ajax_quiz_form_alter()`

Runs on the Quiz answering flow forms — `quiz_question_answering_form` and `quiz_report_form` —
**only** when `\Drupal::currentUser()->hasPermission('access ajax quiz')`. For those forms it:

- wraps the form in a `<div id="ajax-quiz-wrapper">` (`#prefix` / `#suffix`), and
- attaches an `#ajax` definition (wrapper `ajax-quiz-wrapper`, method `replace`, callback
  `ajax_quiz_navigate_quiz`) to every `submit` button under the form's `navigation` element.

## 2. `ajax_quiz_navigate_quiz($form, FormStateInterface $form_state)`

The AJAX callback. It reads the current attempt from the **`quiz.session`** service
(`Drupal\quiz\Services\QuizSessionInterface`): the temporary/`#quiz_result`, the current
question number, and the result layout. Then, depending on state:

- **Feedback step** — renders `QuizQuestionFeedbackForm` for the just-answered question and
  returns a `ReplaceCommand('#ajax-quiz-wrapper', …)`.
- **Next question** — sets the current question on the result, rebuilds a
  `quiz_progress` render element into `#quiz-progress` (`ReplaceCommand`), and returns either a
  fresh `QuizQuestionAnsweringForm` (when coming from the report form) or the rebuilt answering
  form (`$form_state->setRebuild()`), with `#action` set to `/system/ajax`.
- **Quiz finished** (result exists, no current question) — `RedirectCommand` to
  `/quiz/{quiz}/result/{result}`.
- **No result** — `RedirectCommand` back to `/quiz/{quiz}`.

It also implements `ajax_quiz_help()` (help text for `admin/help#ajax_quiz`). No other hooks.
