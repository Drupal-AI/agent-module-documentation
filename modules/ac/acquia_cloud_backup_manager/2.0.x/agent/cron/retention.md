<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cron retention

Pruning happens only in `acquia_cloud_backup_manager_cron()` (`.module`) and only when config
`cron_enabled` is TRUE. It reads `keep_limit_type` (default `time_to_keep`) and the matching limit
(`time_to_keep` or `number_to_keep`, default 365 if unset), then calls
`AcquiaCloudClient::deleteOlderBackups($limit, $type)` inside a try/catch. It logs the deleted
backup UUIDs and completion dates, or an info message when nothing matched; exceptions are logged
as errors to channel `acquia_cloud_backup_manager`.

## Selection logic — `deleteOlderBackups(int $limit, string $type)`
1. `getBackupList()` → map of on-demand `backupId => completedAt(unixtime)`.
2. **Guard:** returns `[]` immediately if the list is empty, has exactly one backup, or `$limit == 0`
   — so it never deletes the only backup and a zero limit is a no-op.
3. `ksort($backup_list, SORT_NUMERIC)` — oldest first.
4. Branch on `$type`:
   - **`time_to_keep`**: `$time_limit = strtotime("-{$limit}days")`; every backup older than that is
     marked for deletion. **Extra guard:** if that would delete *every* backup, it keeps the newest
     one (`array_slice($backups_to_delete, 0, -1, TRUE)`).
   - **`number_to_keep`**: if the count exceeds `$limit`, marks all but the newest `$limit`
     (`array_slice($backup_list, 0, -$limit, TRUE)`) for deletion.
5. Non-empty selection is passed to `deleteBackups()`, which calls
   `DatabaseBackups::delete($environment_uuid, $database_name, $uuid)` per UUID.

Returns `[uuid => ['date' => ATOM-formatted completedAt]]` for the deleted backups (used by
`hook_cron()` for logging). Only on-demand backups are ever considered; scheduled/automatic
Acquia backups are untouched.

## Coverage
`tests/src/Unit/AcquiaCloudDeleteBackupTest.php` exercises `deleteOlderBackups()` with a mocked
`DatabaseBackups` across both strategies and the "never delete all backups" / "limit 0 is a no-op"
edge cases.
