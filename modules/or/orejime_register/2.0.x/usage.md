<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Orejime Register records every cookie-consent acceptance and decline made through the Orejime consent manager into a database table, so a site can show and audit what visitors chose.

---

Orejime handles the consent dialog itself; this module adds the record-keeping half. Each Orejime service becomes a column in a table created and extended programmatically — `Database::createColumn()` adds one tinyint column per service (named `{service_name}_{service_id}`), and `updateColumn()` renames it when a service is renamed. When a visitor makes a choice, the attached `cookies-register` JS posts the full consent set to `/orejime_register`, and `RegisterController::save()` writes a row (1 = accepted, 0 = declined) via the `orejime_register.database` service. An admin listing at `/admin/reports/orejime-register/list`, plus purge-all and purge-by-date forms, sit under Reports behind the parent module's `administer orejime entities` permission. There is no settings form and no configuration step — enabling the module is enough. It requires Orejime `^3` and declares `core_version_requirement: ^10.1 || ^11 || ^12`, already covering Drupal 12.

---

- Record which cookie categories visitors accept or decline.
- Keep a persistent log of consent decisions inside Drupal.
- Provide GDPR accountability evidence of consent choices.
- Show an auditor what consent options were offered.
- Track decline rates for a tracking or analytics category.
- List consent entries in the admin Reports UI.
- Add a register column automatically for each Orejime service.
- Rename a register column when a consent service is renamed.
- Purge all consent records before or after a review.
- Purge consent records within a specific date range.
- Enforce a manual data-retention period on consent data.
- Report on consent acceptance rates over time.
- Measure the effect of banner wording on consent.
- Complement the Orejime banner with server-side storage.
- Review consent data before a privacy audit.
- Retain consent decisions for a defined period.
- Track consent across a multilingual site.
- Prepare consent reporting for Drupal 11 or 12.
- Query the register programmatically via `orejime_register.database`.
- Back-fill register columns for existing services on install.
