<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# EU Cookie Compliance GTM — agent index

Glue between **eu_cookie_compliance** (GDPR) and **google_tag**. Adds a per-cookie-category JSON
payload and pushes it to the GTM `dataLayer` on consent changes. No settings form, permission, or
route of its own. Depends on `eu_cookie_compliance` and `google_tag`.

- **The `gtm_data` per-category setting, the `@status` tokens, and how it reaches the dataLayer** →
  [configure/gtm-data.md](configure/gtm-data.md)

Key facts:
- Adds a **GTM data** textarea to the cookie category add/edit forms
  (`cookie_category_add_form` / `cookie_category_edit_form`), at
  `/admin/config/system/eu-cookie-compliance/categories`.
- Stored as a **third-party setting** `gtm_data` (a JSON object) on the `cookie_category` config
  entity: `$category->getThirdPartySetting('eu_cookie_compliance_gtm', 'gtm_data')`.
- Tokens in the JSON: `@status` → `1`/`0` for this category's consent; `@<machine>_status` → another
  category's consent (e.g. `@functional_status`).
- Front-end JS (`js/eu_cookie_compliance_hooks.js`, header library) reads
  `drupalSettings.eu_cookie_compliance.cookie_categories_details`, substitutes tokens on consent
  events, and pushes to the GTM `dataLayer`.
- No config schema, Drush, or plugins.
