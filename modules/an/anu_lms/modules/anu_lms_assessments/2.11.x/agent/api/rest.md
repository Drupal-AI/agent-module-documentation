<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Anu LMS Quizzes REST endpoints

Two `@RestResource` plugins in `src/Plugin/rest/resource/`, enabled by
`config/install/rest.resource.*.yml` (format `json`, authentication `cookie`). Cookie auth means core
requires a valid `X-CSRF-Token` on POST, and the caller's role needs the matching `restful post …`
permission. Shared grading lives in `QuestionRestResource::processAnswerToQuestion()`.

## `question_rest_resource` — POST `/assessments/question`

`QuestionRestResource::post()`. Submits a single inline self-check question.

- Permission: `restful post question_rest_resource`.
- Body: `{"questionId": <int>, "value": <answer>}` (`value` may be `null` when nothing is chosen;
  400 `BadRequestHttpException` if `questionId` is missing/non-numeric).
- Loads the `assessment_question`, validates its bundle is one of `short_answer`, `long_answer`,
  `scale`, `multiple_choice`, `single_choice`, saves an `assessment_question_result` and grades it.
- Response: `{"correctAnswer": <expected answer>}` — the endpoint returns the expected answer so the
  UI can show a self-check result inline.

## `assessment_rest_resource` — POST `/assessments/assessment`

`AssessmentRestResource::post()` (extends `QuestionRestResource`). Submits a whole quiz.

- Permission: `restful post assessment_rest_resource`.
- Body: `{"nid": <quiz node id>, "data": {<questionId>: <answer>, ...}}` (400 if `nid`/`data` invalid
  or `nid` is not a `module_assessment` node).
- Calls `$quiz->access('view')` (403 if denied), creates one `assessment_result` (`aid` = quiz),
  grades each answer via `processAnswerToQuestion()` into `assessment_question_result` rows linked by
  `arid`, then `Quiz::setCompleted()` marks the quiz complete in `anu_lms_progress`.
- Response: `{"correctAnswersCount": <int>}`, plus `{"correctAnswers": {questionId: expected, ...}}`
  **only when the quiz's `field_hide_correct_answers` is off**.

## Grading (`processAnswerToQuestion($answer, $questionId, $quizResult = NULL)`)

- `short_answer` / `long_answer`: store `field_question_response[_long]`, `is_correct =
  RESULT_NOT_APPLICABLE`, treated as correct for counting; expected = editor's `field_correct_answer[_long]`.
- `scale`: integer compare vs `field_scale_correct` → `RESULT_CORRECT`/`RESULT_INCORRECT`.
- `single_choice` / `multiple_choice`: gather option paragraph IDs flagged
  `field_single_multi_choice_right`, sort, compare with sorted submitted IDs; unknown submitted option
  → 400. Selected options saved to `field_single_multi_choice`.

Errors are logged (with the payload) and re-thrown as `BadRequestHttpException`.
