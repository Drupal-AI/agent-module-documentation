Anu LMS Search adds full-text search across Anu LMS courses and lessons using Search API and the database backend.

---

This submodule provides a search experience over Anu LMS content built on Search API (`search_api`, `search_api_db`). It ships a feature-exported search index and a search-results view whose exposed form is themed (`views-exposed-form--anu-lms-search--search-results-page` template, a "Search LMS content" placeholder, a hidden submit button, and the `anu_lms_search/search` CSS library). To make module titles searchable, `hook_entity_bundle_field_info` adds a computed `module_title` base field to `module_lesson` nodes, backed by `ModuleTitleItemList`: it resolves the lesson's owning `course_modules` paragraph (via the base `anu_lms.lesson` service) and, only for the module's first lesson, exposes the module's `field_module_title` for indexing. `hook_ENTITY_TYPE_update` on a `course_modules` paragraph detects a changed module title and reindexes that first lesson so the index stays current.

Enable with `drush en anu_lms_search -y`, then run Search API indexing (cron or `drush search-api:index`). The search results view is provided as config and can be placed/linked in the site's navigation.

---

- Add full-text search across Anu LMS lessons and courses.
- Index lesson content with the Search API database backend (no external search server required).
- Include the owning module's title in the first lesson's search index so module names are findable.
- Keep the index current: reindex a module's first lesson when the module title changes.
- Present a themed, placeholder-driven search form for LMS content.
- Provide a ready-made search-results view as exportable config.
- Extend search relevance by adding the computed `module_title` field to Search API index fields.
- Run search entirely on the local database for small/medium catalogues.
