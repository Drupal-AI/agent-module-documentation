# Search API Synonym — Drush

Class `src/Command/SynonymDrushCommands.php` (registered via `drush.services.yml`, tag
`drush.command`). One command.

> Do NOT reference `ExportDrupalCommand` — that Drupal Console command file was removed on disk (it
> caused a fatal). The `search_api_synonym.command.export` service entry in `search_api_synonym.services.yml`
> is a leftover Console (`drupal.command`) tag and is inert unless drupal/console is installed.

## `search-api-synonym:export`
Aliases: `sapi-syn:export`, `sapi-syn-ex`. Exports synonyms to a format and writes the file.

Options:
| Option | Values / default | Meaning |
|---|---|---|
| `--plugin` | export plugin machine name, e.g. `solr` | Which export format (validated against available plugins). |
| `--langcode` | e.g. `en`, `da` (required) | Language to export. |
| `--type` | `synonym` \| `spelling_error` \| `all` (default `all`) | Which records to export. |
| `--filter` | `nospace` \| `onlyspace` \| `all` (default `all`) | Skip terms with/without spaces. |
| `--incremental` | Unix timestamp (default 0) | Only export synonyms changed after this time. |
| `--file` | filename incl. extension (no folder) | Output filename. |

Example:
```
drush search-api-synonym:export --plugin=solr --langcode=da --type=spelling_error --filter=all
```
On success it prints the path of the saved file. Invalid `--plugin`, empty `--langcode`, or bad
`--type`/`--filter` throw an exception. Internally it calls `ExportPluginManager::setPluginId()` +
`setExportOptions()` + `executeExport()`.
