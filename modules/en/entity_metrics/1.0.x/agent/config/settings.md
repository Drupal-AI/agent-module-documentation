<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings, config object & schema

Source: `src/Form/SettingsForm.php`, `entity_metrics.routing.yml`, `entity_metrics.links.menu.yml`, `config/install/entity_metrics.settings.yml`, `config/schema/entity_metrics.schema.yml`.

## Install / enable
Requires `node` and `geoip_autoupdate`; Composer pulls `maxmind-db/reader`. Enable: `drush en entity_metrics -y`, `drush updb -y`, `drush cr`. `hook_install()` creates the `entity_metrics_data` and `entity_metrics_regions` tables. For geolocation, configure `geoip_autoupdate` to download a GeoLite2-**City** database first (the module reads it locally; MaxMind credentials live in `geoip_autoupdate`, not here).

## Route & menu
- Route `entity_metrics.settings` → `/admin/config/system/entity-metrics`, form `Drupal\entity_metrics\Form\SettingsForm`, permission `administer site configuration`.
- Menu link `entity_metrics.settings` under `system.admin_config_system`.

## Config object `entity_metrics.settings`
Defaults (`config/install`) and schema (`config/schema`):

| Key | Type | Default | Meaning |
| --- | --- | --- | --- |
| `cookie` | string | `''` | Name of a cookie that, when equal to `'1'`, flags a recorded event (`cookie_set=1`) so those rows can be excluded (e.g. staff views). The module does **not** set this cookie; another service must. |
| `geolocation_enabled` | boolean | `false` | Enrich pending events with local geolocation on each cron run. |
| `geolocation_database` | string | `private://GeoLite2-City.mmdb` | Local City `.mmdb` path (`private://` or absolute; remote URLs unsupported). |
| `geolocation_batch_size` | integer | `500` | Events processed per cron/CLI batch (form enforces 1–10000). |

## SettingsForm (`ConfigFormBase`)
`getFormId()` = `entity_metrics_settings`; `getEditableConfigNames()` = `['entity_metrics.settings']`. Builds the four fields above. `validateForm()` requires `geolocation_database` to start with `private://` or `/` and end with `.mmdb`. `submitForm()` saves all four (casting boolean/int, trimming the path).

## Footer attribution
When `geolocation_enabled` is on, `entity_metrics_page_bottom()` adds the required MaxMind GeoLite2 attribution line (cache tag `config:entity_metrics.settings`).
