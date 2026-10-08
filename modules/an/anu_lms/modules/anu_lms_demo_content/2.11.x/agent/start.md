<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Anu LMS Demo content (anu_lms_demo_content) — agent index

Submodule of **anu_lms**. Install-time demo content generator. Package `Anu LMS`.
Core `^10 || ^11`. Version 2.11.2. Depends only on `anu_lms`. No routes, services, permissions,
config or entities of its own — just install/uninstall logic in `anu_lms_demo_content.install`.

## What it does

- `anu_lms_demo_content_modules_installed($modules, $is_syncing)` (guards on itself) builds a demo
  catalogue:
  - `anu_lms_demo_create_course_categories()` / `_course_labels()` — 2 `course_category` +
    2 `course_label` taxonomy terms.
  - `anu_lms_demo_create_courses_landing_page()` — a `courses_landing_page` node filtered by the
    categories.
  - `anu_lms_demo_create_course_for_testing_paragraphs()` — a course with one `module_lesson` per
    paragraph type (headings, text/footnotes, lists, images, highlights, dividers, embedded video,
    checklist, table), each wrapped in a `lesson_section`.
  - `anu_lms_demo_create_course_for_testing_navigation()` — a course with multiple modules/lessons/sections.
  - `anu_lms_demo_create_cover_image()` — writes `anu-logo.png` to `public://` via `file.repository`.
- `anu_lms_demo_content_create_entities($data, $type)` — generic create helper; records every created
  id under Drupal state key `anu_lms_demo_content.entities`.
- `hook_uninstall` — loads and deletes all recorded entities, then clears the state key.

## Notes

- Evaluation/testing only; not for production. Adds/removes content idempotently via state tracking.
- Uses `FileExists::Replace` and `DeprecationHelper::backwardsCompatibleCall` for 10.1+/11 compatibility.
