Anu LMS Quizzes adds graded quizzes and inline self-check questions to Anu LMS, with question and result content entities, submission REST endpoints, automatic grading, and teacher result review pages.

---

This submodule extends Anu LMS with a `module_assessment` node type (a "Quiz") that sits at the end of a course module alongside lessons, plus three content entity types: `assessment_question` (the question bank, with bundles `single_choice`, `multiple_choice`, `scale`, `short_answer`, `long_answer`), `assessment_question_result` (one saved answer), and `assessment_result` (one quiz attempt grouping its question results). Questions are attached to lessons and quizzes as `question_*` paragraphs. The React front end submits answers to two cookie-authenticated REST endpoints — `/assessments/question` for a single inline question and `/assessments/assessment` for a full quiz — which grade the response server-side (`processAnswerToQuestion()` in `QuestionRestResource`): choice and scale questions are marked correct/incorrect by comparing against the editor-defined correct options, while free-text answers are stored as "not applicable". A quiz can set `field_hide_correct_answers` (do not return correct answers on the full-quiz submission) and `field_no_multiple_submissions` (restore and lock the previous attempt).

Teachers review responses through admin-routed pages: `/node/{node}/questions_results` (inline lesson questions), `/node/{node}/assessment_results` (all attempts of a quiz) and `/node/{node}/assessment_results/{assessment_result}` (one learner's answers), each gated by `node.access('update')` on the owning lesson/quiz and rendered by embedded Views. Result data can be exported to XLS via Views Data Export / XLS Serialization (declared dependencies, along with Range for scale questions). Grading, completion and access reuse the base module: `Quiz` service extends the base `Lesson` service, `anu_lms_assessments_node_access` forbids viewing a quiz whose course is not viewable, and completing a quiz writes to the same `anu_lms_progress` table.

Enable with `drush en anu_lms_assessments -y` after Anu LMS. It installs its content model from `config/install/` (the `module_assessment` node type and fields, the question/result entity type bundles and their form/view displays, the two REST resource configs, and five Views for responses/results/exports).

---

- Add end-of-module quizzes to Anu LMS courses.
- Offer single-choice and multiple-choice questions with editor-defined correct options.
- Offer scale (integer) questions graded against a correct value.
- Offer short-answer and long-answer free-text questions (stored, marked "not applicable" for grading).
- Place inline self-check questions inside a lesson that return the correct answer immediately.
- Grade quiz submissions automatically and return the count of correct answers.
- Hide correct answers on a graded quiz with `field_hide_correct_answers`.
- Prevent multiple submissions and restore a learner's previous attempt with `field_no_multiple_submissions`.
- Persist each attempt as an `assessment_result` with per-question `assessment_question_result` records.
- Let teachers review all responses to a lesson's inline questions.
- Let teachers review all attempts at a quiz, and drill into one learner's answers.
- Export question responses and quiz results to XLS for offline analysis.
- Reuse Anu LMS linear-progress locking so a quiz unlocks only after prior lessons are complete.
- Mark quiz completion in the shared `anu_lms_progress` table.
- Manage the question bank and results with granular per-entity permissions and revisions.
- Build custom reports on quiz data using the provided Views relationships (question ↔ result ↔ attempt).
