<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Anu LMS REST endpoints (base module)

Two `@RestResource` plugins in `src/Plugin/rest/resource/`. Both are enabled by
`config/install/rest.resource.*.yml`: format `json`, authentication `cookie`. Because the
authentication is cookie-based, Drupal core requires a valid `X-CSRF-Token`
(`/session/token`) on the write (POST) methods, and each method needs the corresponding
`restful …` permission granted to the caller's role.

## `anu_lms_progress` — POST `/anu_lms/progress`

Class `Progress`. Marks lessons/quizzes complete for the current user.

- Permission: `restful post anu_lms_progress`. Config methods: `POST` only.
- Body: a flat array of node IDs, e.g. `[123, 124]`. Max **100** items (else 406). Anonymous users
  are rejected with 406 (`NotAcceptableHttpException` "Progress for anonymous users is not supported").
- Loads the nodes, and for each whose bundle is `module_lesson` or `module_assessment` calls
  `anu_lms.lesson`→`setCompleted($nid)` (upsert into `anu_lms_progress`, dispatch
  `LessonCompletedEvent` on first insert). Non-numeric / empty values are filtered out.
- Response: `{"lessons": [<ids actually marked>]}`.

## `anu_lms_lesson_checklist` — GET + POST `/anu_lms/lesson/checklist`

Class `LessonChecklist`. Reads/saves a user's selections for a `lesson_checklist` paragraph, stored as
an ECK `lesson_checklist_result` entity (bundle `lesson_checklist_result`).

- Permissions: `restful get anu_lms_lesson_checklist`, `restful post anu_lms_lesson_checklist`.
- **GET** `?checklist_paragraph_id=<pid>` (400 if missing): finds the current user's most recent
  `lesson_checklist_result` for that paragraph (`condition('uid', currentUser)`), and returns it
  **only if `->access('view')`** passes, normalized at max_depth 1. Cache-tagged
  `lesson_checklist_result:<pid>`.
- **POST** body `{"checklist_paragraph_id": <pid>, "selected_option_ids": [<option pids>]}`
  (406 if missing): loads the paragraph (must be bundle `lesson_checklist`), finds or creates the
  user's result entity, and requires `$entity->access('update')` before saving the selected
  `checklist_item` options into `field_checklist_selected_options`. Returns `{"lesson_checklist_id": <id>}`.
- Uses a `dontSave` flag on paragraphs (relies on the `entity_reference_revisions` "do not resave
  field item" patch declared in `composer.json`) to avoid mutating the source paragraph's `parent_id`.

## Notes

- Both endpoints re-check entity access (`access('view')` / `access('update')`) inside the handler,
  and the progress endpoint restricts to LMS bundles — the surface is per-user state, not content.
- The service worker settings route `/anu_lms/sw-settings` is a plain controller (`_access: TRUE`),
  not a REST resource; it exposes only the PWA cache-version string.
