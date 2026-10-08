# Orejime Register — manual setup guide

**Orejime Register** (`orejime_register`) is a lightweight GDPR‑compliance helper
that **records the cookie‑consent decisions** visitors make through the
[Orejime](https://www.drupal.org/project/orejime) consent manager. Orejime handles
the consent dialog itself; this module adds the record‑keeping half, writing each
acceptance and decline into a dedicated database table so you can show what visitors
chose.

It was built with GDPR Article 7.1 in mind — the requirement that a data controller
be able to demonstrate consent. Each Orejime service becomes a column in the table
(columns are created automatically per service), and a row is written when a visitor
makes a choice. You can then view the stored consents and purge old records from a
report page in the admin UI. Because consent records are personal data, the purge
tools are your retention mechanism — someone still has to decide and apply the
retention policy.

There is **no setup form to fill in**: install it and it starts recording
automatically. This guide is written for a **human** clicking through the admin UI.
If you want terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module together with its Orejime dependency.

There is **no configuration form** for this module — no configuration is required. It
provides a report/listing page (and purge options), described below.

## Where it lives in the admin menu

Once enabled, the stored consents are at **Reports → Orejime Register**
(`/admin/reports/orejime-register/list`), behind the *administer orejime entities*
permission. The same area offers **purge** options (a full purge, or purge by date).

## How to use it

1. **Make sure Orejime is set up and collecting consent** — Orejime Register only
   records what Orejime collects, so the consent banner and its services need to be
   working first.
2. **Enable the module.** From that point, each acceptance or decline a visitor makes
   is written to the register automatically. There is nothing to configure.
3. **View the records** at **Reports → Orejime Register**
   (`/admin/reports/orejime-register/list`) to see what visitors chose — useful ahead
   of a privacy audit or data‑protection review.
4. **Set a retention policy and purge.** Consent records are personal data, so decide
   how long to keep them and use the **full purge** or **purge by date** options to
   clear records past your retention period.
