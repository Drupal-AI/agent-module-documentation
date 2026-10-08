<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# LMS quizzes: question types, answers, scoring

## Plugin type `activity_answer`
- Manager `plugin.manager.activity_answer`; attribute `Drupal\lms\Attribute\ActivityAnswer`;
  base `Drupal\lms\Plugin\ActivityAnswerBase` implementing `ActivityAnswerInterface`.
- An `lms_activity_type` (config) selects one plugin + its configuration. Key methods:
  - `answeringForm()` — build the student-facing form element.
  - `submitAnsweringForm()` — persist the student's input onto `lms_answer::data`.
  - `getScore(Answer): float` — 0..1 fraction, computed **server-side**.
  - `evaluatedOnSave(Answer): bool` — TRUE = auto-scored on submit; FALSE = queued for a human.
  - `evaluationDisplay()` — render the answer on the grader form.

## Shipped types (`lms_answer_plugins`)
- **Select** (`select`) — single (radios) or multiple (checkboxes). `SelectBase::getScore()`
  compares the checked option deltas against each option's `isCorrect()` flag: +1 per correct
  checked, −1 per incorrect checked, normalised over the count of correct options (never negative).
- **True/false** (`true_false`) — `TrueFalseBase::getScore()` compares the submitted `answer`
  against the activity's `bool_expected` field; 1 or 0.
- **Free text** (`free_text`) — `evaluatedOnSave() === FALSE`; stored as text (with optional text
  format and a minimum-character validator), **manually graded** by a teacher.
- **Fill in the blanks** (`fill_in_the_blanks`) — drag-and-drop (`DragAndDropBase`).
- **No answer** (`no_answer`, in core `lms`) — display-only / reading material, no scoring.
- Feedback variants (`*Feedback`) add per-answer feedback phrases.

## Where correct answers live (not leaked to the client)
Correct-answer data is stored on the **activity entity's own fields** — `bool_expected` for
true/false, the `is_correct` boolean on each `LmsAnswer` select option, expected phrases for
fill-in-the-blanks. The answering form (`answeringForm()`) emits only option **labels** and input
widgets; it never renders the correct flag, and `getScore()` reads the correct data server-side.
Students cannot view the activity's canonical page (editor-only access), so the correct answers are
not reachable through the activity render path either.

## Auto-scored submit flow (`AnswerForm::submitForm`)
1. `max_score` for the activity comes from the lesson's `lms_reference` item.
2. If a plugin exists and `evaluatedOnSave()`: `score = getScore(answer) * max_score`, `evaluated = TRUE`.
   If not auto-evaluated: `evaluated = FALSE`, score temporarily set to max (so the learner is not
   blocked from advancing) and the lesson marked not-evaluated.
   Zero-max (informational) activities are always `evaluated`, score 0.
3. Score/evaluated are written on the server; the learner never submits a score value.
4. `updateLessonStatus()` and `updateCourseStatus()` recompute weighted lesson and course scores and
   the pass/fail/`evaluation` status. A course passes only when all mandatory lessons are evaluated
   and meet their `required_score`.

## Manual grading (`AnswerEvaluationForm`)
- Reachable only via the answer-details page, and embedded only for accounts with `grade students`
  on the course. The grader enters a score bounded `0..max_score`; the value is written server-side.
- When all answers of a lesson are evaluated, the lesson status updates; when all lessons are
  evaluated, the course status (and final score) updates. AJAX variant updates the results table.
