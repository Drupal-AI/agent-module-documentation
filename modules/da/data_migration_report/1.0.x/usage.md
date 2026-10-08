Data Migration Report provides two Drush commands that generate content-mapping YAML files from a Drupal 7 source database and verify migrated data against the Drupal 10/11 destination, emitting console summaries and HTML diff reports.

---

The module is a developer/administrator aid for Drupal 7 → Drupal 10/11 upgrades built on top of `migrate_drupal`. It reads the legacy Drupal 7 database — connected either through a `migrate` database key in `settings.php` or through credentials saved at `/admin/config/system/data-migration-report-database-credentials` — and works alongside the `migrate_map_*` tables that a completed `migrate_drupal` run leaves behind. The `generate:content-mapping` (alias `gcm`) command enumerates D7 content entities (users, node types, vocabularies, custom blocks, comments, menus, path aliases, files, field collections, paragraphs) and writes one YAML mapping file per entity/bundle under `public://data_migration_report/migration-mapping/`, pairing each D7 field and column with the corresponding D10 field. The `migration:test` (alias `mt`) command takes an `entity_type` and `bundle`, loads that YAML, pulls the matching source and destination rows, normalizes them through a set of per-field-type and per-entity-type preprocessors, and reports the count of records that passed and failed (i.e. whose field values differ or that failed to migrate). It prints a summary table to the console and writes a styled HTML report (with pass/fail pie and per-field error bar charts) under `public://data_migration_report/migration-reports/`. Column-to-field mapping for both D7 and D10 field types is data-driven from the module's `field_types.yml`. The module defines no permissions of its own (the credentials form uses core `administer site configuration`) and stores the source connection in State rather than config.

---

- Verify that a completed Drupal 7 → Drupal 10/11 content migration preserved data integrity before decommissioning the legacy site.
- Generate per-bundle content-mapping YAML files automatically instead of hand-authoring D7-to-D10 field maps.
- Point the tool at the D7 database via a `migrate` connection key already present in `settings.php`.
- Configure the D7 source database connection through the admin UI when you cannot edit `settings.php`.
- Test a single node bundle (e.g. `drush mt node article`) and get a pass/fail count of migrated nodes.
- Limit a verification run to a sample of records with `--limit=10` while iterating on migration config.
- Verify a specific set of source records by ID with `--ids=12,34,56` to debug a known-bad migration.
- Confirm user accounts migrated correctly, including role mapping via the `migrate_map_d7_user_role` table.
- Validate taxonomy term migration including vocabulary remapping via `migrate_map_d7_taxonomy_vocabulary`.
- Check comment migration per node bundle (`comment_node_<type>` source bundles) against destination comment types.
- Verify menu links migrated to `menu_link_content`, including parent/`plid` and `link_path` normalization.
- Confirm URL aliases migrated to `path_alias` with leading-slash and `source`/`alias` normalization applied.
- Validate public and private file entities (`file` / `file_private`) migrated with correct URIs.
- Check field_collection and paragraphs items migrated into the D10 `paragraph` entity type.
- Produce a shareable HTML report with pass/fail pie charts and a per-field error-frequency bar chart for stakeholders.
- Identify exactly which fields most frequently differ after migration via the report's Fields Report chart.
- Drill into individual failing records (by NID/UID/TID/etc.) in the report's collapsible Issues section to see D7-vs-D10 values.
- Re-run mapping generation and diff both the source-of-truth YAML and destination after adjusting migration processors.
- Normalize text fields (stripping CR/LF/tab) so trivial whitespace differences do not register as migration errors.
- Normalize datetime values (D10 `T`-separated vs D7 space-separated) to avoid false-positive mismatches.
- Reconcile entity-reference-style fields (user/node/term/file/image references, link, entity_reference_revisions) whose column names differ between D7 and D10.
- Batch-generate mapping files for every content type in one `drush gcm` invocation before starting per-bundle testing.
- Use the console summary table as a quick CI/QA gate during iterative migration development.
- Skip regenerating unchanged mapping YAML (the tool detects identical content) and prompt before overwriting modified files.
