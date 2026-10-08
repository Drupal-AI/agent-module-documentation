<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Anu LMS Quizzes (anu_lms_assessments) — agent index

Submodule of **anu_lms**. Adds graded quizzes + inline self-check questions. Package `Anu LMS`.
Core `^10 || ^11`. Version 2.11.2. Depends on `anu_lms`, `range`, `views_data_export`,
`xls_serialization`.

## Entities & bundles

- Node bundle **`module_assessment`** ("Quiz") — fields `field_module_assessment_items`,
  `field_hide_correct_answers` (bool), `field_no_multiple_submissions` (bool). Referenced from a
  `course_modules` paragraph via `field_module_assessment`.
- Content entity **`assessment_question`** — the question bank. Bundles: `single_choice`,
  `multiple_choice`, `scale`, `short_answer`, `long_answer`. Revisionable, translatable, owned;
  access handler `AssessmentQuestionAccessControlHandler` (permission-based + `checkOwn` for
  per-bundle "own" permissions).
- Content entity **`assessment_question_result`** — one saved answer (`is_correct`, response fields
  per type, `aqid` → question, `arid` → attempt). Handler `AssessmentQuestionResultAccessControlHandler`.
- Content entity **`assessment_result`** — one quiz attempt (`aid` → quiz node, owner).
  Handler `AssessmentResultAccessControlHandler`.
- Question paragraphs `question_single_choice` / `_multi_choice` / `_scale` / `_short_answer` /
  `_long_answer` / `_likert_scale`, each with a `field_question` → `assessment_question`; option
  paragraph `single_multi_choice_item` (`field_single_multi_choice_right`, `_value`).

## REST endpoints (`src/Plugin/rest/resource/`) → [api/rest.md](api/rest.md)

- **`question_rest_resource`** POST `/assessments/question` — submit one question, returns its correct
  answer. `QuestionRestResource::post()` → `processAnswerToQuestion()`.
- **`assessment_rest_resource`** POST `/assessments/assessment` — submit a whole quiz, grades all
  answers, returns `correctAnswersCount` (+ `correctAnswers` unless the quiz hides them).
  `AssessmentRestResource` extends `QuestionRestResource`. Checks `$quiz->access('view')`.

Both cookie auth (`config/install/rest.resource.*.yml`), so core requires an `X-CSRF-Token` on POST.

## Services / plugins / controllers

- Service `anu_lms_assessments.quiz` → `Quiz` (extends base `anu_lms.lesson` `Lesson`): grading helpers,
  `getQuizSubmissionData()` (restore prior attempt when `field_no_multiple_submissions`), `loadSubmittedAnswers()`.
- Content-type plugin `Quiz` (`src/Plugin/AnuLmsContentType/Quiz.php`, id `module_assessment`) — extends
  base `ModuleLesson`; 403 if `Quiz::isRestricted()`, appends prior submission data.
- Deprecated legacy `src/Quiz.php` also present.
- Result pages (`anu_lms_assessments.routing.yml`, all `_admin_route`, `_custom_access` on the
  controller, embed Views):
  - `AssessmentResultsController` — `/node/{node}/assessment_results`, `/…/{assessment_result}`
    (`checkAccess` requires bundle `module_assessment` + `node.access('update')`).
  - `QuestionsResultsController` — `/node/{node}/questions_results` (bundle `module_lesson`, has
    `question_*` paragraphs, `node.access('update')`).
  - `AssessmentQuestionController` — question entity revision pages.

## Permissions (`anu_lms_assessments.permissions.yml`)

Full per-entity CRUD sets for `question`, `assessment question result`, `assessment result` entities
(add/edit/delete/view published/view unpublished, administer* `restrict access: true`, plus question
revision permissions). REST access additionally needs `restful post question_rest_resource` /
`restful post assessment_rest_resource`.

## Hooks (`anu_lms_assessments.module`)

- `hook_node_access` — forbid viewing a `module_assessment` whose owning course is not viewable.
- `hook_views_data_alter` — result↔question↔attempt relationships for the review Views.
- Label/IEF/field-group alters (quiz add/existing buttons, "hide correct answers" / "prevent multiple
  submissions" descriptions), `hook_entity_form_display_alter` swaps in the quiz form display.

## Grading model (`processAnswerToQuestion`)

- `short_answer`/`long_answer` → stored, `is_correct = NOT_APPLICABLE`, always "correct" for counting,
  editor's `field_correct_answer[_long]` returned as expected answer.
- `scale` → integer compare vs `field_scale_correct`.
- `single_choice`/`multiple_choice` → compare sorted selected option IDs vs the options flagged
  `field_single_multi_choice_right`.
