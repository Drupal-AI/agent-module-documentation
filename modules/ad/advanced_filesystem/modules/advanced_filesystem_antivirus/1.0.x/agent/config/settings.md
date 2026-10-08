<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings, log, batch, Drush & permission

## Install / enable
`drush en advanced_filesystem_antivirus`. Requires a reachable ClamAV (clamd daemon, or the
clamdscan/clamscan binaries on the web host). Scanning is OFF until `enabled` is set. Verify with
`drush adfs:av:ping`.

## Settings — `advanced_filesystem_antivirus.settings`
Form `Form\AntivirusSettingsForm` at `/admin/config/media/advanced_filesystem/antivirus`
(`administer advanced_filesystem_antivirus`). Keys + defaults (`config/install`, schema in `config/schema`):
- `enabled` (bool, `false`).
- `connection_mode` (`tcp` | `unix` | `clamdscan` | `clamscan`; default `tcp`).
- `host` (`127.0.0.1`), `port` (`3310`) — TCP mode.
- `socket_path` (`/var/run/clamav/clamd.ctl`) — Unix mode.
- `timeout` (`30` s).
- `max_scan_size_mb` (`25`; 0 = unlimited) — files larger are skipped/errored.
- `on_infection` (`block` | `warn` | `log`; default `block`).
- `fail_closed` (bool, `false`) — when true, uploads that cannot be scanned are rejected; when false, they are allowed to proceed. Set true for a fail-secure posture.
- `quarantine_directory` (`private://antivirus_quarantine`).
- `log_retention_days` (`90`; 0 = keep forever) — cron pruning window.

The form also surfaces `ClamAvScanner::ping()` / `getDatabaseStatus()` so admins can confirm
connectivity and signature-DB freshness.

## Detection log
`Controller\AntivirusLogController::page()` at `.../antivirus/log`. Reads `adfs_antivirus_log`
(`hook_schema` in `.install`): id, fid, filename, uri, result (`clean|infected|error|skipped`),
signature, message, scanned_at; indexes on scanned_at/result/fid. `hook_cron` deletes rows older than
`log_retention_days`.

## Bulk scanning
- Batch: `Form\AntivirusBatchForm` at route `.batch` (`.../antivirus/scan`) drives `Batch\AntivirusBatch` over managed files.
- Drush (`drush.services.yml`, `Commands\AntivirusCommands`): `adfs:av:scan [--fid=N] [--limit=N]`, `adfs:av:ping`.

## Services
`advanced_filesystem_antivirus.scanner` (ClamAvScanner), `advanced_filesystem_antivirus.file_validator`
(event_subscriber; args include `@advanced_filesystem.audit_logger`, `@messenger`, `@current_user`),
`advanced_filesystem_antivirus.commands` (drush.command), plus the logger channel.

## Permission
`administer advanced_filesystem_antivirus` (`restrict access: true`) gates all three routes and the log.
There is no anonymous or self-authenticating route; scanning is a passive subscriber on the core
upload-validation event.
