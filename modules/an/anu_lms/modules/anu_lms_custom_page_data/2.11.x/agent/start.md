<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Anu LMS Example: Custom page data (anu_lms_custom_page_data) — agent index

Example submodule of **anu_lms** (package `Anu LMS Examples`). Shows how to enrich the decoupled page
payload with events. Core `^10 || ^11`. Version 2.11.2. Depends only on `anu_lms`.

## What it provides

- Service `anu_lms_custom_page_data.event_subscriber` → `EventSubscriber\CustomPageDataSubscriber`
  (`arguments: ['@messenger']`).
- Subscribes to:
  - `anu_lms_courses_page_data_generated` → `onCoursesDataGenerated()` — adds
    `$data['additional-example-data'] = 'test'`, status message with course count.
  - `anu_lms_lesson_page_data_generated` → `onLessonDataGenerated()` — adds
    `$data['lesson-example-data'] = 'test'`.
- Pattern: `$data = $event->getPageData(); …; $event->setPageData($data);`. Events are dispatched by the
  base content-type plugins (`CoursesPage`, `CoursesLandingPage`, `ModuleLesson`) before the payload is
  embedded in `#anu-application`.

## Notes

- Template/example only — copy the subscriber into a real module for production. No config/routes/entities.
- Event classes live in the base module: `anu_lms/src/Event/{CoursesPageDataGeneratedEvent,LessonPageDataGeneratedEvent}.php`.
