<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Loads the Sirdata Consent Management Platform (CMP) consent-banner scripts on your site's front end from two admin-entered keys.

---

CMP Sirdata is a thin, turnkey integration for the **Sirdata Consent Management Platform** — a GDPR/ePrivacy/CCPA cookie-consent banner certified against the IAB Transparency & Consent Framework (v2.1). You create a CMP in your Sirdata account, then enter two identifiers into the module's settings form (`/admin/config/system/cmp-sirdata`): the **Customer Key** (`customer_key`) and the **App Key** (`app_key`). When the module is enabled and both keys are present, it attaches two external Sirdata scripts to every non-admin front-end page — `cache.consentframework.com/js/pa/{app_key}/c/{customer_key}/stub` and `choices.consentframework.com/js/pa/{app_key}/c/{customer_key}/cmp` — which render and manage the consent banner in the browser. The module does no server-side work: no HTTP calls, no entities, no blocks, no theming. It ships one restricted permission (`administer cmp sirdata configuration`) gating the settings form, and the banner never appears in the Drupal admin UI. Consent decisions are collected client-side and exposed via the TCF signal; wiring your other analytics/marketing tags to respect that signal is done in Sirdata's dashboard/tag-conditioning tooling, not in Drupal. Note the drupal.org project page calls the two keys "partner" and "config" IDs, but the actual form fields are **Customer Key** and **App Key**.

---

- Integrate the Sirdata CMP consent banner into a Drupal site with no source-code changes.
- Enter a Customer Key and App Key on the settings form to activate the CMP.
- Load Sirdata's two external CMP scripts (`stub` + `cmp`) on the front end.
- Toggle the whole integration on/off with the Enable checkbox.
- Serve GDPR / ePrivacy / CCPA cookie-consent compliance workflows.
- Rely on Sirdata's IAB TCF v2.1-certified consent framework.
- Keep the CMP off admin routes (scripts attach only on non-admin pages).
- Require both keys before any script is emitted.
- Gate configuration behind the restricted `administer cmp sirdata configuration` permission.
- Re-render cached pages when the CMP config changes (config cache tags merged into page attachments).
- Show the consent banner to anonymous and authenticated visitors alike.
- Work with Drupal Big Pipe enabled (covered by the module's functional test).
- Manage banner design, languages, and behaviour in the Sirdata dashboard, not in Drupal.
- Expose a client-side TCF consent signal for other tags to read.
- Add the module's help page linking to Sirdata CMP documentation.
- Store the two keys in the `cmp_sirdata.settings` config object.
- Trim whitespace from both keys on save.
- Avoid any third-party PHP library or Composer dependency (core only).
- Support Drupal 9, 10, and 11.
- Provide a turnkey alternative to hand-pasting CMP script tags into a theme.
