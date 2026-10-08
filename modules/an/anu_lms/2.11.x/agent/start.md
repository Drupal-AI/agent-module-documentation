<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Anu LMS (anu_lms) — agent index

Progressively **decoupled** learning management system. Content is standard Drupal entities
(nodes + Paragraphs + an ECK entity); the learner UI is a bundled **React** app hydrated from a
JSON blob printed on the node page. Package `Anu LMS`. Core `^10 || ^11`. Version 2.11.2.
License GPL-2.0-or-later. `configure` route `anu_lms.entity_labels`.

Heavy dependency chain (info.yml): `allowed_formats`, core `ckeditor5` `image` `link`
`media_library` `options` `path` `rest` `taxonomy`, `eck`, `field_group`,
`inline_entity_form`, `paragraphs`, `paragraphs_selection`, `paragraphs_browser`,
`rest_paragraphs_recursive` (from `rest_entity_recursive`), `weight`. Composer also patches
core, `entity_reference_revisions` and `paragraphs_browser`. Suggests `pwa` for offline.

## Content model (config/install/)

- Node bundles: `course`, `module_lesson`, `courses_page` (deprecated flat page),
  `courses_landing_page` (filtered page), plus `module_assessment` from the Quizzes submodule.
- Paragraph bundles: `course_modules` (module: title + `field_module_lessons`), `course_category`,
  `lesson_section`, and content paragraphs (`lesson_text`, `lesson_heading`, `lesson_image[_wide|_thumbnail]`,
  `lesson_audio`, `lesson_embedded_video`, `lesson_list`, `lesson_img_list[_item]`, `lesson_table`,
  `lesson_checklist` + `checklist_item`, `lesson_footnotes`, `lesson_highlight[_marker]`,
  `lesson_divider`, `lesson_resource`).
- ECK entity `lesson_checklist_result` stores a user's checklist selections.
- Taxonomies: `course_category` (has `field_enable_course_sequence`), `course_topics`, `course_label`.
- Custom DB table `anu_lms_progress` (uid, nid, created, changed) — see `anu_lms.install` `hook_schema`.

## What it provides

- **Plugin type** `anu_lms_content_type` — manager `AnuLmsContentTypePluginManager`, annotation
  `@AnuLmsContentType`, base `AnuLmsContentTypePluginBase`. Plugins (`src/Plugin/AnuLmsContentType/`):
  `Course`, `CoursesPage`, `CoursesLandingPage`, `ModuleLesson` (+ `Quiz` in the submodule). Each
  `getData()` builds the React payload for its bundle.
- **Services** (`anu_lms.services.yml`): `anu_lms.settings` (labels/PWA/permissions), `anu_lms.course`,
  `anu_lms.lesson`, `anu_lms.course_progress`, `anu_lms.courses_page`, `anu_lms.normalizer`
  (recursive serialiser with per-user cache), tagged normalizers (`CourseNormalizer`,
  `LessonNormalizer`, `CoursesPageNormalizer`, `ImageFileNormalizer`, `ImageItemNormalizer`),
  `RouteSubscriber`, `PWAResponseSubscriber`, `anu-lms://` read-only stream wrapper.
- **REST resources** (`src/Plugin/rest/resource/`): `Progress` (POST `/anu_lms/progress`),
  `LessonChecklist` (GET+POST `/anu_lms/lesson/checklist`). Both cookie auth, JSON. → [api/rest.md](api/rest.md)
- **Routes** (`anu_lms.routing.yml`): `anu_lms.entity_labels` (labels form), `anu_lms.admin_index`,
  `anu_lms.course.finish` (`/node/{node}/finish`, deprecated, `_entity_access: node.view`),
  `anu_lms.service_worker_settings` (`/anu_lms/sw-settings`, `_access: TRUE`, emits PWA cache JS).
- **Permission**: `administer anu lms configuration`.
- **Condition plugin** `anu_lms_pages` (`src/Plugin/Condition/AnuLmsPages.php`) — block visibility on LMS bundles.
- **Events**: `LessonCompletedEvent`, `CoursesPageDataGeneratedEvent`, `LessonPageDataGeneratedEvent`.

## Rendering pipeline & config → [architecture.md](architecture.md), [config/settings.md](config/settings.md)

`RouteSubscriber` re-points `entity.node.canonical` to `AnulmsNodeViewController::view`, which for an
LMS bundle runs the content-type plugin, JSON-encodes the payload into `#anu-application` and attaches
the React library (`anu_lms/courses|courses_landing|lesson` + `vendors`). Page cache is disabled
(`#cache max-age 0`). `Normalizer::normalizeEntity()` re-checks `$entity->access('view')`, serialises
via `json_recursive` (default max depth 10, per-call overrides 1–4) and caches per
`languages` + `user.permissions` (+ `user.group_permissions` when `anu_lms_permissions` is on).

## Submodules (own doc trees under `../modules/<name>/2.11.x/`)

- **anu_lms_assessments** — quizzes: `module_assessment` node, `assessment_question` /
  `assessment_question_result` / `assessment_result` entities, two REST endpoints, teacher result pages.
- **anu_lms_permissions** — Group-based organisation scoping (`anu_organization` group type), `/organizations`.
- **anu_lms_search** — Search API full-text search + computed `module_title` index field.
- **anu_lms_demo_content** — `hook_modules_installed` seeds demo courses; removed on uninstall.
- **anu_lms_custom_page_data**, **anu_lms_custom_paragraph**, **anu_lms_override_component** — example extensions.

## Notes / caveats

- `.module` uses `// phpcs:ignoreFile`; extensive `hook_*_alter` for labels/IEF/field-group UX.
- `anu_lms_node_delete` cascades: deleting a `course` deletes its modules' referenced lessons/quizzes.
- `anu_lms_node_presave` forces `field_course_linear_progress = TRUE` when a course's category has
  `field_enable_course_sequence` on; that checkbox is then disabled in the widget.
- Anonymous users are never tracked (`Lesson::setCompleted` returns early); progress needs a real user.
- Depends on `rest_entity_recursive` — verify it ships a release compatible with your core minor,
  since a normalizer signature mismatch there can fatal on class load independently of Anu.
