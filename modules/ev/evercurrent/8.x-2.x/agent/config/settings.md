<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Evercurrent — configuration

## Install / enable

`drush en evercurrent`. Requires core `update`. On install, `config/install/evercurrent.admin_config.yml` seeds the
`evercurrent.admin_config` simple-config object.

## Settings form

`Drupal\evercurrent\Form\AdminForm` (extends `ConfigFormBase`, form id `admin_form`) at
route `evercurrent.admin_form` → `/admin/config/evercurrent`, permission **`access evercurrent settings`**.
Menu link `evercurrent.admin_form` sits under `system.admin_config_media`. `getEditableConfigNames()` =
`['evercurrent.admin_config']`. Fields (all persisted in `submitForm()` except `send_now`):

| Form field | Config key | Meaning |
|---|---|---|
| Enable sending update reports | `send` | Master switch checked by `evercurrent_cron()`. |
| Server URL | `target_address` | Base URL of the Evercurrent endpoint. `RMH_URL` (`/evercurrent/post-update`) is appended when reporting. Default `https://app.evercurrent.io/`. Max length 300. |
| API Key | `key` | 32-char hex site key from the Evercurrent server. Max length 32. |
| Listen for new API key (Advanced) | `listen` | Enables the listening-mode key intake route (see below). |
| Report frequency (Advanced) | `interval` | Seconds between sends: `0` (every cron), `3600`, `43200`, `86400`. |
| Override API key stored in settings.php | `override` | Only shown when `settings.php` defines a key; when checked, the `key` field value wins over the settings.php value. |
| Send update report when saving configuration | (not stored) | When checked, `submitForm()` calls `UpdateHelper::sendUpdates(TRUE, NULL, TRUE)` immediately (messages shown to the user). |

When a settings.php token is present, the `key` field is disabled via `#states` unless `override` is checked.

## `evercurrent.admin_config` keys and install defaults

```
send: 1            # send reports on cron
listen: 1          # listening mode
target_address: 'https://app.evercurrent.io/'
key: ''            # API key (empty until configured)
status: 1          # legacy/status flag
interval: 0        # 0 = every cron run
```

There is **no** `config/schema/` for this module (`provides_config_schema` = false); `override` is written by the form
but is not present in the install defaults.

## settings.php overrides

Read by `UpdateHelper` via `Drupal\Core\Site\Settings`:

- `$config['evercurrent_environment_token'] = 'your-api-key';` — API key resolved by
  `getKeyFromSettings()`: the settings.php token is used unless config `override` is TRUE, in which case the config
  `key` is used. Recommended so only production carries the real key (dev/stage stay silent with an empty config key).
- `$config['evercurrent_environment_url'] = 'https://my-production-site';` — read by `getEnvironmentUrl()`; falls back
  to the global `$base_url`. Use when `$base_url` is not reliably set (e.g. Drush cron) so the report is attributed to
  the correct environment. This is the `project_name` field in the payload.

Note: the README documents these as `$config[...]` entries; the code reads them through `Settings::get()`, so they are
effective when placed in the `$settings[...]` array (per the AdminForm help text which shows `$settings[...]`).

## Status report entries (`hook_requirements`, runtime)

`evercurrent.install` adds three rows to `/admin/reports/status`:

- **Listening mode** — WARNING when `listen` is on, OK otherwise.
- **Last successful run** — from state `evercurrent_last_run` via `UpdateHelper::lastRun()`.
- **Runtime status** — the last `evercurrent_status_message` and its `evercurrent_status` severity
  (`RMH_STATUS_OK`=0 / `WARNING`=1 / `ERROR`=2).
