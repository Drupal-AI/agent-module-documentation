Anu LMS is a Drupal learning management system — courses, modules, lessons and quizzes — whose learner UI is a progressively decoupled React application fed by recursive REST serialisation.

---

Anu LMS models e-learning content as a tree of standard Drupal entities: a `course` node references `course_modules` paragraphs, each module references `module_lesson` (and, with the Quizzes submodule, `module_assessment`) nodes, and each lesson is built from nested `lesson_section` → content paragraphs (text, headings, images, audio, video embeds, checklists, tables, resource downloads, footnotes, highlights, and inline questions). Editors assemble this with Paragraphs, Inline Entity Form, Paragraphs Browser and Field Group; the `anu_lms.entity_labels` config lets a site rename and pluralise every entity type (Course, Module, Lesson, Quiz, Courses page) including translations.

At view time the module replaces the node canonical controller (`AnulmsNodeViewController`, wired by `RouteSubscriber`) for its own bundles, runs a matching `AnuLmsContentType` plugin to build a JSON payload, and prints it into a `<div id="anu-application" data-application="...">` element that the bundled React app (`js/dist/*.min.js` libraries) hydrates. The payload is produced by `anu_lms.normalizer` (the `Normalizer` service), which serialises the whole entity tree in one pass via `rest_entity_recursive`'s `json_recursive` format with per-entity-type field exclusions, a configurable max depth, and per-user cached output. Progress is tracked in a custom `anu_lms_progress` table (uid/nid), and courses/lessons/categories can enforce linear (sequential) unlocking. Two cookie-authenticated REST endpoints let the front end persist state: `/anu_lms/progress` (mark lessons complete) and `/anu_lms/lesson/checklist` (save/read checklist selections). Optional submodules add quizzes (`anu_lms_assessments`), organisation-scoped access with Group (`anu_lms_permissions`), Search API full-text search (`anu_lms_search`), demo content, and three example extension modules.

The module carries a heavy contrib dependency chain — `rest_entity_recursive`/`rest_paragraphs_recursive`, `eck`, `paragraphs`, `paragraphs_browser`, `paragraphs_selection`, `inline_entity_form`, `field_group`, `allowed_formats`, `weight` — plus core `ckeditor5`, `media_library`, `rest` and `taxonomy`, and applies Composer patches to core, `entity_reference_revisions` and `paragraphs_browser`. Confirm those dependencies resolve for your Drupal minor before adopting it. Offline support is opt-in via the `pwa` module (a service worker settings endpoint and audio-caching hook are provided), and multilingual (including RTL) content is supported throughout.

---

- Run an online course catalogue with a decoupled, app-like learner experience on Drupal.
- Author courses as modules → lessons → sections using Paragraphs and Inline Entity Form.
- Build rich lesson pages with text, headings, images, wide/thumbnail images, audio, embedded video, checklists, tables, footnotes, highlights and resource downloads.
- Add end-of-module quizzes with single/multiple choice, scale, and short/long free-text questions (via `anu_lms_assessments`).
- Add inline self-check questions inside a lesson that reveal the correct answer immediately.
- Enforce linear lesson progress so a lesson unlocks only after the previous one is completed.
- Enforce linear course progress so courses in a category must be completed in sequence.
- Track per-user completion in the `anu_lms_progress` table without content entities.
- Rename and pluralise every entity label (Course/Module/Lesson/Quiz/Courses page) per site and per language at `/admin/config/anu_lms/entity_labels`.
- Serialise a full lesson or course tree in a single response to avoid a REST request waterfall in the UI.
- Serve courses pages that filter courses by category and topic taxonomies.
- Scope courses and members to organisations (Groups) with teacher/student separation (via `anu_lms_permissions`).
- Give teachers per-lesson question-response and per-quiz result review pages, with XLS export.
- Add full-text search across LMS content with Search API (via `anu_lms_search`).
- Make courses available offline as a Progressive Web App by enabling `pwa` (audio paragraphs get cached too).
- Seed a demo catalogue that exercises every paragraph type for evaluation (via `anu_lms_demo_content`).
- Show or hide a block only on Anu LMS pages using the "Anu LMS pages" visibility condition.
- Extend the lesson/courses-page payload with custom data via `CoursesPageDataGeneratedEvent` / `LessonPageDataGeneratedEvent`.
- React to lesson completion with `LessonCompletedEvent` (e.g. issue certificates, notify).
- Override the compiled React components or swap in a custom paragraph type using the example submodules.
- Support multilingual and right-to-left course content.
