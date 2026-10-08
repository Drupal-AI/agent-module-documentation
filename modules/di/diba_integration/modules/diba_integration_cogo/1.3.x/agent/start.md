<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DiBa Tag Manager Cookie Warn (diba_integration_cogo) — agent index

Google Tag Manager + cookie-consent submodule of DiBa Integration. Package `Statistics`. No module dependencies beyond core; core `^10.3 || ^11 || ^12`. Configure route: `diba_integration_cogo.settings`.

## Config object
`diba_integration_cogo.settings` (schema + install defaults in `config/`). Keys: `style` (extra CSS), `expire` (int days), `verification` (google-site-verification code), `gtm` (container id; placeholder `GTM-XXXXXX` suppresses output), `default_ad_storage`/`default_analytics_storage`, `accept_ad_storage`/`accept_analytics_storage`, `reject_ad_storage`/`reject_analytics_storage` (each `granted`|`denied`), and `texts.<langcode>.{text,more_text,more_link,accept_text,reject_text}`.

## Route / permission
- `diba_integration_cogo.settings` — `/admin/config/system/diba_integration_cogo`, `Form/SettingsForm`, perm `administer site configuration`.

## Hooks / theme (`src/Hook/DibaIntegrationCogoHooks.php`)
- `#[Hook('theme')]` — registers `tmcw_head` and `tmcw_body` templates.
- `#[Hook('page_attachments')]` — adds the `google-site-verification` meta tag and the `tmcw_head` head element (consent script from `maqueta.diba.cat`, per-language banner data, Consent Mode v2 `gtag` calls, GTM loader).
- `#[Hook('page_top')]` — adds `tmcw_body` (GTM `<noscript>` iframe).
GTM markup renders only when `gtm` is set and not `GTM-XXXXXX`.

## Templates
- `templates/tmcw-head.html.twig` — consent script + Consent Mode v2 + GTM JS.
- `templates/tmcw-body.html.twig` — GTM `<noscript>` iframe.

## Solution docs
- `agent/config/settings.md` — settings keys, Consent Mode mapping, output behavior.
