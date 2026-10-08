<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Config Backup — configure & run

## Install / enable
```
composer require drupal/config_backup
drush en config_backup -y
```
Only dependency is core `config`. No third-party libraries.

## Set the destination directory (required)
The module reads its target directory from the `settings` service —
`$this->settings->get('config_backup_directory')`. There is **no default**. Add to `settings.php`:
```php
$settings['config_backup_directory'] = '../config/back';
```
The README recommends a path outside the webroot (and `.gitignore`-ing it). If the value is empty,
`ConfigBackupService::backup()` and `ConfigBackupForm::buildForm()` add an error message and no backup
is written. The form also checks `is_writable($directory)` and warns if it is not.

## Run a backup
- **UI:** `/admin/config/development/configuration/backup` (route `config_backup.admin`, menu/task under
  Configuration → Synchronize). Requires permission **`backup configuration`** (declared with
  `restrict access: true`). The page shows the configured directory and a single **Backup** submit
  button; submit is a normal Drupal POST form (core CSRF token). On success:
  `Saved to <file>.` On failure: `Something went wrong.`
- **Drush:** `drush config:backup` (alias `drush cbkp`). Writes the archive and prints its path.

## What happens (`ConfigBackupService::backup()`, src/Services/ConfigBackupService.php)
1. `$this->fileSystem->prepareDirectory($directory, CREATE_DIRECTORY)` — creates the dir if needed.
2. Filename: `<directory>/configs-<Ymd_His>.tar.gz` (e.g. `configs-20260906_142530.tar.gz`).
3. `new ArchiveTar($file, 'gz')`; then for every name in `@config.storage.export`->`listAll()` it
   `addString("<name>.yml", Yaml::encode(...), FALSE, ['mode' => 0644])`; then repeats for every
   config collection from `getAllCollectionNames()` (collection dots → slashes).
4. Returns the archive path (or `FALSE` if no directory configured).

The archive is a snapshot of the **active configuration export** — the same data as
`drush config:export`. Depending on the site, exported config may include sensitive values; keep the
destination directory out of any web-served path (as the README advises) and treat archives like any
other config export. The module never serves, lists, or restores these files — restore is a manual
operation (e.g. extract into a sync dir and `drush config:import`).

## Notes
- No `config/install` or `config/schema` ships; there are no configurable UI settings beyond the
  `settings.php` value above.
- Restoring is out of scope for this module — it only produces archives.
