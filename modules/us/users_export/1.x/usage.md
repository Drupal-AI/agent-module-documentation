<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Users Export exports the site's user accounts to a flat file (CSV and other formats) from an admin page.

---

Administrators periodically need the user list out of Drupal — for a mailing tool, a report, a compliance request, a migration. Doing it by hand means a Views export or a database query; Users Export packages it as an admin page at `/admin/people/export` that produces a flat file of accounts in various formats.

The security-relevant fact is that **this exports personal data**. A user export is names, email addresses, roles, and whatever account fields are included — a concentrated PII extract, and exactly the kind of data that carries handling obligations. So the `users export access export page` permission is the control that matters, and it belongs only to trusted administrators: anyone who holds it can walk away with the entire user base's contact details in one click.

Treat the feature accordingly — grant the permission narrowly, be aware that the exported file is unencrypted PII that should not linger in downloads or shared drives, and remember that on a site subject to GDPR or similar the export is a processing activity with the retention and access expectations that implies. The tool is straightforward; the care is in who may use it and what happens to the file.

---

- Export users to CSV.
- Get the user list as a file.
- Export accounts for a mailing tool.
- Produce a user report.
- Export user data for migration.
- Restrict export to trusted admins.
- Grant the export permission narrowly.
- Handle the export as PII.
- Export roles and emails.
- Meet a data request.
- Download the account list.
- Export in various formats.
- Limit who can export users.
- Avoid leaving PII in downloads.
- Treat the export as regulated data.
- Report on user accounts.
- Extract contact details.
- Export from the admin UI.
- Audit who holds export access.
- Export for compliance.