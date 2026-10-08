<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Config Backup (config_backup) — agent index

info.yml name: **Config Backup**. Exports the site's **active configuration** into a timestamped
`.tar.gz` archive on disk. Backup-only: the module creates archives; it does **not** provide any
download, restore, delete, list, or diff feature. Depends on core `config` (Configuration Manager).
Version 1.0.3, core `^8 || ^9 || ^10 || ^11`.

Destination directory must be set by the operator in `settings.php` as
`$settings['config_backup_directory']` — there is **no default**; if unset the module shows an error
and does nothing. The README example points it outside the webroot (`'../config/back'`).

What it provides:
- Route `config_backup.admin` → `/admin/config/development/configuration/backup` (a task/menu link under
  core's Configuration → Synchronize), form `\Drupal\config_backup\Form\ConfigBackupForm`, gated by
  permission `backup configuration` (`restrict access: true`). Submitting the form (POST, core CSRF
  token) runs one backup.
- Service `config_backup.service` → `\Drupal\config_backup\Services\ConfigBackupService::backup()` —
  builds the archive via `ArchiveTar`, iterating `@config.storage.export` (`listAll()` + all collections).
- Drush command `config:backup` (alias `cbkp`) → `\Drupal\config_backup\Commands\ConfigBackupCommands`.

No config entities, no config/schema, no plugins, no hooks, no `.install`, no templates/JS.

- How to configure the directory, run a backup (UI/Drush), and what the archive contains →
  [config/settings.md](config/settings.md)
