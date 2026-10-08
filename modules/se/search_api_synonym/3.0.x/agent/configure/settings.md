# Search API Synonym — entity, admin list & settings

## The synonym entity
`search_api_synonym` (ContentEntity, `src/Entity/Synonym.php`). Fields:
- `word` — the base term (entity label).
- `synonyms` — the equivalent term(s).
- `type` — `synonym` or `spelling_error`.
- `langcode` — language of the record.

Admin permission `administer search api synonyms`. Managed via a Views list
(`config/install/views.view.search_api_synonym.yml`).

## Routes (`search_api_synonym.routing.yml`)
| Route | Path | Permission |
|---|---|---|
| `entity.search_api_synonym.collection` | `/admin/config/search/search-api-synonyms` | `administer search api synonyms` |
| `.add_form` / `.canonical` / `.edit_form` / `.delete_form` | `.../add`, `.../{id}`, `.../{id}/edit`, `.../{id}/delete` | `administer search api synonyms` |
| `.settings` | `.../settings` | `administer search api synonym configuration` |
| `.import` | `.../import` | `import search api synonyms` |
| `search_api_synonym.delete_all_synonyms` | `.../delete-all` | `administer search api synonyms` |

## Export / cron settings
Form `entity.search_api_synonym.settings` → `.../settings` (`SynonymSettingsForm`). Config object
`search_api_synonym.settings` (schema `config/schema/search_api_synonym.schema.yml`; install defaults
in `config/install/search_api_synonym.settings.yml`):
```yaml
cron:
  plugin: solr            # export plugin machine name
  interval: 86400         # seconds between cron exports
  type: all               # all | synonym | spelling_error
  filter: none            # nospace | onlyspace | all
  separate_files: 1       # write separate files per type/language
  export_if_changed: 1    # only re-export if synonyms changed since last run
  # file_export_location  # directory/stream for the generated file(s)
```
The Solr export plugin writes a synonyms text file to the configured location on cron (and on demand
via Drush). `file_export_location` is admin-set config.

Drush config helpers:
```
drush cget search_api_synonym.settings
```
