<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Hacked! — agent index

Detects whether Drupal core / contrib projects have been **changed from their official
release** by re-downloading each release and comparing file hashes. Report at
`/admin/reports/hacked`; also on the CLI. Depends on core's `update` module. It only
**reports** drift — it never edits or reverts code. Configure route: `hacked.settings`.

- **The one setting (file hasher) and the report/settings routes** →
  [configure/settings.md](configure/settings.md)
- **Drush commands (`hacked:list-projects`, `hacked:details`, `hacked:diff`)** →
  [drush/commands.md](drush/commands.md)
- **How it works + the `hook_hacked_file_hashers_info()` hook to add a hasher** →
  [api/mechanism.md](api/mechanism.md)
- **Permissions** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Only config: `hacked.settings` → `selected_file_hasher`
  (`hacked_ignore_line_endings` default, or `hacked_include_line_endings`).
- Project status constants: Unchanged / Changed / Unchecked, with per-file
  different/missing counts.
- Report cached in the dedicated `hacked` cache bin for ~1 day; rebuild at
  `/admin/reports/hacked/check` or with `--force-rebuild`.
