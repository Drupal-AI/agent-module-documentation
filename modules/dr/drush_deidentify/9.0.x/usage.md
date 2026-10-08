<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Drush De-Identify adds Drush commands to export a sanitized database dump and to clean/de-identify sensitive columns in place using Faker.
---
The module (Drush-only, no web routes) registers `DrushDeidentifyCommands` via `drush.services.yml` with `@database` and `@module_handler`. `drush_deidentify:db-export` (alias `ice-export`) wraps Drush's `SqlBase::dump()`, always exporting cache tables as structure-only and letting you add more via `--omit_tables`; a `hook_drush_deidentify_export` alter lets other modules extend the structure-only list without patching. `drush_deidentify:db-clean` (alias `ice-clean`) takes a `table~column` list and overwrites those columns with Faker-generated values so a copied database no longer contains real user data.

Because it is invoked only through Drush on the CLI, there is no anonymous or HTTP attack surface. It is intended for creating shareable/de-identified copies of a production database for local or staging use. Setup: install the module and (its composer.json pulls `fakerphp/faker`) run the commands from the Drupal root. Handle the resulting dump as sensitive until de-identification is confirmed complete.
---
- Export a database dump with cache tables reduced to structure only.
- Add extra tables to the structure-only list with `--omit_tables`.
- Save the export to a file with `--result-file` (relative to Drupal root).
- Gzip-compress the export with `--gzip`.
- De-identify user emails/names in a copied database with Faker.
- Clean specific `table~column` pairs via `drush_deidentify:db-clean`.
- Produce a shareable local copy of production without real PII.
- Use `ice-export` / `ice-clean` aliases in scripts.
- Extend the excluded-tables list from a custom module via `hook_drush_deidentify_export`.
- Integrate the export into a CI pipeline that seeds test databases.
- Strip session/cache noise from a dump automatically.
- Replace comment author data with fake values before sharing.
- Sanitize watchdog message/location columns after import.
- Generate reproducible-shaped but fake data for demos.
- Keep table structure while dropping row data for cache tables.
- Combine with `drush sql:sync` workflows for safer refreshes.
- Run de-identification as a post-import cleanup step.
- Audit which columns still contain real data after cleaning.
- Document the `table~column` mapping used for a given site.
- Avoid exposing the raw dump before de-identification completes.
