# Drush commands

Class `Drupal\media_library_importer\Commands\MediaLibraryImporterCommands` (registered via
`drush.services.yml`).

| Command | Alias | Effect |
|---|---|---|
| `media-library:import` | `mli` | Calls `generateImportQueue()` (all configured folders), then if the queue is non-empty runs it as a non-progressive batch (`queue_ui.batch` step over `media_library_importer`). Prints a warning when there is nothing to import. |

```bash
ddev drush media-library:import
ddev drush mli
```

Honors the same `media_library_importer.settings` config as the UI (import folder, selected media types + field
mapping, copy-vs-in-place, exclude styles). Idempotent — files already imported (bundle + filename) are skipped.
No command options; scope the import by adjusting `import_folder` / selected media types in config first.
