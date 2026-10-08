<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Conzent CMP — configuration & script injection

Configures the Conzent consent banner and attaches it (plus optional GTM) to the front end. All logic lives in two files: `src/Form/ConzentSettingsForm.php` and `conzent_drupal.module`.

## Install / enable
```bash
composer require drupal/conzent_drupal   # composer name: conzent/conzent-drupal
drush en conzent_drupal -y
```
No module dependencies. Enabling installs `config/install/conzent_drupal.settings.yml`.

## Settings form
- Route `conzent.settings` → `/admin/config/system/conzent`, requirement `_permission: 'administer site configuration'` (`conzent_drupal.routing.yml`). Menu link declared in `conzent_drupal.links.menu.yml` under `system.admin_config_system`.
- Form id `conzent_drupal_settings_form`, class `ConzentSettingsForm extends ConfigFormBase`; `getEditableConfigNames()` returns `['conzent_drupal.settings']`.
- A separate permission `administer conzent` (`restrict access: true`) exists in `conzent_drupal.permissions.yml` but the route is gated by the core config permission, not this one.

## Config object `conzent_drupal.settings`
Schema type `config_object` (`config/schema/conzent_drupal.schema.yml`), all values `string`:

| Key | Purpose | Install default |
|-----|---------|-----------------|
| `website_key` | Conzent site/website id from the dashboard (max 128) | `''` |
| `server_url` | Empty = Conzent Cloud; set for self-hosted OCI (max 512) | `https://conzent.net/app` |
| `verified` | `'yes'` after a successful key verification, else `''` | `''` |
| `gtm_id` | Optional Google Tag Manager container id | `''` |
| `data_layer` | GTM data-layer variable name | `dataLayer` |

## Validation & submit (`ConzentSettingsForm`)
- `validateForm()`: rejects a non-empty `server_url` that fails `FILTER_VALIDATE_URL`; rejects a `gtm_id` not matching `/^GTM-[A-Z0-9]+$/i`.
- `submitForm()`: saves `server_url`, `gtm_id`, `data_layer` (falling back to `dataLayer`). If a `website_key` is entered it calls `verifyWebsite()`; when the response is an array containing a `domain` key it stores the (possibly server-returned) `website_key` and sets `verified = 'yes'`, otherwise it saves the key with `verified = ''` and warns.
- `verifyWebsite($key, $server_url)`: GETs `{server_url|default}/api/v1/verify?website_id={rawurlencode(key)}` via `\Drupal::httpClient()` with a 10s timeout (default TLS verification), json-decodes the body, returns the array or `[]` on `RequestException`.
- The form also shows a "verified" status message when `verified === 'yes'` and a "Open Conzent Dashboard" link built from `Html::escape($server_url)`.

## Front-end attachment (`conzent_drupal_page_attachments()`)
Runs on every page via `hook_page_attachments()`:
- Returns early unless `website_key` is non-empty **and** `verified === 'yes'`.
- Falls back to `https://conzent.net/app` if `server_url` is empty or fails `FILTER_VALIDATE_URL`.
- Adds the banner script to `html_head` at weight `-10000`: `<script async src="{server_url}/c/consent.js" data-key="{website_key}">` (attribute values rendered via Drupal's render array, so escaped).
- When `gtm_id` is set: injects the standard GTM loader inline `<script>` (values embedded with `json_encode()`) at weight `-9999` and a `<noscript>` GTM iframe (id via `Html::escape()`) at weight `-9997`, both loading from `www.googletagmanager.com`.

## Operate
1. Get a Website Key from the Conzent dashboard.
2. Visit `/admin/config/system/conzent`, paste the key, leave Server URL blank for Cloud or enter your OCI URL, optionally add a GTM id/data-layer name, Save.
3. On successful verification the banner script loads site-wide; if verification fails the key is stored but the banner is **not** emitted until `verified` becomes `yes`.

## Uninstall
`conzent_drupal_uninstall()` (`conzent_drupal.install`) deletes the `conzent_drupal.settings` config object.
