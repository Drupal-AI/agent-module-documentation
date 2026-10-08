Search API Synonym manages search synonyms and common spelling errors as content entities, then exports them to a search-backend format (Solr synonyms file out of the box) so a search engine can treat related terms as equivalent. It supports bulk CSV/JSON/Solr import and pluggable import/export formats.

---

The module defines the `search_api_synonym` content entity (a synonym record: a base `word`, one or more `synonyms`, a `type` of either `synonym` or `spelling_error`, plus language), administered as a Views-backed list at `/admin/config/search/search-api-synonyms` (`configure` route `entity.search_api_synonym.collection`). It provides two plugin types: **import** (`@SearchApiSynonymImport`, manager `plugin.manager.search_api_synonym.import`, base `ImportPluginBase`, `parseFile()` + `allowedExtensions()`) with CSV, JSON and Solr plugins, and **export** (`@SearchApiSynonymExport`, manager `plugin.manager.search_api_synonym.export`, base `ExportPluginBase`, `getFormattedSynonyms()`) with a Solr plugin that writes a synonyms text file. Export is driven by a settings form (`/admin/config/search/search-api-synonyms/settings`) whose config `search_api_synonym.settings` holds a cron block (plugin, interval, type, filter, `separate_files`, `export_if_changed`, `file_export_location`) so synonyms are regenerated on cron, and by a Drush command. The import UI (`/import`, permission `import search api synonyms`) uploads a file, validates its extension against the active plugin, parses rows into synonym entities, and after a successful save invokes `hook_search_api_synonym_synonyms_file_saved($file_path)`. Permissions cover administering synonyms, administering configuration, importing, and viewing. Drush command `search-api-synonym:export` (class `SynonymDrushCommands`, aliases `sapi-syn:export` / `sapi-syn-ex`) exports synonyms for a given `--plugin`/`--langcode`/`--type`/`--filter`, with `--incremental` and `--file` options. NOTE: a stale Drupal Console command class (`ExportDrupalCommand`) was removed on disk; use the Drush command, not the Console one, and ignore the leftover `search_api_synonym.command.export` service reference (Console tags are inert without drupal/console).

---

- Define synonyms so a search for one term also matches equivalent terms (e.g. "car" ↔ "automobile").
- Register common misspellings as `spelling_error` records so misspelled queries still match.
- Manage synonyms per language for a multilingual search index.
- Export all synonyms to a Solr synonyms file for a Solr-backed Search API index.
- Regenerate the synonyms file automatically on cron at a configurable interval.
- Only re-export when synonyms changed since the last run (`export_if_changed`).
- Split exports into separate files per type/language (`separate_files`).
- Bulk-import synonyms from a CSV file (`word,synonym,type`).
- Bulk-import synonyms from a JSON file.
- Import an existing Solr synonyms text file into the entity store.
- Export from the command line via `drush search-api-synonym:export`.
- Do an incremental export of only synonyms changed after a Unix timestamp (`--incremental`).
- Export only synonyms or only spelling errors (`--type`), or filter by whether terms contain spaces (`--filter`).
- Browse, add, edit and delete synonyms through the admin Views list.
- Grant a limited role permission to import synonyms without full config access.
- React after a synonyms file is written with `hook_search_api_synonym_synonyms_file_saved()`.
- Add a custom import format by implementing a `@SearchApiSynonymImport` plugin.
- Add a custom export format (e.g. for another search engine) via a `@SearchApiSynonymExport` plugin.
- Bulk-delete all synonyms from the "Delete all" admin action.
- Seed a search index's synonym dictionary from the shipped example CSV/JSON/Solr files.
