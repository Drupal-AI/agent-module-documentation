<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
GDPR Dump provides a Drush command that exports the site database as SQL with configured columns anonymized (and configured tables emptied), so you can share a sanitized dump without leaking personal data.

---

The module adds the Drush command `gdpr:sql:dump` (alias `gdpr-sql-dump`), a wrapper around Drupal's SQL dump that runs each configured column value through an [Anonymizer](../../anonymizer/3.1.x/agent/start.md) plugin before it is written out. Which columns get anonymized (and which tables are emptied) is set on the **SQL Dump settings** form at `/admin/config/gdpr/dump-settings` (route `gdpr_dump.settings`, the module's `configure` route, permission `administer site configuration`) and stored in the config object `gdpr_dump.table_map`: `mapping[<table>][<column>] = <anonymizer_plugin_id>` and `empty_tables[<table>] = 1`. The form lists table columns (always surfacing sensitive tables like `users_field_data`, `comment_field_data`, `contact_message`, `webform_submission*`, and per-field `user__*`/`comment__*`/`contact_message__*` tables) with a select of available anonymizer plugins per column. At dump time the services `gdpr_dump.sql_dump` (`GdprSqlDump`) and `gdpr_dump.sanitize` (`GdprSanitize`) — both wired with `@anonymizer.anonymizer_factory` and `@gdpr_dump.database_manager` — read the map and replace values (e.g. mapping `users_field_data.mail` to `email_anonymizer` yields fake emails in the dump). There are database-specific dump backends for MySQL, PostgreSQL and SQLite. Requires `gdpr` and `anonymizer` (and Drush). No permissions of its own; the settings form uses core `administer site configuration`.

---

- Produce a developer database dump with real user emails replaced by fake ones.
- Anonymize usernames in an SQL export before sharing it with contractors.
- Empty high-volume or sensitive tables (e.g. sessions, logs) from a dump entirely.
- Map `users_field_data.mail` to `email_anonymizer` for GDPR-safe exports.
- Scrub `comment_field_data` author fields when exporting a forum database.
- Sanitize webform submission tables that hold personal data.
- Create a sanitized snapshot for staging without copying personal data.
- Run `drush gdpr:sql:dump --result-file=../sanitized.sql` in a CI pipeline.
- Gzip an anonymized dump for transfer (`--gzip`).
- Apply per-column anonymization consistently across environments via config.
- Anonymize contact_message tables before sharing support data.
- Replace phone/number columns with fake numbers using number_anonymizer.
- Empty a table of tracking data while keeping schema in the dump.
- Provide a repeatable, config-driven sanitization instead of ad-hoc SQL.
- Anonymize per-field user tables (`user__field_*`) that store profile PII.
- Export a data-only dump with anonymization for a bug reproduction.
- Keep referential structure while obfuscating identifying values.
- Standardize what gets scrubbed across a team via `gdpr_dump.table_map` config.
- Sanitize a database for a security review or external audit.
- Combine emptying and anonymization to minimize personal data in exports.
- Use the same anonymizer plugins as GDPR Fields for consistent scrubbing.
