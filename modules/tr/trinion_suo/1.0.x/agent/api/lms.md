<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# TrinionCourse structure & endpoints

## Course model
- Vocabulary `course_categories`: course → category → sub-category (3 levels), lessons/tests
  reference their sub-category via `field_ts_kategoriya_kursa`.
- Node bundles: `kurs_obucheniya` (course), `urok_kursa` (lesson), `test`.
- User fields: `field_ts_course_access` (granted courses), `field_ts_uchenik` (is student),
  `field_ts_completed_lessons` / `field_id_proydennykh_urokov` (completed lessons).

## `trinion_suo.course` service
- `getCategories($tid)` — full tree with lessons, lengths, completion, current-lesson flags.
- `getLessons($tid)` — ordered lessons/tests for a category (DB API select).
- `getNextLesson($node)` / `isLessonCompleted($node)` / `getCourseProgress($categories)`.
- `checkLessonAccess($entity)` / `checkCourseAccess($course)` — enforce purchased access.

## Endpoints
- `/complete_lesson/{node}` (`CompleteLessonAjaxController::response`) — marks the caller's
  lesson complete, redirects to next. Perm `access content`, bundle `urok_kursa`.
- REST `mark_lesson_rest_resource` GET `/lesson-complete/{id}` — same, via REST.
- REST `subscription_rest_resource` POST `/subscribe` — inserts `{email}` into
  `trinion_suo_subscribers`.

## Enrollment
`TrinionSuoSubscriber::onPaymentSuccess()` on `trinion_cart` `PAYMENT_SUCCESS`: grants
`field_ts_course_access`, sets student flags, sends the `course_buy_notice` mail.
