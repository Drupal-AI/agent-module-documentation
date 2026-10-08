<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# TrinionCourse (trinion_suo) — agent index
**Online-course / LMS: courses, lessons, tests, progress tracking and purchase-driven access.**

- **Version:** 1.0.x
- **Core:** ^9 || ^10 || ^11
- **Depends:** comment, inline_entity_form, trinion_cart
- **Routes:** `/complete_lesson/{node}` (perm `access content`, bundle `urok_kursa`); `/node/{node}/course-structure` (perm `edit any kurs_obucheniya content`).
- **REST:** `mark_lesson_rest_resource` GET `/lesson-complete/{id}`; `subscription_rest_resource` POST `/subscribe`.
- **Services:** `trinion_suo.course` (structure/access/progress), student access-check `access_check.trinion_suo.is_student`, backend theme negotiator, Twig extension, `PaymentEvent` subscriber (grants access on payment).
- **Access:** lesson view via `hook_node_access` → `Course::checkLessonAccess()` (free lesson or `field_ts_course_access` match).

**Access:** Lesson access enforced per course purchase. `/complete_lesson` is gated by `access content` and only affects the caller's own completion list; REST resource access is governed by REST config permissions.

See [api/lms.md](api/lms.md).
