<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings form, config & script-injection mechanics

## Install / enable / configure

`drush en cmp_sirdata`. No dependencies (core only). Then visit
`/admin/config/system/cmp-sirdata` (route `cmp_sirdata.settings_form`, permission
`administer cmp sirdata configuration`), tick **Enable CMP Sirdata**, enter the **CMP Sirdata
Customer Key** and **CMP Sirdata App Key** from your Sirdata CMP account, and save. Nothing appears
on the front end until all three conditions (enable + both keys) hold.

## Settings form (`Form/SettingsForm.php`)

`ConfigFormBase`, form id `cmp_sirdata_settings`, editable config `cmp_sirdata.settings`.

| field | #type | required | stored key | notes |
|-------|-------|----------|------------|-------|
| Enable CMP Sirdata | checkbox | no | `enable` | boolean master switch |
| CMP Sirdata Customer Key | textfield | **yes** | `customer_key` | `trim()`ed on submit |
| CMP Sirdata App Key | textfield | **yes** | `app_key` | `trim()`ed on submit |

Standard `ConfigFormBase` → the submit carries Drupal's form/CSRF token; only a user holding the
`restrict access: true` permission `administer cmp sirdata configuration` can reach it.

## Config schema (`config/schema/cmp_sirdata.schema.yml`)

`cmp_sirdata.settings` `config_object`: `enable` (boolean), `customer_key` (string),
`app_key` (string). No default config file ships, so the object is empty until first save.

## When the scripts are attached (`hook_page_attachments`)

`cmp_sirdata_page_attachments()`:

1. Always merges `cmp_sirdata.settings` cache tags onto `$attachments['#cache']['tags']` (so pages
   re-render when the config changes).
2. Returns early (no scripts) if `!enable` **or** the current route is an admin route
   (`\Drupal::service('router.admin_context')->isAdminRoute()`) — CMP never loads in the admin UI.
3. Returns early if either `app_key` or `customer_key` is empty.
4. Otherwise attaches library `cmp_sirdata/scripts`.

## How the library is built (`hook_library_info_build`)

`cmp_sirdata_library_info_build()` reads the two keys from config and, only if both are set, defines
the `scripts` library with two **external** JS assets:

```
https://cache.consentframework.com/js/pa/{app_key}/c/{customer_key}/stub
https://choices.consentframework.com/js/pa/{app_key}/c/{customer_key}/cmp
```

Each with `type: external` and attributes `referrerpolicy: unsafe-url`, `charset: utf-8`,
`type: text/javascript`. If a key is missing the library is defined empty (`js: []`). Because the
library is generated per-request from config, changing the keys immediately changes which script
URLs are emitted (subject to the JS library cache).

The two keys are interpolated into the `src` URL of a `<script>` tag rendered through Drupal's asset
system, which HTML-attribute-escapes the `src` value. There is no server-side HTTP request in this
module — the browser fetches the scripts directly from `consentframework.com`.

## Consent wiring (operational)

The CMP collects consent client-side and exposes an IAB TCF v2.1 signal; making other analytics/
marketing tags respect it is done in Sirdata's dashboard / tag-conditioning tooling, not in this
module. This module only injects the two loader scripts.
