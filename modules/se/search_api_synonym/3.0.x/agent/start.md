# Search API Synonym — agent index

Manages search synonyms & spelling errors as `search_api_synonym` content entities and exports them
to a search-backend format (Solr synonyms file by default). Pluggable import (CSV/JSON/Solr) and
export (Solr) formats. Depends on `options` + `views`. Configure route
`entity.search_api_synonym.collection` (`/admin/config/search/search-api-synonyms`).

- **The synonym entity, admin list, and export settings/cron config** → [configure/settings.md](configure/settings.md)
- **Import & export plugin types and how to add one; the built-in plugins** → [plugins/import-export.md](plugins/import-export.md)
- **The `search-api-synonym:export` Drush command** → [drush/export.md](drush/export.md)
- **Permissions** → [permissions/permissions.md](permissions/permissions.md)
- **`hook_search_api_synonym_synonyms_file_saved()`** → [hooks/hooks.md](hooks/hooks.md)

Key facts:
- Entity `search_api_synonym` (ContentEntity): fields `word`, `synonyms`, `type`
  (`synonym`|`spelling_error`), `langcode`; admin permission `administer search api synonyms`.
- Plugin managers: `plugin.manager.search_api_synonym.import` / `.export`.
- Drush class `src/Command/SynonymDrushCommands.php` (do NOT use the removed `ExportDrupalCommand`).
