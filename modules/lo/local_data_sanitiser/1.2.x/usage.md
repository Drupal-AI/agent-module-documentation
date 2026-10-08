<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Local Data Sanitiser provides CLI (Drush) tooling to scrub personal data out of a *local* copy of a Drupal database — deleting webform submissions and anonymising user and content-entity field values so developers can work with realistic-but-safe data.

---

The module is `hidden: true` (Development package) and exposes no routes, permissions, forms, or web UI — it is driven entirely through `drush local-data:sanitise` (alias `lds`). Work is organised as pluggable "sanitiser tasks" (`@LocalDataSanitiserTask` plugins managed by `plugin.manager.local_data_sanitiser_task`): `WebformSubmissionsTask` (delete submissions), `UserAccountsTask` (anonymise user accounts), and `ContentEntityFieldsTask` (anonymise fields on content entities). A shared `FieldSanitiser` service detects sensitive fields by keyword/type and replaces them in place — building deterministic replacement text, tokenised values and synthetic emails, truncated to each field's max length — or clears them. A `ConfigFilter` plugin (`config_filter`) participates so sanitised values can flow through config export/import.

Critically, the command refuses to run unless the site is detected as a local environment (`getEnvironmentDescription()`), aborting with guidance to re-run with `--force` only if the operator confirms the database is safe to sanitise; it prints a pre-flight warning and requires interactive confirmation. It **modifies data in place (destructive) rather than exposing originals** — there is no route or export that reveals pre-sanitised values to the web, and the anonymisation overwrites the source fields. Security posture: no web attack surface at all (CLI-only, hidden, no routes/permissions); the only risk is operator error running it against a production database, which the local-environment guard and `--force` requirement are designed to prevent.

---
- Delete all webform submissions from a local database.
- Anonymise user account names, emails, and personal fields.
- Anonymise personal fields across content entities.
- Refuse to run outside a detected local environment.
- Force a run on a confirmed-safe non-local DB with `--force`.
- Run only a subset of tasks with `--tasks=webform_submissions,users`.
- List available sanitiser tasks with `--list-tasks`.
- Limit anonymisation to specific entity types with `--entity-types`.
- Tune throughput with `--batch-size`.
- Preview what a task would change before applying it.
- Confirm each selected task interactively before it runs.
- Produce GDPR-safe developer/staging databases.
- Strip PII before sharing a database dump with a contractor.
- Add a custom sanitiser task plugin for a bespoke entity.
- Integrate sanitisation into a `drush sql:sync` refresh workflow.
- Route sanitised values through config export via the config filter.
- Replace emails with synthetic, uniqueness-safe addresses.
- Truncate replacement values to each field's max length automatically.
- Clear (rather than replace) selected sensitive fields.
- Detect sensitive fields automatically by name/type keywords.
