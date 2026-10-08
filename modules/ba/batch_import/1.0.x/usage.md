Batch Import is a developer framework for running custom content-import migrations through Drupal's queue and Batch API, by writing migration plugin classes rather than YAML configuration.

---

Batch Import provides the plumbing to move data into Drupal entities in memory-safe chunks. A developer creates `@BatchMigration` plugin classes in a custom module (in `src/Plugin/batch_import/Migrations/`) that extend `BatchMigrationBase` and override `source()` (return the rows to import) and `destination()` (turn one row into a saved entity). Each registered migration appears as a row on the admin form at `/admin/content/batch-import`, where a user with the "run batch imports" permission selects migrations and either queues them for cron or runs them immediately through the Batch API with a progress bar. A pluggable "processor" layer sits between source and destination — the built-in `entity` processor auto-creates or loads the target entity before `destination()` runs — and a set of injectable "migration services" (node, user, taxonomy_term, media, file, paragraph, plus a local mapping table) provide shared entity load/create/save helpers. A `batch_import` database table maps each source id to the created entity id so re-runs update rather than duplicate. It is inspired by core Migrate but aimed at developers who prefer plain PHP classes; no source parsing (CSV, XML, remote DB) is built in — the developer's `source()` supplies the data. Requires no contrib dependencies (media/file/paragraph services need the matching core/contrib modules only if used).

---

- Import large data sets into Drupal entities in small batched chunks to avoid memory exhaustion.
- Run imports on cron by queueing them, so long migrations complete over multiple cron runs.
- Run imports interactively from the admin UI with a Batch API progress bar and per-migration result counts.
- Migrate nodes from a legacy system while preserving author, created date, and published status.
- Migrate users while preserving their original username, email, and existing password hash.
- Import taxonomy terms into a vocabulary, including descriptions, and look terms up by name.
- Create or attach managed file entities for files already present under `sites/default/files`.
- Import media entities and reference them from other imported entities via a media field.
- Import paragraph entities as part of a parent entity's structure.
- Pull source rows from a secondary database defined in `settings.php` (`$databases['source']`) via the migration's `origin`.
- Express ordering between migrations with the `dependencies` annotation so prerequisite migrations sort first on the form.
- Keep a source-to-destination id map (the `batch_import` table) so re-running a migration updates existing entities instead of duplicating them.
- Hide utility or sub-migrations from the form with the `hidden` annotation while still running them programmatically.
- Share reusable import logic across migrations by writing a `MigrationService` (auto-discovered from `src/BatchMigrationServices/`).
- Auto-inject the entity-type service, origin service, and `db_table` service into a migration based on its annotations.
- Swap in a custom `@BatchMigrationProcessor` to control exactly how data flows between `source()` and `destination()`.
- Run a migration without batching or queueing from custom code via `MigrationActivationService::runMigrationPlugins()`.
- Automatically clean up the id-map row for an imported entity when that entity is later deleted (via `hook_entity_delete`).
- Build a repeatable, code-reviewable migration path checked into a custom module instead of one-off scripts.
- Stage a multi-step content migration (users, then terms, then media, then nodes referencing them) as ordered dependent migrations.
- Look up or create a placeholder "dummy" user by email during a node import when the real author is unknown.
