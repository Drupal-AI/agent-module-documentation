<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Turns a Trinion site into an online-course platform: hierarchical courses, lessons, tests, per-user progress and access that is unlocked when a course is purchased.

---
Courses are modelled as a `course_categories` taxonomy tree with `urok_kursa` (lesson) and `test` nodes; the `trinion_suo.course` service walks the tree, computes progress, finds the next lesson and enforces access. Lesson view access is controlled in `hook_node_access` via `Course::checkLessonAccess()` — free lessons are open, otherwise the user must have the lesson's course id in `field_ts_course_access`. Enrollment is event-driven: a `trinion_cart` `PaymentEvent::PAYMENT_SUCCESS` subscriber grants course access, flags the buyer as a student, and emails credentials. Learners mark lessons complete via `/complete_lesson/{node}` (AJAX) or the `/lesson-complete/{id}` REST resource, both writing to the current user's completion field; an admin drag-and-drop course builder lives at `/node/{node}/course-structure` (perm `edit any kurs_obucheniya content`). Blocks (course plan, test), a Twig hours/minutes filter, a student access-check service and a "last lesson" views field round it out.

Access: `/complete_lesson/{node}` is gated by `access content` and only updates the caller's own completion list (bundle-restricted to `urok_kursa`); the `MarkLessonRestResource` GET appends `{id}` to the caller's own reference field; the `SubscriptionRestResource` POST inserts the posted email into `trinion_suo_subscribers`, with access governed by the REST config permission. Setup: install `trinion_cart`/`inline_entity_form`, build the course taxonomy, and configure the REST resources' permissions before enabling them for anonymous.
---
- Model a course as a `course_categories` taxonomy tree with lessons and tests.
- Serve video lessons, articles and practical assignments.
- Gate paid lessons behind purchased course access.
- Offer selected lessons free (`field_ts_free_lesson`).
- Track per-user lesson completion and course progress %.
- Mark a lesson complete and redirect to the next lesson (AJAX).
- Mark a lesson complete via a REST endpoint.
- Grant course access automatically on successful cart payment.
- Email new students their login credentials and course link.
- Redirect students to their courses list after login.
- Show a course-plan menu block with progress.
- Render a test/quiz block for a lesson.
- Provide a drag-and-drop course-structure admin builder.
- Reorder lessons and reassign categories inline.
- Count course videos, questions, homework and articles for display.
- Restrict the "my courses" view to the user's accessible courses.
- Add a "go to last lesson" link field in Views.
- Restrict a Views display to enrolled students.
- Provide a newsletter-style subscribe endpoint.
- Use a Twig filter to format lesson length as hours/minutes.
