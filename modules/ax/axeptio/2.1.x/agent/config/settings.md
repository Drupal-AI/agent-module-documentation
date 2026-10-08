<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Axeptio — configuration

Config object: `axeptio.settings` (schema `config/schema/axeptio.schema.yml`; defaults in
`config/install/axeptio.settings.yml`). Both forms require the `administer axeptio` permission.

## Main settings form
Route `axeptio.settings_form` — `/admin/config/system/axeptio` (`src/Form/SettingsForm.php`).

- **`id`** (Project id, required) — the Axeptio project/client id. On the client it becomes
  `drupalSettings.axeptio.clientId` → `window.axeptioSettings.clientId`. Entering an id triggers an
  AJAX callback that fetches `https://client.axept.io/<id>.json` server-side to populate the cookie
  versions select. Nothing renders until this is set (`Axeptio::isConfigured()`).
- **`cookies_duration`** (required) — cookie life in days. Validated: max **390** (≈13 months);
  larger values are rejected. Default 180.
- **`cookies_secure`** (checkbox) — whether the choices cookie is HTTPS-only. Default true.
- **`language_specific`** (checkbox) — when on, `getCookiesVersion()` appends `-<langcode>` to the
  stored version, and `isConfigured()` additionally requires a chosen `cookies_version`.
- **`cookies_version`** (select) — populated from the Axeptio project JSON; sent as
  `drupalSettings.axeptio.cookiesVersion` when set.

## Google Consent Mode v2 form
Route `axeptio.settings_consent_v2_form` — `/admin/config/system/axeptio/consentv2`
(`src/Form/SettingsConsentV2Form.php`; also a local task tab).

- **`consent_mode_v2`** — master toggle. When on, `hook_page_attachments` adds
  `drupalSettings.axeptio.googleConsentMode.default` with `wait_for_update: 500` and the four signals
  below as `granted`/`denied`.
- **`consent_mode_v2_analytics_storage`**
- **`consent_mode_v2_ad_storage`**
- **`consent_mode_v2_ad_user_data`**
- **`consent_mode_v2_ad_personalization`**

Introduced by `axeptio_update_10000`, which initialises all five to `false` on existing sites.

## Notes
- No Drush commands, no UI for adding vendor plugins — extra embed vendors are added in code as
  `axeptio_vendor` plugins.
- The `axeptio_iframe` text filter must be enabled on a text format for iframe gating to apply.
