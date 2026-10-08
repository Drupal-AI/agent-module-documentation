<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Migrate Source UI adds an admin form to upload a CSV, XML, or JSON file and run an existing file-based migration against it — no drush or code needed to feed a migration its source data.

---

The module provides a simple two-page UI on top of Drupal's Migrate API and `migrate_tools`. At
`/admin/content/migrate_source_ui` (route `migrate_source_ui.form`) it lists the migrations
whose source plugin reads an uploaded file — CSV (via `migrate_source_csv`), URL/JSON+XML (via
`migrate_plus`'s `Url` source), and spreadsheets (via `migrate_spreadsheet`) — lets you pick
one, upload a source file, and runs it. It detects the migration's expected file type and only
accepts the allowed extensions (`csv`, `json`, `xml`); on submit it saves the uploaded file
(to Drupal's temporary scheme by default, or to a configured directory), overrides the
migration's source `path` to point at that file, optionally resets a stuck migration to Idle,
and executes the import through the migration plugin (reporting messages via a stub message
source). A settings page at `/admin/config/content/migrate_source_ui` (route
`migrate_source_ui.settings`) exposes a single option, `file_temp_directory`, stored in the
`migrate_source_ui.settings` config object, controlling where uploaded files are written. Two
permissions gate the two pages: `access migrate source ui` (run migrations) and
`administer migrate source ui` (change settings). It defines no migrations of its own — you
still author the migration (as config via `migrate_plus`, or a module) — it only supplies the
source file at run time.

---

- Upload a CSV of users and run an existing user-import migration against it through the UI.
- Let a content editor re-run a product import by uploading a new CSV, without shell access.
- Feed a JSON file to a `migrate_plus` Url-source migration from the browser.
- Import an XML feed export by uploading the XML file to a matching migration.
- Run a spreadsheet-based migration by uploading an .xlsx via the UI (with `migrate_spreadsheet`).
- Avoid teaching non-developers `drush migrate:import` for routine file imports.
- Point a migration at a freshly uploaded file instead of a fixed server path.
- Reset a stuck migration to Idle automatically when re-running it from the form.
- Restrict who can run file migrations with the `access migrate source ui` permission.
- Restrict who can change the module's settings with `administer migrate source ui`.
- Configure a dedicated `file_temp_directory` so uploaded source files land in a known place.
- Store uploaded sources in a private filesystem directory for sensitive data.
- Provide a self-service import page for a data-entry team.
- Validate that only csv/json/xml files are accepted for a given migration.
- Re-import updated data periodically by uploading the latest export file.
- Keep migration definitions in config while supplying the data file at run time.
- Test a migration quickly by uploading a small sample file through the UI.
- Give clients a simple screen to load their content export into a new Drupal site.
- Run one-off content loads during a site build without writing drush commands.
- Combine with `migrate_tools` to see migration status after a UI-driven run.
- Let editors choose the correct migration from a list filtered to file-based sources.
- Onboard bulk taxonomy terms from a CSV via a matching migration.
