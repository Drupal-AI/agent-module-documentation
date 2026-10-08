<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration, settings form, and local JS cache

## Settings form

- Route: `whatsapp.settings_form` → path `/admin/config/services/whatsapp`, title "WhatsApp Settings".
- Permission: `whatsapp configuration form` (`whatsapp.permissions.yml`, `restrict access: true`).
- Menu link: `whatsapp.settings` under `system.admin_config_services`.
- Class: `Drupal\whatsapp\Form\WhatsappSettingsForm` (`ConfigFormBase`), editable config
  `whatsapp.settings`.

Two fields:

| Field | `#type` | Config key | Notes |
|-------|---------|------------|-------|
| Widget key | `key_select` | `widget_key` | Selects a Key entity (from the `key` module) holding the ChatWith.io / tochat.be widget key value. |
| Locally cache external library | `checkbox` (under `advanced`) | `external_library_cache` | If checked, download and serve `bundle.js` locally instead of from the vendor CDN. |

`submitForm()`: if the box is being **unchecked** (was on, now empty), it calls
`JavascriptLocalCache::clearWhatsappJsCache()` to delete the cached files, then saves both values.

## Config object `whatsapp.settings`

Schema `config/schema/whatsapp.schema.yml` (type `config_object`):

| Key | Type | Meaning |
|-----|------|---------|
| `widget_key` | string | Id of the Key entity that stores the widget key value. |
| `external_library_cache` | boolean | Whether to cache the vendor `bundle.js` locally. |
| `langcode` | string | Language code. |

There is also a block schema stub `block.settings.whatsapp_block` (type `block_settings`) with no
extra keys.

Set without the UI:

```bash
ddev drush config:set whatsapp.settings widget_key my_key_id -y
ddev drush config:set whatsapp.settings external_library_cache 1 -y
```

(`my_key_id` must be an existing `key.key.*` entity id.)

## The local-JS-cache service

Service `whatsapp.javascript_cache` → `Drupal\whatsapp\JavascriptLocalCache`
(`src/JavascriptLocalCache.php`). Adapted from the Google Analytics module. Constructor args:
`@file_url_generator`, `@http_client`, `@file_system`, `@config.factory`, `@logger.factory`.

`fetchWhatsappJavascript(string $key, bool $synchronize = FALSE): string`

- Target: `$remote_url = "//widget.tochat.be/bundle.js?key=$key"`; local destination
  `public://whatsapp/bundle.js`.
- If `external_library_cache` is **off**, returns `$remote_url` immediately (no download).
- If **on** and the local file is missing (or `$synchronize` is TRUE): GETs the remote bundle via the
  Guzzle `http_client`.
  - New file: creates `public://whatsapp`, saves `bundle.js`, and (when `zlib` is loaded and
    `system.performance:js.gzip` is on) also writes `bundle.js.gz`.
  - Existing file: base64-hashes local vs. remote; only replaces when they differ, then resets the
    asset query string (`_drupal_flush_css_js()` on older core) and logs the update.
  - On `RequestException` it logs and falls back to returning `$remote_url`.
- Returns `FileUrlGeneratorInterface::generateString($file_destination)` (a site-local URL) once
  cached.

`clearWhatsappJsCache()`: deletes `public://whatsapp` recursively and flushes the JS asset query
string. Called from the settings form when local caching is turned off.

## Cron

`whatsapp_cron()` (`whatsapp.module`): no-op unless `external_library_cache` is on. When on, and if
at least 86400 seconds (24h) have passed since state `whatsapp.last_cache`, it resolves the widget
Key value and calls `fetchWhatsappJavascript($key, TRUE)` to re-sync the local copy, then updates
`whatsapp.last_cache`.

> Note: `whatsapp_cron()` calls `$key_repository->getKey($widget_key)->getKeyValue()` unconditionally
> when caching is enabled — if `widget_key` is unset or points at a deleted Key while caching is on,
> cron will error on the null Key.
