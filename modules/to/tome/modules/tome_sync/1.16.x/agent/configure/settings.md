<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Tome Sync — settings, file handling, UI, permission

**No config object / no `configure` route.** Use `settings.php` + an optional services override.

## settings.php keys (via Settings::get, relative to the Drupal root)
| Key | Default | Meaning |
|---|---|---|
| `tome_content_directory` | `../content` | Where content JSON is written (plus `meta/index.json`). |
| `tome_files_directory` | `../files` | Where managed files are exported (`/public` subdir for public files). |
| `tome_sync_encoder` | `json` | Content encoder; `yaml` available but experimental (chosen in `TomeSyncServiceProvider`). |
| `tome_book_outline_directory` | `../extra` | Book outline export directory (with the Book module). |

## Overriding file handling
`tome_sync.file_sync` (`FileSync`) copies/deletes files to keep the export and public files in
sync. To skip that (e.g. you symlink the files dir or use persistent storage), override it in
your site `services.yml`:
```
services:
  tome_sync.file_sync:
    class: Drupal\tome_sync\NullFileSync
```

## Admin UI (permission: `use tome sync`, restrict access: true)
Menu root `/admin/config/tome/sync` (`tome_sync.main`):
- `/admin/config/tome/sync/import-partial` — ImportPartialForm (sync changed content/files).
- `/admin/config/tome/sync/clean-files` — CleanFilesForm (delete unused files).

## Schema note
`tome_sync` provides no config schema, but it does define an install schema table
`tome_sync_content_hash` (content name → sha1 hash) used by `tome:import-partial`.
