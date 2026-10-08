<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# COOKiES MS Dynamics 365 Marketing Anonymize (cookies_msdynamics365marketing) — agent index

A COOKiES consent sub-integration that toggles Microsoft **Dynamics 365 Marketing**'s client-side
`Anonymize` tracking flag based on the visitor's cookie consent. Package `COOKiES`. Core
`^9 || ^10 || ^11`. License GPL-2.0-or-later. Version 1.0.0-alpha2 (dir `1.0.x`).
Maintainers label it *very specific / work in progress*.

- **The COOKiES service config entity + the JS consent behavior, and how to operate them** →
  [config/service.md](config/service.md)

## What it actually is

- Depends on **`cookies`** (COOKiES Consent Management), declared as `cookies:cookies`. No composer
  requirements, no PHP libraries.
- **No routes, no controllers, no forms, no permissions, no Drush, no plugin types, no config schema
  of its own.** It does not add, load, or block any Dynamics 365 form/tracking script — you embed
  those yourself.
- Ships exactly one config entity, one JS library, and two hook implementations.

## Mechanism (from source)

- `config/install/cookies.cookies_service.msdynamics365marketing.yml` — a COOKiES `cookies_service`
  entity: `id: msdynamics365marketing`, `label: 'MS Dynamics 365 Marketing'`, `group: tracking`,
  `consent: true`, `url: https://www.microsoft.com/trustcenter`, and an `info` table (`format:
  full_html`) listing the four Dynamics 365 tracking cookies. Values are static and shipped by the
  module (schema comes from the parent COOKiES module).
- `cookies_msdynamics365marketing.module` — `hook_help()` (help.page text) and
  `hook_page_attachments()` which attaches the library `cookies_msdynamics365marketing/anonymize`
  on **every page**. (`hook_library_info_alter` is present but commented out.)
- `cookies_msdynamics365marketing.libraries.yml` — library `anonymize` = `js/anonymize.js` (no
  dependencies).
- `js/anonymize.js` — `Drupal.behaviors.cookies_msdynamics365marketing_anonymize` (`id:
  "msdynamics365marketing"`). On `attach`, listens for the COOKiES `cookiesjsrUserConsent` event;
  if `event.detail.services[msdynamics365marketing]` is truthy it calls `activate()`, else
  `fallback()`. `activate()` sets global `d365mktConfigureTracking()` → `{Anonymize: false}` and,
  if `window.MsCrmMkt` exists, `MsCrmMkt.reconfigureTracking({Anonymize: false})`. `fallback()`
  does the same with `Anonymize: true` (the pre-consent default).
