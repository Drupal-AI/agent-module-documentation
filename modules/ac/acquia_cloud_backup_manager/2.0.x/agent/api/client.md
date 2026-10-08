<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Service — acquia_cloud.client (AcquiaCloudClient)

`Drupal\acquia_cloud_backup_manager\AcquiaCloudClient`, registered as service
`acquia_cloud.client` with `@config.factory`. A thin wrapper over the
`typhonius/acquia-php-sdk-v2` SDK (`AcquiaCloudApi\Connector\Client` +
`AcquiaCloudApi\Endpoints\*`). Reads `acquia_cloud_backup_manager.settings` for its selection.

## Credential resolution — `getClient()`
Lazily builds an `AcquiaCloudApi\Connector\Client`. Reads env vars first:
`CLOUD_PLATFORM_API_TOKEN` (const `API_TOKEN_VAR_NAME`) and `CLOUD_PLATFORM_API_SECRET`
(const `API_SECRET_VAR_NAME`); only when either is missing does it fall back to config `key`/
`secret`. Builds a `Connector(['key'=>…,'secret'=>…])` and `Client::factory($connector)`.
`environmentVariablesAvailable()` returns TRUE when both env vars are set.

Test seams: `setClient(Client)`, `setClientWithCredentials($key,$secret)`,
`setDatabaseService(DatabaseBackups)` inject mocks (see the unit test).

## Listing methods (used by the form)
- `getApplicationList()` → `AcquiaCloudApi\Endpoints\Applications::getAll()`, returns
  `[uuid => name]`.
- `getEnvironmentList($application_id)` → `Environments::getAll()`, returns `[uuid => name]`.
- `getDatabasesList($application_id)` → `Databases::getAll()`, returns `[name => name]`.

## Backup methods
- `getBackupList()` → `DatabaseBackups::getAll($environment_uuid, $database_name)` (env/database
  from config). Keeps **only** items with `type == 'ondemand'`, returning
  `[backupId => strtotime(completedAt)]`.
- `deleteOlderBackups(int $limit, string $type = 'time_to_keep')` — computes which on-demand
  backups fall outside the policy and deletes them; see [../cron/retention.md](../cron/retention.md).
- `deleteBackups(array $backups_to_delete)` — iterates the UUID keys and calls
  `DatabaseBackups::delete($environment_uuid, $database_name, $uuid)` for each; returns the map it
  was given.
- `getDatabaseService()` (private) lazily constructs `new DatabaseBackups($this->client)`.

## Notes
- HTTP/TLS is handled entirely by the SDK's Guzzle client; this module sets no HTTP options.
- All calls throw on failure; callers in `SettingsForm` swallow exceptions, while `hook_cron()`
  catches and logs them.
