<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Migrate Export takes content that already exists on a site and writes out a **generated module** of Migrate API migrations plus their source data, turning "these entities should exist on every environment" into code rather than a manual step.

---

Getting content into another environment has three usual answers, all imperfect: a database copy (too much, and wrong for a fresh site), Default Content (good, but its own serialization format), or hand-writing migrations (correct and slow). Entity Migrate Export automates the third. You pick entity types on the export form at `/admin/config/development/entity-export` (or run `drush eme:export --types node,block_content`), and the module discovers everything the selection references — directly and in reverse, via its reference-discovery plugins — then emits a Drupal module: one migration YAML per entity type/bundle under `migrations/`, one JSON source file per entity under `data/`, copied binary assets under `assets/`, and a small `.module` that wires the Migrate Plus `url`/`json` source to the module's real path at import time. From the UI the result is downloaded as `eme.tar.gz`; from Drush it is written straight into `modules/custom`. On the target site you enable the generated module and run `drush migrate:import --group <group> --execute-dependencies` (with Migrate Plus and Migrate Tools present). The `Collection` tab lists modules eme has generated before and re-exports them in place, so an export can be refreshed as content changes. The work is carried by `ExportPluginBase`/`JsonFiles`, the two plugin managers (`eme.export_plugin_manager`, `eme.discovery_plugin_manager`), `InterfaceAwareExportBatchRunner`, and the `EmeCommands` Drush class; eme itself has no contrib dependencies, though the generated module needs `migrate_plus`.

---

- Turn existing content into a migration module.
- Ship reference/starter content with a codebase.
- Recreate a set of nodes on a fresh environment.
- Export content for a client handover.
- Review content changes as migration files in a merge request.
- Seed a new site with demo content.
- Move content between environments reproducibly.
- Avoid a database copy for just a few entities.
- Export a collection of related entities together.
- Generate migrations instead of hand-writing them.
- Rebuild demo content after a reset.
- Version-control structural content.
- Provide test fixtures built from real content.
- Export taxonomy and media alongside nodes automatically.
- Run the generated migration from Drush in CI.
- Refresh a previous export after content changes (`--update` / Collection).
- Hand content to another team as code.
- Migrate one site section into a new build.
- Export with file assets copied into the module.
- Restrict the export form to selected entity types via ignored-types settings.
