<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Advanced Sanitize rewrites data already stored in a Drupal database in place, replacing entity fields and raw table columns with FakerPHP fakes, constants, or SQL expressions according to a developer-authored YAML definition file.

---

Advanced Sanitize is a Development-package tool for anonymizing a database after cloning production into a dev or staging environment. Rather than plugging into Drush's core `sql:sanitize`, it reads a YAML definition file whose path you set at `/admin/config/development/sanitize-settings`, then rewrites the listed values. Definitions come in two shapes: entity records (`entity_id` + `bundle_id` + `field_mapping`, processed through the Entity API so entities are loaded and saved) and SQL-table records (`table_name` + `unique_column` + `column_mapping`, processed with direct `UPDATE` queries). Each mapping picks a data provider — `faker` (any FakerPHP method, with optional `locale` and `parameters`), `constant` (a fixed value), or `expression` (a raw SQL expression, table records only). You can skip specific rows with `ignore_entity_id` / `ignore_field_values` and force uniqueness with `ensure_unique`. Everything runs through the Batch API with configurable per-batch limits, revisionable entities have their revisions rewritten to match, and seven events let other modules observe or alter the process. Launch it from the settings form's **Sanitize** button or the Drush command `advanced_sanitize:sanitize` (alias `adsan`).

---

- Anonymize a production database copy before or after moving it to dev/staging.
- Replace user email addresses with Faker `safeEmail()` values.
- Replace names, usernames, phone numbers, and addresses with fake equivalents.
- Mask free-text fields (bodies, notes, profiles) with Faker `paragraph()` output.
- Overwrite IBAN / financial fields with Faker `iban()` values.
- Set a fixed constant value on a field or column (e.g. a single test string or number).
- Rewrite raw (non-entity) database table columns that the Entity API does not cover.
- Apply a raw SQL expression to a column (e.g. numeric offset) during sanitization.
- Sanitize a specific content type only, by naming its `bundle_id`.
- Sanitize a field across all bundles of an entity type using `bundle_id: default`.
- Keep certain records untouched by listing their ids in `ignore_entity_id`.
- Preserve known test/reference values via `ignore_field_values`.
- Guarantee unique replacements (e.g. unique emails) with `ensure_unique`.
- Localize generated data per field with a Faker `locale` (e.g. `en_GB`, `nl_NL`).
- Pass parameters to Faker methods (e.g. `paragraph` sentence count, `iban` country/bank).
- Run sanitization from the admin settings form with one click.
- Run sanitization non-interactively in CI via `drush advanced_sanitize:sanitize` (`adsan`).
- Tune batch throughput with separate entity and SQL per-batch limits.
- Rewrite all revisions of a revisionable entity to match the sanitized default revision.
- Hook into the run with events (started, preprocess-definition, pre/post sanitize, finished).
- Alter or extend the definition list at runtime via the preprocess/started events.
- Build a repeatable, config-driven anonymization step for dev-database provisioning.
