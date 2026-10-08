<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
LMS is the core of a Drupal Learning Management System: courses are Group entities, lessons and activities and student answers are content entities, and a learner walks a course lesson-by-lesson answering activities that are scored server-side. Enrolment is Group membership and every course-content route is gated by a Group permission, so one site can run many courses with different instructors and cohorts without a bespoke access layer. In the 1.2 branch, courses, lessons and activities are fully revisionable and each learner's progress is bound to the exact revisions they were served. Requires the Group module.

---

The design decision that shapes everything is building the course on top of **Group**. A course is a `group` entity of bundle `lms_course` (its bundle class is `Drupal\lms\Entity\Bundle\Course`), enrolment is group membership, and "who may take / grade / edit this course" are Group permissions (`take course`, `grade students`, plus core group perms) resolved per course rather than site-wide. The content model below that is entity-based throughout: `lms_lesson` entities reference an ordered list of `lms_activity` entities (via the module's own `lms_reference` field type, which carries per-item data such as max score, required score and mandatory flag); a course references its ordered lessons the same way. As a learner progresses, the module records `lms_course_status`, `lms_lesson_status` and `lms_answer` entities — progress is *derived* from these, not stored as a flag the client can set. Because the branch made courses, lessons and activities fully revisionable, those status/answer entities use a revision-aware reference (`lms_revision_reference`) that pins the specific revision the learner saw, so editing and republishing content does not retroactively alter recorded attempts.

`TrainingManager` is the engine. `CourseController::start` initializes a `lms_course_status` and redirects into `lms.group.answer_form` (`/course/{group}/{lesson_delta}/{activity_delta}`); `TrainingManager::checkActivityAccess()` enforces navigation rules — forward only when the previous activity is answered, backwards only where the lesson allows it, or anywhere when the course has free navigation or is being revisited. Answering an activity submits an `lms_answer` through `AnswerForm`, whose score is computed **server-side** by an `activity_answer` plugin: the plugin's `getScore()` reads the correct-answer data stored on the activity's own fields (e.g. `bool_expected`, or the `is_correct` flag on select options) — correct answers are never sent to the browser. Plugins that need a human (Free text) return `evaluatedOnSave() === FALSE`; a grader with the `grade students` group permission scores them later through `AnswerEvaluationForm`, and `updateLessonStatus()` / `updateCourseStatus()` roll answer scores up into weighted lesson and course scores and a pass/fail/needs-evaluation status. Course editors get an optional "Reset for updates" button (toggle `show_editor_reset_button`) that resets their own progress so they can preview the latest revisions.

Extension points and submodules: **`activity_answer`** is the plugin type for question types and **`modal_subform`** for the AJAX in-place entity editing used by the reference-table widget. `lms_answer_plugins` ships the standard question types (Select single/multi, True/false, Free text, Fill-in-the-blanks drag-and-drop, plus feedback variants); `lms_answer_comments` adds teacher/student comment threads on answers; `lms_classes` groups students into classes (subgroups) for cohorts and adds `add students` / `view students` group permissions. The module also ships SDC components (`course_card`, `course_navigation`, `activity_item`, `course_action_info`, `toolbar_icon`, a lesson timer) so the learner UI is themeable, Views integration (course/lesson/activity listing views, a course-card row, take/results/progress fields, a `CoursePermission` views access plugin), VBO-style actions (reset progress, transfer ownership/results), a `lms:create-test-content` / `lms:reset-course` Drush command set backed by a QA content importer and data-integrity checker, and tokens.

---

- Run online or blended courses on a Drupal site.
- Build a course as a Group so it has its own members and instructors.
- Enrol students by adding them as course (group) members.
- Structure a course as an ordered list of lessons.
- Compose a lesson from ordered activities (questions and reading material).
- Offer quiz question types: single/multiple select, true/false, fill-in-the-blanks drag-and-drop.
- Collect open-ended responses with a free-text activity for manual grading.
- Score selectable questions automatically and server-side.
- Have instructors grade free-text answers and see per-answer detail.
- Enforce linear navigation — students must answer before advancing.
- Optionally allow free navigation or revisiting a finished course.
- Require a minimum score on mandatory lessons before proceeding.
- Randomize activity order, or draw a random subset per attempt.
- Time-limit a lesson and auto-advance when the clock runs out.
- Track completion, pass/fail and weighted scores per learner.
- Show a learner their own results and answer breakdown.
- Keep recorded attempts bound to the exact course/lesson/activity revision served.
- Let editors reset their own progress to preview newly published revisions.
- Restrict who can take, grade or edit each course via Group permissions.
- Organise students into classes/cohorts running the same course (`lms_classes`).
- Add teacher/student comment threads on submitted answers (`lms_answer_comments`).
- Add a custom question type by writing an `activity_answer` plugin.
- Theme the learner-facing UI with the shipped SDC components.
- List and filter courses with the provided Views and course-card display.
- Reset a learner's or a whole course's progress (action or Drush command).
- Transfer course ownership or a learner's results to another user.
- Seed demo course content for testing with `drush lms:create-test-content`.
- Build internal staff training on top of an existing Drupal site.
