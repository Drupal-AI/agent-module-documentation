<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Anu LMS — install, configuration, routes & permissions

## Install & enable

```bash
composer require drupal/anu_lms
drush en anu_lms -y
```

Pulls a large dependency chain (see start.md) and applies Composer patches to `drupal/core`,
`drupal/entity_reference_revisions`, `drupal/paragraphs_browser` (declared in `composer.json`
`extra.patches`; needs `cweagans/composer-patches`). Enabling installs the full content model from
`config/install/` (node/paragraph bundles, fields, image styles, the `sort_courses` view, two REST
resources, the ECK `lesson_checklist_result` entity type). `post_update` /`hook_update_N` steps also
install `paragraphs_selection` and `paragraphs_browser` and seed default entity labels.

Submodules are enabled separately: `drush en anu_lms_assessments anu_lms_search
anu_lms_permissions anu_lms_demo_content -y` (each has its own dependencies).

## The only config object: `anu_lms.entity_labels`

Schema `config/schema/anu_lms.schema.yml` (`config_object`), all keys `type: text`,
`translatable: true`. Install defaults in `config/install/anu_lms.entity_labels.yml`:

| key | default |
|---|---|
| `courses_page_labels` | `Courses page\|Courses pages` |
| `courses_page_label_plural` | `Courses pages` |
| `course_labels` | `Course\|Courses` |
| `course_label_plural` | `Courses` |
| `lesson_labels` | `Lesson\|Lessons` |
| `lesson_label_plural` | `Lessons` |
| `assessment_labels` | `Quiz\|Quizzes` |
| `assessment_label_plural` | `Quizzes` |
| `module_labels` | `Module\|Modules` |
| `module_label_plural` | `Modules` |

`*_labels` use ICU/CLDR `singular|plural` (extra cardinal forms per language) resolved via
Symfony `IdentityTranslator`; `*_label_plural` is the amount-less plural. Edited at
**`/admin/config/anu_lms/entity_labels`** by `Form\LabelsForm` (`ConfigFormBase`,
form id `admin_anu_lms_entity_labels`). Translatable via `config_translation`
(`anu_lms.config_translation.yml`).

`Settings` service (`src/Settings.php`, `anu_lms.settings`) consumes it:
- `getEntityLabel($entity, $plural, $count)` — resolves a stored label for one of the five known
  entity types (constants `ENTITY_TYPE_*`; `ALL_ENTITIES = [course, courses_page,
  courses_landing_page, module_lesson]`); handles a `[DEPRECATED]` marker.
- `getPhrase($phrase)` — string-replaces "Course/Lesson/Quiz/Module/Courses page" (and lowercase)
  inside UI text with the configured singular label.
- `getSettings()` returns `[]` (no runtime settings). `getPermissions()` exposes two booleans to the
  client (`view published question entities`, `restful post anu_lms_lesson_checklist`).
- `isOfflineSupported()` / `getPwaSettings()` — PWA cache-version info when `pwa` is enabled.

These labels drive the many `hook_*_alter` in `anu_lms.module` (node form titles, IEF add/existing
buttons, field-group titles, bundle labels, node-add list, `views_view_field` in the Content view).

## Routes (`anu_lms.routing.yml`)

| route | path | access | purpose |
|---|---|---|---|
| `anu_lms.entity_labels` | `/admin/config/anu_lms/entity_labels` | `administer anu lms configuration` | labels form (`configure` route) |
| `anu_lms.admin_index` | `/admin/config/anu_lms` | `administer anu lms configuration` | admin menu block page |
| `anu_lms.course.finish` | `/node/{node}/finish` | `_entity_access: node.view` | **deprecated** — marks lesson complete, redirects to finish URL (`FinishCourse::complete`) |
| `anu_lms.service_worker_settings` | `/anu_lms/sw-settings` | `_access: TRUE` | emits `self.drupalSettings = {...}` JS for the service worker (PWA cache version only) |

Menu/task links: `anu_lms.links.menu.yml`, `anu_lms.links.task.yml` (under Configuration → Anu LMS).

## Permission (`anu_lms.permissions.yml`)

- `administer anu lms configuration` — gates the labels form and admin index.

Everything else relies on core node access plus the module's `hook_node_access` (a lesson is not
viewable unless its owning course is viewable) and the REST resources' own permissions
(`restful post anu_lms_progress`, `restful get/post anu_lms_lesson_checklist`) — see
[../api/rest.md](../api/rest.md).

## Block visibility condition

`anu_lms_pages` (`src/Plugin/Condition/AnuLmsPages.php`, `#[Condition]` attribute): a "Show on Anu LMS
pages" checkbox evaluating true on bundles `course`, `courses_landing_page`, `courses_page`,
`module_lesson`, `module_assessment`. `anu_lms_form_block_form_alter` hides its context field, pins the
node context, and attaches the `anu_lms/condition` summary library.
