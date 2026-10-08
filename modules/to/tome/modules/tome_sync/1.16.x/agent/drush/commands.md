<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Tome Sync Drush commands

| Command | Purpose | Options |
|---|---|---|
| `drush tome:export` | Export ALL config, content, and files to disk (initial export). | `--process-count`, `--entity-count`, `-y` |
| `drush tome:import` | Import ALL config, content, and files from disk (after `drush si <profile> -y`). | `--process-count`, `--entity-count`, `-y` |
| `drush tome:import-partial` | Import only content/config/files that changed (uses `tome_sync_content_hash`). | `--process-count`, `--entity-count`, `-y` |
| `drush tome:export-content <type:id>[,<type:id>...]` | Export specific entities, e.g. `node:1`, `user:1`. Writes `<content_dir>/<type>.<uuid>.json`. | — |
| `drush tome:import-content <type:uuid:langcode>[,...]` | Import specific content items (note: uuid + langcode, not numeric id). | — |
| `drush tome:delete-content <type:id[:langcode]>[,...]` | Delete content / remove translations from the export. | — |
| `drush tome:import-complete` | Fire the `tome_sync.import_all` event (post-import hooks). | — |
| `drush tome:clean-files [-y]` | Delete exported files no longer referenced by any content/config. | `-y` |

Notes:
- After the initial `tome:export`, you normally never run it again — entity CRUD hooks keep the
  export current automatically.
- `tome:export` / `tome:import` fan out across worker subprocesses (via `tome_base`), invoking
  `tome:export-content` / `tome:import-content` per chunk.
