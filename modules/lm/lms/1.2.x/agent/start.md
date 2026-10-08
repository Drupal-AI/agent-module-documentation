<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# LMS (lms) — agent index

Learning Management System **core** for Drupal. Version **1.2.2**, core `^10.3 || ^11`.
Depends on `user`, `views`, and **`group:group`** (`drupal/group ^3.2`). Package `LMS`.
Maintainer: Marcin Grabias (graber). Rewritten from the ground up (originally an Opigno fork).

## The one thing to understand
A **course is a Group entity** of bundle `lms_course` (bundle class
`Drupal\lms\Entity\Bundle\Course`). **Enrolment is group membership.** Access to all course
content is a **Group permission** resolved per-course, not a site-wide role. Everything else is
content entities layered on top. Courses, lessons and activities are **fully revisionable**, and a
learner's progress entities pin the exact revision they saw.

## Content model
- `group` (bundle `lms_course`) — the course. References an ordered list of lessons via the
  `lessons` field (module's `lms_reference` field type). Fields: `revisit_mode`,
  `free_navigation`, `start_link` (computed).
- `lms_lesson` — references an ordered list of activities (`activities`, `lms_reference`).
  Carries randomization, backwards-navigation, close-time settings. Revisionable.
- `lms_activity` (bundle = `lms_activity_type` config entity) — a unit of work / question. Its
  fields hold both the presentation and the **correct-answer data** (e.g. `bool_expected`,
  select-option `is_correct`). Revisionable.
- `lms_answer` — a student's submitted answer (`user_id`, `activity_revision`, `lesson_status`,
  `data`, `score`, `evaluated`).
- `lms_course_status` / `lms_lesson_status` — derived per-learner progress and scores; reference
  the specific course/lesson/activity **revisions** the learner was served
  (`lms_revision_reference`).

## How it works (mechanism)
- `TrainingManager` is the engine; `CourseController` the entry points.
- `lms.course.start` (`/course/{group}/start`) initializes a `lms_course_status`, redirects into
  `lms.group.answer_form` (`course/{group}/{lesson_delta}/{activity_delta}`).
- `TrainingManager::checkActivityAccess()` enforces linear navigation (forward requires previous
  answered; backward only where allowed; anywhere in free-nav/revisit).
- Answering: `AnswerForm::submitForm()` → `activity_answer` plugin `getScore()` computes score
  **server-side** from the activity's stored correct answers. Manual types (`free_text`) defer to
  a grader via `AnswerEvaluationForm` (needs `grade students`).
- `updateLessonStatus()` / `updateCourseStatus()` roll answer scores into weighted lesson/course
  scores and status (`new`, `in progress`, `passed`, `failed`, `evaluation`).

## Permissions
Global (`lms.permissions.yml`): `administer lms` (**`restrict access: true`**), and per-entity
`create|use all|edit lms_activity entities`, `create|use all|edit lms_lesson entities`.
Group (`lms.group.permissions.yml`, effective inside LMS courses): **`take course`** (start/take)
and **`grade students`** (see & grade student answers). `lms_classes` adds group permissions
`add students` and `view students`.

## Plugin types provided
- `activity_answer` — question/answer types (manager `plugin.manager.activity_answer`,
  attribute `Drupal\lms\Attribute\ActivityAnswer`).
- `modal_subform` — AJAX in-place entity subforms for the reference-table widget.

## Submodules
- **`lms_answer_plugins`** — standard question types (Select, TrueFalse, FreeText,
  FillInTheBlanks, feedback variants). The place to model a new question type.
- **`lms_answer_comments`** — teacher/student comment threads on answers (feedback loop),
  gated by an `AccessPolicy` on the answer-details route.
- **`lms_classes`** — organise students into classes/cohorts (subgroups); access via group perms.

## Also ships
SDC components (`course_card`, `course_navigation`, `activity_item`, `course_action_info`,
`toolbar_icon`, lesson timer); Views (courses/lessons/activities listings, `course_card_row`,
take/results/progress fields, `CoursePermission` views access); VBO actions (`ResetCourseProgress`,
`TransferCourseOwnership`, `TransferCourseResults`); an editor "Reset for updates" button in the
course navigation (toggle `show_editor_reset_button`); tokens; Drush `lms:create-test-content`
(`lms-ctt`) and `lms:reset-course` (`lms-rc`), backed by a QA content importer / data-integrity
checker.

## Diff 1.1.x → 1.2.x
Real changes the 1.2 branch introduced over 1.1 (1.2.2 is a maintenance release on that branch):
- **Full revisioning.** Courses, lessons and activities became fully revisionable. A new
  `lms_revision_reference` field type (`RevisionReferenceItem`, id `lms_revision_reference`) was
  added, and the progress entities now reference the **specific revision** the learner saw:
  `lms_course_status.course` (replaces the old `gid`), `lms_lesson_status.lesson_revision` /
  `activity_revisions` (replace `lesson` / `activities`), `lms_answer.activity_revision` (replaces
  `activity`). Update path: `lms_update_11015` installs the new fields,
  `lms_post_update_populate_revision_references` back-fills current revisions, and
  `lms_update_12001` uninstalls the legacy fields.
- **Editor reset button.** New `show_editor_reset_button` setting (default on,
  `lms_update_11017`) drives a "Reset for updates" link for course editors in the course-navigation
  block (`CourseNavBlockBuilder`), hitting `lms.course.reset_test` (CSRF-tokened, `group.update`).
- **`lms_classes` student management.** New group permissions `add students` / `view students`
  (plus BC post-updates granting them and `grade students` to existing member roles), an
  add-student form/route, and an `lms_course_students` view.
- **QA / test-content subsystem.** `LmsContentImporter`, `DataIntegrityChecker`, `QaContentEvent` /
  `DefaultContentSubscriber` and the `lms:create-test-content` Drush command for seeding demo
  content from the module's `tests/data/*.yml`.

## Solution-type detail
- `entities/content-model.md` — the entity graph, field types, status entities, revisioning.
- `access/access-model.md` — routes, Group operations (`take`/`results`), entity access handlers.
- `quizzes/scoring.md` — question types, where correct answers live, server-side scoring, grading.
