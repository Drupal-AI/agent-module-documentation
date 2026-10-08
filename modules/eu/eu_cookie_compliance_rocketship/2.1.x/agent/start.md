<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Rocketship EU Cookie Compliance (eu_cookie_compliance_rocketship) — agent index

A Rocketship-distribution glue layer over **EU Cookie Compliance**. It provides no consent engine
of its own; it re-themes the consent popup, ships default consent config, adds Rocketship buttons +
language switcher + accessibility JS, and swaps in Cookie-Content-Blocker-aware field formatters and
text filters. Package `Rocketship`. Version **2.1.5**. Core `^10.3 || ^11`. License GPL-2.0-or-later.

## Dependencies (all required, from .info.yml)

- `eu_cookie_compliance` — the consent popup engine it decorates.
- `cookie_content_blocker` — the `<cookiecontentblocker>` blocking mechanism the formatters/filters use.
- `eu_cookie_compliance_gtm` — GTM consent bridge; the shipped cookie categories carry its `gtm_data`
  third-party settings.
- Composer also requires `drupal/cookie_content_blocker:^2.3.0` (composer.json), with a big-pipe patch.

## What it provides

- **1 config form / route**: `SettingsForm` at `/admin/config/system/eu-cookie-compliance/rocketship`
  (route `eu_cookie_compliance_rocketship.admin_settings_form`), permission
  **`administer rocketship eucc settings`**. Writes config object `eu_cookie_compliance_rocketship.settings`.
- **1 permission** (`eu_cookie_compliance_rocketship.permissions.yml`).
- **3 field formatters** (extend `iframe` and `video_embed_field` formatters, attach CCB pre_render):
  `CookieBlockedIframe`, `CookieBlockedIframeOnly`, `CookieBlockedVideo`.
- **2 text-format filters**: `cookie_content_blocker_filter_auto_iframe`,
  `cookie_content_blocker_filter_auto_src`.
- **4 libraries** (`general`, `reopen_link`, `css_structural`, `css_extra`).
- **Hooks** in `.module`: `theme_registry_alter`, `preprocess_eu_cookie_compliance_popup_info`,
  `page_attachments_alter`, `eu_cookie_compliance_cid_alter`, `field_formatter_info_alter`,
  `library_info_alter`; install/uninstall/update hooks in `.install`.
- **Default config**: `eu_cookie_compliance.settings` override + 4 cookie categories
  (necessary/functional/analytics/marketing) with DE/FR/NL translations.

## Solution docs

- Settings form, config objects/schema, install & uninstall behaviour, route & permission →
  [config/settings.md](config/settings.md)
- Popup theming, injected buttons, language switcher, libraries, JS behaviours, cid alter →
  [theming/popup-and-js.md](theming/popup-and-js.md)
- The three Cookie-Content-Blocker field formatters →
  [fields/formatters.md](fields/formatters.md)
- The two auto-wrap text-format filters → [filters/text-filters.md](filters/text-filters.md)
