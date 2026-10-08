<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Evercurrent (evercurrent) — agent index

Reports a Drupal site's available update status to the Evercurrent service (https://app.evercurrent.io) so
core/module/theme/profile updates can be tracked from a central dashboard and via email alerts.

- **Version dir:** 8.x-2.x (dev checkout; `info.yml` has no `version:` line). Core `^10.1 || ^11`. License GPL-2.0-or-later.
- **Package:** Evercurrent. **Composer:** `drupal/evercurrent` (empty `require`).
- **Dependency:** core `update` (`drupal:update`). No other libraries, no submodules, no Drush.

## What it provides

- **Service** `evercurrent.update_helper` → `Drupal\evercurrent\UpdateHelper` (implements `UpdateHelperInterface`).
  Args: `@config.factory`, `@module_handler`, `@theme_handler`, `@messenger`. This is the core of the module.
- **Config form** `Drupal\evercurrent\Form\AdminForm` at route `evercurrent.admin_form` = `/admin/config/evercurrent`
  (permission `access evercurrent settings`). Menu link under System > Media config (`system.admin_config_media`).
- **Controller** `Drupal\evercurrent\Controller\ListenerPageController` at route `evercurrent.listener` =
  `/api/rmc/key` (listening-mode key intake; `no_cache: TRUE`).
- **Permission** `access evercurrent settings` (`evercurrent.permissions.yml`).
- **Config object** `evercurrent.admin_config` (simple config; keys: `send`, `listen`, `target_address`, `key`,
  `status`, `interval`, `override`). Defaults shipped in `config/install/evercurrent.admin_config.yml`. No config schema.
- **hook_cron** (`evercurrent.module`) — interval-gated call to `UpdateHelper::sendUpdates(TRUE)`.
- **hook_requirements** (`evercurrent.install`) — status-report entries: listening mode, last successful run, runtime status.
- **hook_evercurrent_update_data_alter($sender_data)** — alter hook letting other modules extend the reported payload.
- **State keys:** `evercurrent_last_run`, `evercurrent_status`, `evercurrent_status_message`.

## Solution docs

- [config/settings.md](config/settings.md) — settings form fields, `evercurrent.admin_config` keys, `settings.php`
  overrides (`evercurrent_environment_token`, `evercurrent_environment_url`), install defaults, status report entries.
- [api/update-helper.md](api/update-helper.md) — the `UpdateHelper` service: cron flow, what data is collected and sent,
  the outbound POST, API-key resolution/validation, listening mode, and the public methods.
