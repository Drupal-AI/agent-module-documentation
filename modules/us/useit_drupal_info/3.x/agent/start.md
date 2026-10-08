<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Useit Drupal Info (useit_drupal_info) — agent index

Reports the site's Drupal version, PHP version and full project inventory (installed/recommended/latest
version + update status of core and every project) to an admin-configured `destination_url` on **cron**,
via an HTTP POST with an optional `X-Drupal-Key` API-key header. Version **3.x** (`3.1.0` on disk).

## What it provides
- **Service** `useit_drupal_info.service` → `UseitDrupalInfoService::checkAndSendData()`
  (`src/Service/UseitDrupalInfoService.php`) — builds and POSTs the payload; injects `@state`,
  `@config.factory`, `@http_client`, `@logger.factory`.
- **Cron hook** `useit_drupal_info_cron()` (`useit_drupal_info.module`) — invokes the service each run.
- **Settings form** `PostDestinationSettingsForm` (`src/Form/PostDestinationSettingsForm.php`,
  extends `ConfigFormBase`) at route `useit_drupal_info.post_destination_settings`
  → path `/admin/config/system/post_destination_settings`, permission `administer site configuration`.
- **Config object** `useit_drupal_info.post_destination_settings` (keys: `destination_url`, `api_key`,
  `cron_interval`). **State** key `useit_drupal_info.cron_last` (last-sent timestamp).

## Dependencies
Core modules `update` (Update Manager) and `automated_cron`. Core `^11`. No permissions, no Drush,
no plugins, no submodules, no config/schema shipped.

## Solution docs
- [config/settings.md](config/settings.md) — settings form, config keys, cron throttle, install/enable.
- [api/service.md](api/service.md) — the data service, payload shape, and how the POST is built.
