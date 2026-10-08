<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Business Identity settings form, routes & config

## Install & enable

```bash
composer require drupal/business_identity
drush en business_identity -y
```

Dependencies are core-only: `system`, `config`. `hook_install()` (`business_identity.install`)
creates the directory `public://business-identity` and seeds `business_identity.settings` with a
few defaults copied from `system.site` / `system.date` (`company_name`, `slogan`, `email`,
`currency=USD`, `measurement_unit=metric`, `date_format`, `time_format`, `timezone`).
`hook_uninstall()` deletes `business_identity.settings`.

## Routes & permission

`business_identity.routing.yml` (both gated by permission **`administer business identity`**,
declared with `restrict access: true` in `business_identity.permissions.yml`):

| Route id | Path | Form |
|---|---|---|
| `business_identity.settings` | `/admin/config/business/identity` | `Form\BusinessIdentityForm` |
| `business_identity.test_form` | `/admin/config/system/business-identity/test` | `Form\TestForm` |

The `.info.yml` sets `configure: business_identity.settings`. Menu/task/contextual links
(`business_identity.links.menu.yml` etc.) place the settings page under
*Configuration → System*. There are **no anonymous or lower-privilege routes**.

## The settings form (`BusinessIdentityForm`)

A `ConfigFormBase` whose `getEditableConfigNames()` returns `business_identity.settings` **and**
`system.site`. It builds a `vertical_tabs` element with tabs: Basic, Contacts, Address, Legal,
Online, Operations, System, Ecommerce, Business Hours, plus several tabs set to `#access => FALSE`
(Security/API keys, Reviews, Advanced, Local Laws, Tokens). Key behaviors:

- **Synchronized (read-only) fields** mirror core config and are `#disabled` — company name,
  slogan, primary email (from `system.site`), front page, date/time format, timezone (from
  `system.date`), logo (from `system.theme.global`), maintenance mode (from `Settings`). They are
  shown for overview only and are **not** written back.
- Optional integrations are feature-detected via `moduleHandler->moduleExists(...)`: `address`
  (structured address element vs. plain text fallback), `commerce`/`commerce_store` (currency +
  store link), `geolocation`, `office_hours`, `key` (API-key select vs. plain textfields).
- `create()` optionally injects `key.repository` when the Key module is present.
- `validateForm()` validates emails (`FILTER_VALIDATE_EMAIL`), social/e-commerce/review URLs
  (`FILTER_VALIDATE_URL`), founding year (1800–current), latitude/longitude ranges, and delegates
  region validation to `hook_business_identity_local_laws_validate` per installed local-law module.
- `submitForm()` writes the non-synchronized values to `business_identity.settings`, then calls
  `cache.render`->`invalidateAll()`. A `resetConfiguration()` submit handler (the "Reset to
  Defaults" danger button) calls `$config->delete()`.
- Local-law tabs are built dynamically: `getAvailableLocalLawModules()` scans installed modules
  whose machine name starts with `business_identity_local_`, then `loadLocalLawFields()` renders
  the fields returned by each module's `hook_business_identity_local_laws_fields`.

`TestForm` is a minimal `ConfigFormBase` writing only `test_field` and `description` — a developer
scratch form.

## Config object & schema

Single config object **`business_identity.settings`** (`type: config_object`), schema in
`config/schema/business_identity.schema.yml`, install defaults in
`config/install/business_identity.settings.yml`. Documented top-level keys include:
`company_name`, `slogan`, `description`, `logo` (sequence of file ids), `address` (address mapping),
`address_simple`, `phone`, `support_email`, `support_phone`, `headquarters_address` /
`point_of_sale_address` (+ `_lat` / `_lng`), `email`, `contact_email`, `legal_name`, `tax_id`,
`company_registration`, `legal_form`, `registered_capital`, `website`, `social_links`
(facebook/twitter/linkedin/instagram/youtube/pinterest/tiktok URLs), `privacy_policy`,
`terms_conditions`, `business_sector`, `founding_year`, `employees_range`, `opening_hours`,
`measurement_unit`, `currency`, `date_format`, `time_format`, `timezone`, `meta_*`, `keywords`,
`primary_color` / `secondary_color` / `accent_color`, `font_family`, `maintenance_message`,
`google_maps_key`, `recaptcha_site_key`, `recaptcha_secret_key`.

Caveat: the running form persists **additional** keys not in the schema (e.g.
`legal_legal_name`, `contacts_support_email`, `address_business_address_address`,
`address_geolocation_lat`, `ecommerce_*`, `reviews_*`, `business_hours`, `local_laws`), while the
block and token/manager code read the schema keys (`legal_name`, `address`, …). The two sides do
not fully line up, so saved form data and displayed data can diverge. Config schema exists but is
partial relative to what the form writes.
