<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Axeptio (axeptio) — agent index

Integrates the **Axeptio.eu** consent management platform. Version **2.1.0**, core `^9.2 || ^10 || ^11`,
`drupal/core: ^9.0 || ^10 || ^11`. Admin behind the dedicated **`administer axeptio`** permission.
Configure at **Configuration > System > Axeptio** (`/admin/config/system/axeptio`).

## What it actually does
- **SDK injection.** `axeptio_page_attachments()` (in `axeptio.module`) calls the `axeptio.base`
  service (`src/Axeptio.php`). If `isConfigured()` (non-empty `id`; and a `cookies_version` when
  language-specific is on), it attaches the `axeptio/base` library and pushes settings into
  **drupalSettings** under `axeptio`: `clientId`, `userCookiesDuration`, `userCookiesSecure`, optional
  `cookiesVersion`, and (when Consent Mode v2 is on) a `googleConsentMode.default` block.
- **Client JS** (`assets/js/axeptio.js`) copies drupalSettings into `window.axeptioSettings` and
  injects **`//static.axept.io/sdk.js`** (Axeptio's CDN). The SDK renders the banner.
- **Iframe gating.** Text-format filter `axeptio_iframe` (`src/Plugin/Filter/Iframe.php`,
  TYPE_TRANSFORM_REVERSIBLE) rewrites `<iframe src="…">` → `src="" data-requires-vendor-consent="…"
  data-src="…"`. The same JS restores `src` from `data-src` on Axeptio's `cookies:complete` event,
  per vendor.
- **Vendor plugin type** `axeptio_vendor` (manager `src/AxeptioVendorPluginManager.php`, annotation
  `src/Annotation/AxeptioVendor.php`). Built-ins: `youtube`, `gmaps`, `dailymotion`, plus `unknown`
  fallback and `not_concerned`. Extensible by other modules.
- **Google Consent Mode v2.** Second form (`/admin/config/system/axeptio/consentv2`,
  `SettingsConsentV2Form`) toggles default `analytics_storage`, `ad_storage`, `ad_user_data`,
  `ad_personalization` (granted/denied), `wait_for_update: 500`.

## Config / routes
- Config object `axeptio.settings` (schema in `config/schema/axeptio.schema.yml`). Keys: `id`,
  `cookies_version`, `cookies_duration` (capped 390 days in `SettingsForm::validateForm`),
  `cookies_secure`, `language_specific`, `consent_mode_v2*`.
- Routes: `axeptio.settings_form`, `axeptio.settings_consent_v2_form` — both require
  `administer axeptio`.
- The main form (`src/Form/SettingsForm.php`) makes a server-side GET to
  `https://client.axept.io/<id>.json` to populate the cookie-version select (admin-only).

## Operating cautions (any CMP)
- **The banner is the easy half.** This module only holds back embeds routed through its
  `axeptio_iframe` filter (and whatever the SDK's own tag manager governs). Every other tracking
  script must still be inventoried and gated.
- **Check the page cache.** Consent is per visitor; a page cached with a script tag serves it to
  everyone regardless of choice.

## Files
- `agent/config/settings.md` — settings-form fields and consent-mode-v2 details.

## Security
No public findings. See `usage.md` for the injection path (values go through drupalSettings /
JSON-encoded by core, not inline concatenation).

Peers in this campaign: `gdpr_onetrust`, `cookiebot_gtm`.
