<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Anu LMS architecture — rendering pipeline, normalizer, progress

Read this instead of the ~10 service classes when you need how a page is built and progress works.

## Node view → React payload

1. `Routing\RouteSubscriber::alterRoutes()` overrides `entity.node.canonical` `_controller` to
   `AnulmsNodeViewController::view`, sets `node.add` `_title_callback` to `NodeTitle::label`
   (localised labels), and marks `view.sort_courses.sort_page` as an admin route.
2. `Controller\AnulmsNodeViewController::view()` (extends core `NodeViewController`): if the bundle
   has no `anu_lms_content_type` plugin it defers to core. Otherwise it instantiates the plugin,
   calls `$plugin->getData($node)`, and:
   - if the result is a `RedirectResponse` or has `#markup`, returns it directly (course → first
     lesson redirect, or "locked"/"no lessons" markup);
   - else builds `<div id="anu-application" data-application="{json}" data-permissions="{json}"
     data-entity_labels="{json}">`, attaches `$plugin->getAttachments()` (a JS library), and sets
     `#cache['max-age'] = 0` (page cache disabled).
3. The compiled React app (`anu_lms/vendors` + `courses|courses_landing|lesson`, `js/dist/*.min.js`,
   `anu_lms.libraries.yml`) reads `#anu-application` and renders the UI.

## AnuLmsContentType plugins (`src/Plugin/AnuLmsContentType/`)

Plugin type: manager `AnuLmsContentTypePluginManager` (parent `default_plugin_manager`), annotation
`Annotation\AnuLmsContentType`, interface `AnuLmsContentTypeInterface`, base
`AnuLmsContentTypePluginBase` (`getAttachments()` defaults to `anu_lms/lesson`, `label()`).

- `Course` (id `course`): if `CourseProgress::isLocked()` → `#markup` "locked"; else redirect to
  `Course::getFirstAccessibleLesson()`; else "no lessons" markup.
- `ModuleLesson` (id `module_lesson`): payload = normalized lesson (max_depth 4) + normalized course
  (max_depth 2) with `progress` + `courses_page_urls_by_course`; dispatches `LessonPageDataGeneratedEvent`.
- `CoursesPage` (id `courses_page`): loads courses by the page's `course_category` paragraphs, normalizes
  each (max_depth 1), attaches `progress`/`locked`; dispatches `CoursesPageDataGeneratedEvent`;
  attaches `anu_lms/courses`.
- `CoursesLandingPage` (id `courses_landing_page`): filters courses by selected category/topic taxonomies
  (the big documented decision table in `getData()`); attaches `anu_lms/courses_landing`.
- `Quiz` (id `module_assessment`, in `anu_lms_assessments`): extends `ModuleLesson`; throws 403 if
  `Quiz::isRestricted()`, then appends prior-submission data via `Quiz::getQuizSubmissionData()`.

## Normalizer (`src/Normalizer.php`, service `anu_lms.normalizer`)

`normalizeEntity(EntityInterface $entity, array $context)`:
- re-checks `$entity->access('view')` (returns NULL if denied) — a second access gate on top of the
  controller/route;
- serialises with Symfony serializer format `json_recursive` (provided by `rest_entity_recursive`),
  default max depth 10, callers pass `max_depth` 1–4;
- default context excludes noisy/internal fields per entity type (`user`, `node`, `paragraph`,
  `taxonomy_term`) to keep the client payload small (see the `exclude_fields` lists in `Normalizer`);
- translates via `entity.repository` then caches the normalized array in `cache.default` keyed by
  `anu_lms:<type>:<id>:<max_depth>` + `languages:interface` + `user.permissions`
  (+ `user.group_permissions` if `anu_lms_permissions` enabled), with the collected cache tags/max-age.

Tagged normalizers (priority 11–13): `CourseNormalizer`, `LessonNormalizer`, `CoursesPageNormalizer`
(shape each node type's output), `ImageFileNormalizer`/`ImageItemNormalizer` (add absolute file URLs +
image-style derivatives). See `src/Normalizer/`.

## Progress & linear locking (`Course`, `Lesson`, `CourseProgress`)

- `anu_lms_progress` table (uid, nid, created, changed; PK uid+nid) — `hook_schema` in `anu_lms.install`.
- `Lesson::setCompleted($nid)` — no-op for anonymous; `MERGE` upsert; dispatches `LessonCompletedEvent`
  only on first insert (`Merge::STATUS_INSERT`).
- `Lesson::isCompleted()` / `isRestricted()` — only meaningful when the lesson's course has
  `field_course_linear_progress`; a lesson is restricted unless it is first or the previous is completed.
- `CourseProgress::getCourseProgress()` builds the per-lesson prev/next/completed/restricted/url map
  the client uses. `isLocked()` locks a course whose predecessor in a sequenced category is unfinished.
- `Course` helpers filter lessons/quizzes by `$node->access('view')` throughout, so per-node access
  (incl. `anu_lms_node_access`, which forbids a lesson when its course is not viewable) is honoured.

## Access & node overrides (`anu_lms.module`)

- `hook_node_access` (`module_lesson`) and `anu_lms_assessments_node_access` (`module_assessment`):
  forbid `view` when the owning course is not viewable.
- Cascade delete (`anu_lms_node_delete`), auto-enable linear progress from category
  (`anu_lms_node_presave` + widget lock), auto-append an empty `lesson_section` on new lesson
  (`hook_entity_insert`), many label/IEF/field-group `hook_*_alter`.

## Offline / PWA

- `Settings::isOfflineSupported()` = `pwa` enabled. `ServiceWorkerController::settings()`
  (`/anu_lms/sw-settings`, `_access: TRUE`) emits `self.drupalSettings = {current_cache: ...}` as JS and
  fires `hook_anu_lms_sw_settings_alter`. `hook_anu_lms_sw_scripts_alter` injects
  `js/dist/serviceworker.min.js` only if any `lesson_audio` paragraph exists. `PWAResponseSubscriber`
  adjusts PWA responses. Course/CoursesPage services expose lesson/quiz/audio URLs for caching.
