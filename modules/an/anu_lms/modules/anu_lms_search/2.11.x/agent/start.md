<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Anu LMS Search (anu_lms_search) — agent index

Submodule of **anu_lms**. Full-text search over LMS content via **Search API** + DB backend.
Package `Anu LMS`. Core `^10 || ^11`. Version 2.11.2. Depends on `anu_lms`, `search_api`,
`search_api_db`. No own permissions or config schema; ships feature-exported config (`config/install`,
including the search index and results view).

## What it provides (`anu_lms_search.module`, `src/`)

- **Computed field** `module_title` on `module_lesson` nodes — `hook_entity_bundle_field_info` adds a
  computed string base field backed by `ModuleTitleItemList` (`src/ModuleTitleItemList.php`,
  `ComputedItemListTrait`). It uses `anu_lms.lesson`→`getLessonModule()` to find the owning
  `course_modules` paragraph and exposes `field_module_title` **only when this lesson is the module's
  first lesson**, so the module name is indexed once.
- **Reindex on title change** — `hook_ENTITY_TYPE_update` (`anu_lms_search_paragraph_update`) on a
  `course_modules` paragraph compares old/new `field_module_title` and calls
  `search_api_entity_update()` on the first lesson.
- **Themed exposed form** — `hook_form_views_exposed_form_alter` styles the
  `anu-lms-search-search-results-page` form ("Search LMS content" placeholder, hidden submit,
  `anu_lms_search/search` CSS). `hook_theme` registers exposed-form and view-fields templates
  (`templates/`).
- **Library** `anu_lms_search/search` → `css/search.css`.

## Operate

Enable, then index: cron or `drush search-api:index`. The results view ships as config; link it from
navigation. No REST, services, or controllers here.
