<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Acquia Cloud - Backup Manager (acquia_cloud_backup_manager) — agent index

Prunes **on-demand** Acquia Cloud database backups by cron via the Acquia Cloud API — either
keep-for-N-days or keep-newest-N. Version **2.0.0**. Core `^10.2 || ^11`, PHP `>=8.1`.
Package "Acquia". On Acquia Site Factory use `acsf_backup_manager` instead.

## Dependencies
- Composer library `typhonius/acquia-php-sdk-v2:^3` (the `AcquiaCloudApi\*` SDK). No Drupal module
  dependencies. Optional runtime: `markdown` module (only to render the README in `hook_help()`).

## What it provides
- **Service** `acquia_cloud.client` → `Drupal\acquia_cloud_backup_manager\AcquiaCloudClient`
  (args: `@config.factory`). Wraps the SDK: list applications/environments/databases, list
  on-demand backups, compute which are out of policy, delete them.
- **Route** `acquia_cloud_backup_manager.settings_form` →
  `/admin/config/services/acquia-cloud/backup-manager`, `_form: Form\SettingsForm`, permission
  `administer site configuration`. The only route. Menu link under
  `system.admin_config_services`.
- **Config object** `acquia_cloud_backup_manager.settings` (schema provided) — keys: `key`,
  `secret`, `application_uuid`, `environment_uuid`, `database_name`, `cron_enabled`,
  `keep_limit_type`, `time_to_keep`, `number_to_keep`.
- **Hooks** `hook_cron()` (runs retention when `cron_enabled`), `hook_help()`,
  `hook_update_8001()` (defaults `keep_limit_type` to `time_to_keep`).
- No permissions file, no Drush commands, no plugin types, no entities.

## Credentials
`AcquiaCloudClient::getClient()` reads env vars `CLOUD_PLATFORM_API_TOKEN` /
`CLOUD_PLATFORM_API_SECRET` first; if either is missing it falls back to config `key`/`secret`.
When both env vars are set, `SettingsForm` hides the credential fields. Acquia Cloud exposes these
env vars natively — the recommended way to supply credentials.

## Solution docs
- [config/settings.md](config/settings.md) — settings form, config keys, schema, route/permission.
- [api/client.md](api/client.md) — the `acquia_cloud.client` service and its methods.
- [cron/retention.md](cron/retention.md) — how cron pruning selects and deletes backups.
