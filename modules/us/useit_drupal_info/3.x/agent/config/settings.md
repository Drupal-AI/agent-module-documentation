<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Useit Drupal Info — settings & install

## Install / enable
```
composer require drupal/useit_drupal_info
drush en useit_drupal_info -y
```
Enabling pulls in the core dependencies declared in `useit_drupal_info.info.yml`:
`drupal:update` (Update Manager) and `drupal:automated_cron`. Core requirement `^11`.
Nothing is sent until you configure a destination URL.

## Settings form
- **Class:** `Drupal\useit_drupal_info\Form\PostDestinationSettingsForm` (extends `ConfigFormBase`).
- **Route:** `useit_drupal_info.post_destination_settings` → `/admin/config/system/post_destination_settings`.
- **Access:** `_permission: "administer site configuration"` (see `useit_drupal_info.routing.yml`).
- **Menu link:** under `system.admin_config_system` (`useit_drupal_info.links.menu.yml`).
- **Form id:** `useit_post_destination_settings`.

## Config object
Editable config name: `useit_drupal_info.post_destination_settings` (the module ships no
`config/install` default and no `config/schema` — the object is created on first save).

| Key | Form widget | Meaning |
| --- | --- | --- |
| `destination_url` | textfield (required) | URL the payload is POSTed to. |
| `api_key` | password field | Optional; sent as the `X-Drupal-Key` header. Leave the field blank on re-save to keep the stored value (`submitForm()` only overwrites it when non-empty). |
| `cron_interval` | select | Minimum seconds between POSTs: `0` Always, `10800` 3h, `21600` 6h, `43200` 12h, `86400` day (default), `604800` week. |

## Runtime state
`buildForm()` reads state key `useit_drupal_info.cron_last` and shows the last-sent time
(formatted `Y-m-d H:i:s`, or "Never"). The service writes this key after each successful attempt.

## Operating it
1. Set `destination_url` (and `api_key` if the receiver is protected) and pick an interval.
2. Ensure cron runs — Automated Cron triggers it on normal traffic; `drush cron` forces a run.
3. On each cron run `useit_drupal_info_cron()` calls the service, which skips if
   `time() - cron_last <= cron_interval`, otherwise builds the payload and POSTs it.
Point the destination only at an endpoint you operate/trust and prefer HTTPS — the payload
enumerates the site's modules and versions. Guzzle verifies TLS by default; the module does not
disable it.
