<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Iubenda Integration — agent index

Integrates the external **Iubenda** service: privacy-policy links, the Cookie Solution consent
banner, and the Consent Solution. All settings live in **one config object**
`iubenda_integration.settings`.

- **The three settings forms, config keys, the block, and the permission** →
  [configure/settings.md](configure/settings.md)
- **The privacy-policy renderer service, the `[site:iubenda_integration]` token, and form/page integration** →
  [api/privacy-policy.md](api/privacy-policy.md)

Key facts:
- Configure route `iubenda_integration.settings` → `/admin/config/services/iubenda-integration`
  (+ `/cookie-policy` and `/consent-solution` sub-forms). All gated by permission
  `administer iubenda_integration`.
- **Gotcha:** all three forms (General, Cookie, Consent) save into the *same* config object
  `iubenda_integration.settings` — not `.settings.cookie` / `.settings.consent`.
- Key config keys: `iubenda_integration_policy_code` (privacy policy code), `cookie_solution_enable`
  + `siteId` + `enableGdpr/enableLgpd/enableFadp/enableUspr` + `position` (cookie banner),
  `api_key` (consent solution).
- Iubenda JS is attached (from `cdn.iubenda.com`) only on **non-admin** pages and only when
  `iubenda_integration_policy_code` is set. Depends on core `block` and the
  `iubenda/iubenda-cookie-class` PHP library.
