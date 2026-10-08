<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
EU Cookie Compliance GTM bridges the EU Cookie Compliance (GDPR) module and Google Tag Manager: it lets you attach a JSON payload to each cookie category and pushes it to the GTM dataLayer whenever the visitor's consent changes.

---

This is a small glue module between `eu_cookie_compliance` and `google_tag`. It adds a **GTM data**
textarea to the cookie-category add/edit forms (`cookie_category_add_form` /
`cookie_category_edit_form`) via `hook_form_alter`, storing the entered JSON as a **third-party
setting** `gtm_data` on the `cookie_category` config entity (validated as a JSON object, saved with
an entity builder; cleared when left empty). The JSON supports placeholder tokens: `@status` is
replaced at runtime with `1` or `0` depending on whether *this* category is currently accepted, and
`@<machine_name>_status` references another category's accepted state (e.g. `@functional_status`).
On the front end the module attaches a JS library (`js/eu_cookie_compliance_hooks.js`, loaded in the
header on every page) that hooks into the events the main EU Cookie Compliance module fires on user
interaction; when consent is given/changed it reads each category's `gtm_data` (exposed through the
main module's `drupalSettings.eu_cookie_compliance.cookie_categories_details`), substitutes the
status tokens, and pushes the resulting object to the GTM `dataLayer` so tags can fire (or not)
according to consent. The module has no settings form, permission, route, or config of its own —
all configuration is the per-category `gtm_data` JSON, edited at
`/admin/config/system/eu-cookie-compliance/categories`.

---

- Push a `{"analytics": "@status"}` object to GTM so analytics tags fire only after analytics consent.
- Gate marketing/advertising tags in GTM on the marketing cookie category's consent.
- Send a category's accepted/declined state (1/0) to the dataLayer on every consent change.
- Reference another category's consent in a payload with `@functional_status`.
- Configure per-category GTM payloads as JSON directly on each cookie category form.
- Keep GTM tag firing compliant with the visitor's cookie choices.
- Update the dataLayer immediately when a user changes their consent selection.
- Store arbitrary JSON metadata per cookie category for use in GTM triggers.
- Drive Consent Mode-style signals into GTM from Drupal cookie categories.
- Avoid custom JavaScript to wire cookie consent into Google Tag Manager.
- Fire different GTM variables for functional, analytics, and marketing categories.
- Combine multiple category statuses into one dataLayer push via tokens.
- Expose consent state to GTM without editing the theme or GTM container manually.
- Ensure tags don't fire before consent by pushing `@status` = 0 initially.
- Localize/segment GTM triggers by cookie category using JSON keys.
- Centralise consent-to-GTM mapping in Drupal config (exportable third-party settings).
- Migrate hard-coded consent dataLayer pushes to per-category configuration.
- Support both google_tag 1.x and 2.x integrations.
- Provide GTM with a boolean per category to build consent-aware triggers.
- Push updated consent to GTM when the user revisits and changes preferences.
- Keep analytics off for users who decline analytics cookies, via the dataLayer flag.
- Map a Drupal cookie category machine name to a GTM dataLayer key.
- Roll out GDPR-compliant tag management using existing EU Cookie Compliance categories.
