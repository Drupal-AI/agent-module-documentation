<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
The GDPR module is an umbrella project that helps make a Drupal site GDPR-compliant: it provides a self-assessment checklist, a "data stored about you" user page, and a set of submodules for consent tracking, data anonymization, field metadata, subject-access/removal tasks and obfuscated SQL dumps.

---

The base `gdpr` module itself is mostly orientation and glue. It defines a **checklist** (via the Checklist API) at `/admin/config/gdpr/checklist` — its `configure` route — that walks a site owner through responsibility acknowledgements, policy/content checks, site-feature reviews and configuration steps, and reports progress on the Status Report. It provides a **Content links** settings form (`/admin/config/gdpr/content-links`) that stores per-language URLs for a site's Privacy policy, Terms of use, About us and Impressum pages in the config object `gdpr.content_mapping` (key `links`), which the checklist reads to show whether each page is configured. It adds a per-user page `/user/{user}/gdpr` ("All your data") gated by the `view gdpr data summary` permission that redirects to the GDPR Tasks or GDPR Consent views when those submodules are enabled. The real functionality lives in five submodules: **anonymizer** (a plugin system for anonymizing values), **gdpr_fields** (mark entity fields as personal data with Right-to-Access/Right-to-be-Forgotten settings), **gdpr_consent** (versioned consent agreements and a consent field), **gdpr_tasks** (Subject Access Request and Right-to-be-Forgotten task workflow) and **gdpr_dump** (a Drush command producing anonymized SQL dumps). Installing the module does **not** by itself make a site compliant — it is a toolkit. Requires `checklistapi` (plus `entity`, `entity_reference_revisions`, `message`, `token`, `fakerphp/faker` for the submodules). Permissions: `administer gdpr settings`, `view gdpr data summary`.

---

- Run a GDPR self-assessment checklist and track completion on the site's Status Report.
- Record the URLs of the Privacy policy / Terms of use / About us / Impressum pages per language.
- Give users a single "All your data" page linking to their data requests or consents.
- Acknowledge (as site owner) that the module does not transfer legal responsibility.
- Surface which recommended GDPR-related modules are enabled or missing from the checklist.
- Detect whether a published Privacy Policy page exists and is linked in a menu.
- Provide a starting framework before configuring the consent, fields and tasks submodules.
- Point the checklist's content links at internal paths (e.g. /privacy-policy) or external PDFs.
- Gate access to the personal-data summary page behind a dedicated permission.
- Coordinate the GDPR submodules (consent, fields, tasks, anonymizer, dump) under one project.
- Guide editors to verify cookie-policy and tracking-tool compliance via checklist items.
- Remind admins of breach-notification (72h) and data-processing-record obligations.
- Link the checklist to the user-cancel and account-deletion configuration pages.
- Offer a consistent admin section (`/admin/config/gdpr`) for all GDPR settings.
- Track per-language privacy content so multilingual sites cover each language.
- Use the checklist progress percentage as a lightweight compliance KPI.
- Enable per-role visibility of the "data stored about you" tab on user profiles.
- Provide the base on which anonymization of user data (via anonymizer) is built.
- Prepare a site for Subject Access Requests by enabling the tasks submodule.
- Anonymize database dumps for sharing with developers via the dump submodule.
- Document data-collecting/tracking/social modules present on the site through the checklist.
- Give a compliance officer a single place to review Drupal-related GDPR posture.
