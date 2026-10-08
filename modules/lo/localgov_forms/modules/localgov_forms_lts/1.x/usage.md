Copies Webform submissions into a separate "long term storage" database (with optional PII redaction) so the operational site can purge them while a warehouse copy remains for reporting and retention.

---

`localgov_forms_lts` (experimental) gives Webform submissions a second home: an operator declares an extra database connection under the `localgov_forms_lts` key in `settings.php`, and the module maintains a copy of the `webform_submission` entity tables there. On install it recreates the webform_submission storage schema in that database; a `hook_requirements()` check reports whether the LTS database is reachable. Copying is driven by cron (`hook_cron` → up to 50 submissions per run, those added/changed since the last run and not in draft) and by a Drush command (`localgov-forms-lts:copy`, alias `forms-lts-copy`, `--force`) that batch-copies existing submissions. Copying is disabled by default and enabled from the config form at `/admin/structure/webform/config/submissions-lts`, where you can also pick a PII redactor plugin (the redactor plugin type comes from the parent `localgov_forms` module) that strips personally identifiable elements before each copy. The copied submissions are browsable through an "LTS" tab in the Webform submissions UI, with read-only View and Notes routes that load the entity from the LTS database. Because the operational and LTS databases are separate, you can set individual Webforms to purge their live submissions after a chosen period while the LTS copy persists — enabling data-minimisation on the live site plus long-term reporting/warehousing. Files attached to submissions are not moved to LTS, and removal of old LTS records after a retention period is noted as a future todo.

---

- Keep a long-term/warehouse copy of Webform submissions in a database separate from the operational site.
- Let the live site purge old Webform submissions while retaining a copy for reporting and analysis.
- Meet data-retention requirements by storing submissions in a dedicated retention database.
- Optionally redact PII (name, email, phone, addresses, DOB, etc.) from submissions as they are copied.
- Choose a PII redactor plugin (e.g. the parent module's "Best effort PII redactor") from the LTS config page.
- Copy submissions automatically on cron (up to 50 new/changed, non-draft submissions per run).
- Back-fill the LTS database with all existing submissions using `drush localgov-forms-lts:copy --force`.
- Run the copy manually/on demand via the `localgov-forms-lts:copy` (alias `forms-lts-copy`) Drush command.
- Enable or disable periodic copying per environment from `/admin/structure/webform/config/submissions-lts`.
- Turn off copying on dev/stage environments (or override `localgov_forms_lts.settings:is_copying_enabled` in settings.php) so only production writes to the warehouse.
- Point different site environments at different LTS databases to avoid cross-environment contamination.
- Browse retained submissions through the "LTS" tab in the Webform submissions listing (`/admin/structure/webform/submissions/lts`).
- View an individual retained submission (read-only) loaded from the LTS database.
- View an individual retained submission's admin notes from the LTS database.
- Verify LTS database availability via the status report (`/admin/reports/status`, "LocalGov Forms LTS").
- Feed a downstream data warehouse / BI pipeline from the LTS database instead of the live Drupal DB.
- Reduce PII exposure on the operational database by redacting during copy and purging live submissions.
- Set up a second database in DDEV for testing the LTS workflow (post-start hook + settings.php connection, per README).
- Preserve submission metadata and values (though not uploaded files) beyond the live form's purge window.
- Separate reporting/analytics query load from the operational database by querying the LTS copy.
