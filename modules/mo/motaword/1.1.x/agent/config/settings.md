<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration & settings

## Install / enable

```bash
composer require drupal/motaword
drush en motaword
drush updb   # if upgrading from 1.0.x — runs motaword_update_10001
```

No module dependencies. After enabling, open **Configuration → MotaWord** (`/admin/config/motaword`, route `motaword.settings`, permission `administer motaword`) and paste an Active token from the MotaWord dashboard. Saving a valid token fetches project + widget metadata automatically; nothing else is required.

![MotaWord settings form](../../../../../../../screenshots/motaword/1.1.x/settings-form.png)

## Config object `motaword.settings`

Defaults in `config/install/motaword.settings.yml`, schema in `config/schema/motaword.schema.yml`. `SettingsForm::CONFIG_NAME` = `motaword.settings`.

| Key | Type | Default | Meaning |
|---|---|---|---|
| `active_token` | string | `''` | Active token, sent to Serve as the `X-MotaWord-Token` header. |
| `is_active_serve_enabled` | bool | `false` | Server-side proxy on/off. |
| `is_insert_active_js` | bool | `true` | Inject the ActiveJS widget script into pages. |
| `is_insert_for_admin_when_disabled` | bool | `true` | Still inject ActiveJS for `administer motaword` users when disabled for visitors (preview mode). |
| `is_active_urlmode_query` | bool | `true` | Query-string locale mode for admins (not exposed in the UI; see below). |
| `has_custom_language_switcher` | bool | `false` | Emit `data-render-widget="false"` so ActiveJS loads but skips its picker UI. |
| `active_blacklist_urls` | string | `''` | Newline-separated paths never sent through Serve. |
| `serve_host` | string | `''` | Public/browser-facing Serve host override (empty = `https://serve.motaword.com`). |
| `serve_host_internal` | string | `''` | Server-side outbound-HTTP host override; falls back to `serve_host`. |

## Settings form (`src/Form/SettingsForm.php`)

`SettingsForm extends ConfigFormBase` (form id `motaword_settings`). The two underlying booleans `is_insert_active_js` + `is_active_serve_enabled` are presented as one **Translation mode** radio:

- `resolveTranslationModeFromConfig()` maps config → radio: proxy on → `server`; else JS on → `browser`; else `disabled`.
- `translationModeToBooleans()` maps radio → config: `server` → `[TRUE, TRUE]`, `browser` → `[TRUE, FALSE]`, `disabled` → `[FALSE, FALSE]`.

Other form fields: preview-mode checkbox (`is_insert_for_admin_when_disabled`), custom-switcher checkbox (`has_custom_language_switcher`), URL blacklist textarea (`active_blacklist_urls`). `is_active_urlmode_query`, `serve_host`, `serve_host_internal` are intentionally **not** in the UI — set them via `settings.php` when needed.

`submitForm()` behaviour when a token is entered: it calls `ServeClient::getLocalMetadata()` first and only saves the token if the fetch succeeds (a bad token is rejected with an error and not saved). Emptying the token clears stored metadata (`MetadataStore::clear()`).

Two extra submit buttons appear once a token exists:
- **Refresh metadata** → `submitRefreshMetadata()` → `MetadataRefresher::refresh()`.
- **Clear translation cache** → `submitClearCache()` → `ServeClient::purgePages()` for `[home, home/, home/*]` with reason `admin-clear-cache`.

## `settings.php` overrides

The token can be pinned per environment (kept out of exported config). Note the Active token is also emitted publicly in page markup as the ActiveJS `data-token` — it is a per-project widget identifier, so the override exists mainly to keep it out of git config, not to hide a high-value secret:

```php
if ($motaword_token = getenv('MOTAWORD_TOKEN')) {
  $config['motaword.settings']['active_token'] = $motaword_token;
}
```

When overridden the token field becomes read-only and shows a masked value (`SettingsForm::maskToken()`). An **empty** override is ignored so a missing env var never shadows a saved token (`MetadataStore::getToken()` / `isTokenOverridden()`). Container-dev host split (DDEV):

```php
$config['motaword.settings']['serve_host']          = 'http://localhost:3002';
$config['motaword.settings']['serve_host_internal'] = 'http://host.docker.internal:3002';
```

Opt out of the import guard: `$settings['motaword_config_import_guard'] = FALSE;`.

## Health checks

`SettingsForm::getHealthMessages()` surfaces messenger warnings above the form: empty `settings.php` override, token set but metadata missing, project in `path` URL mode while the proxy is off, project in `query` mode while the proxy is on (auto-forced to path), widget not live (admin-only preview), dummy translations enabled, and Drupal core `content_translation` also enabled.
