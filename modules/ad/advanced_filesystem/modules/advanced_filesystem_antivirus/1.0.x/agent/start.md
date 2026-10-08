<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Advanced Filesystem: Antivirus (advanced_filesystem_antivirus) — agent index

Submodule of **Advanced Filesystem**. Scans uploads with ClamAV (clamd INSTREAM over TCP/Unix
socket, or clamdscan/clamscan CLI); blocks/warns/quarantines infected files; bulk scan + Drush.

## What it is
- Depends on `advanced_filesystem:advanced_filesystem`, `drupal:file`.
- Config object `advanced_filesystem_antivirus.settings` (connection, size cap, action, quarantine, retention).
- One DB table (`hook_schema`): `adfs_antivirus_log`.
- Permission: `administer advanced_filesystem_antivirus` (`restrict access: true`).
- Drush commands (`drush.services.yml`): `adfs:av:ping`, `adfs:av:scan`.
- `configure` route: `advanced_filesystem_antivirus.settings`.

## Routes (`advanced_filesystem_antivirus.routing.yml`) — all admin-gated
- `.settings` `/admin/config/media/advanced_filesystem/antivirus` — AntivirusSettingsForm.
- `.batch` `.../antivirus/scan` — AntivirusBatchForm (bulk scan existing files).
- `.log` `.../antivirus/log` — AntivirusLogController::page (detection log).

## Services & code
- `Service\ClamAvScanner` (`advanced_filesystem_antivirus.scanner`) — `scanFile()`/`scanPath()` → `scanViaInstream()` (TCP/unix) or `scanViaCli()` (clamdscan/clamscan); `ping()`, `getDatabaseStatus()`, `quarantine()`, `logResult()`. CLI runs via `proc_open` with `escapeshellarg` on every argument (`runProcess()`), including `locateBinary()`.
- `EventSubscriber\AntivirusFileValidator` — core `FileValidationEvent` (priority -50); scans new uploads, then per `on_infection` blocks+quarantines / warns / logs. `handleError()` honours the `fail_closed` config (default false).
- `Batch\AntivirusBatch`, `Form\AntivirusBatchForm`, `Form\AntivirusSettingsForm`.
- `Controller\AntivirusLogController`, `Commands\AntivirusCommands`.
- `advanced_filesystem_antivirus.module` — `hook_cron` prunes `adfs_antivirus_log` by retention.

## Solution docs
- Scanner service, connection modes & enforcement: [agent/api/scanner.md](api/scanner.md)
- Settings, log, batch, Drush & permission: [agent/config/settings.md](config/settings.md)
