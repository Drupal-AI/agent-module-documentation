<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration — settings form & config object

## Install / enable
`composer require drupal/acquia_cloud_backup_manager` (pulls `typhonius/acquia-php-sdk-v2:^3`),
then enable the module. Only useful on Acquia Cloud, where the Cloud API is reachable.

## Route & access
- Route id `acquia_cloud_backup_manager.settings_form`
  (`acquia_cloud_backup_manager.routing.yml`).
- Path `/admin/config/services/acquia-cloud/backup-manager`.
- Handler `Drupal\acquia_cloud_backup_manager\Form\SettingsForm` (extends `ConfigFormBase`,
  form id `acquia_cloud_backup_manager_settings`).
- Permission `administer site configuration`. Menu link (`*.links.menu.yml`) under
  `system.admin_config_services`, weight 10.

## Config object
`acquia_cloud_backup_manager.settings` — schema `config/schema/…schema.yml`, defaults
`config/install/…settings.yml`.

| key | type | meaning |
|-----|------|---------|
| `key` | string | Cloud API key/token (config fallback) |
| `secret` | string | Cloud API secret (config fallback) |
| `application_uuid` | string | selected Cloud application UUID |
| `environment_uuid` | string | selected environment UUID |
| `database_name` | string | database whose backups are managed |
| `cron_enabled` | boolean | run retention on cron (default `false`) |
| `keep_limit_type` | string | `time_to_keep` or `number_to_keep` (default `time_to_keep`) |
| `time_to_keep` | integer | days to keep when type is `time_to_keep` |
| `number_to_keep` | integer | count to keep when type is `number_to_keep` |

## Form behaviour (`SettingsForm`)
- `buildForm()` shows a **Credentials** fieldset only when
  `AcquiaCloudClient::environmentVariablesAvailable()` is FALSE. When the env vars
  `CLOUD_PLATFORM_API_TOKEN` / `CLOUD_PLATFORM_API_SECRET` are both set, the fields are hidden and
  the form prints "The fields for API credentials are hidden because are set globally".
- A **"Load Applications and Environments"** submit (`showSubmitHandler` / `showApplicationsAjax`)
  and `#ajax` change handlers populate the Application / Environment / Database `select`s live from
  the Cloud API via `getApplicationOptions()` / `getEnvironmentOptions()` / `getDatabaseOptions()`.
  Each wraps the client call in try/catch and returns `[]` on failure, so bad credentials just
  yield empty selects.
- **Cron** fieldset: `cron_enabled` checkbox, `keep_limit_type` select, and `number_to_keep` /
  `time_to_keep` number fields shown/required conditionally via `#states` on `keep_limit_type`.
- `validateForm()` requires key/secret (when env vars absent), then calls `getApplicationOptions()`;
  an `IdentityProviderException` or empty result sets a form error ("Invalid credentials." /
  "Could not retrieve any application…"). Successful applications are stashed in form state.
- `submitForm()` writes all nine keys back to `acquia_cloud_backup_manager.settings`.

## Update hook
`acquia_cloud_backup_manager_update_8001()` sets `keep_limit_type` to `time_to_keep` when it is
empty or invalid.
