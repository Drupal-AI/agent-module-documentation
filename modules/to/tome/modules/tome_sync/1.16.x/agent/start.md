<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Tome Sync — agent index

Serialises content, config, and files to flat files (`<entity_type>.<uuid>.json` in
`tome_content_directory`, default `../content`) and keeps them in sync as you edit. Depends on
`file`, `serialization`, `user`, `tome_base`. Directories are `settings.php` keys (no config
object). Admin UI at `/admin/config/tome/sync` (permission `use tome sync`).

- **Drush commands (export, import, import-partial, export/import/delete-content, clean-files)** →
  [drush/commands.md](drush/commands.md)
- **Directories, encoder, file-sync override, permission, UI routes** →
  [configure/settings.md](configure/settings.md)
- **Events, normalizers, and the swappable file-sync service** → [api/events.md](api/events.md)

Key facts: `drush tome:export` once, then edits auto-export via entity hooks; rebuild with
`drush si` + `drush tome:import`. Partial imports use the `tome_sync_content_hash` table.
Encoder defaults to JSON (`tome_sync_encoder=yaml` for experimental YAML).
