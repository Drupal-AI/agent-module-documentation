<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Migrate Upgrade adds Drush commands that drive a complete Drupal-to-Drupal upgrade (Drupal 6/7 → current) from the command line, and can optionally export the generated migrations as `migrate_plus` config entities for customization instead of running them.

---

Migrate Upgrade is the Drush front-end to Drupal core's `migrate_drupal` upgrade path. It provides two commands: `migrate:upgrade` (alias `mup`), which reads a legacy Drupal 6 or 7 site's database and files and imports its configuration and content into the current site, and `migrate:upgrade-rollback` (alias `mupr`), which removes everything a previous upgrade imported. The source database is supplied either inline with `--legacy-db-url` (a Drupal 6-style DB URL) or by referencing a connection key already defined in `settings.php` with `--legacy-db-key`; legacy public files are located with `--legacy-root` (an HTTP domain or a local path). The command auto-detects the source Drupal version through `migrate_drupal` and builds the appropriate migration plugins. Run without flags it performs the import immediately and records a `migrate_drupal_ui.performed` state marker so the rollback command knows an upgrade happened. Run with `--configure-only` it does **not** execute the migrations — instead it exports each one as a `migrate_plus.migration.*` config entity (id-prefixed with `upgrade_`, or a custom `--migration-prefix`) grouped under a generated `migrate_plus.migration_group.migrate_drupal_<version>` entity, so a developer can edit the YAML, move it into a custom module, and run a tailored migration with `migrate_tools`. It is designed to be run on a freshly installed, otherwise-empty target site with only the desired destination modules enabled. It carries no admin UI, permissions, or config schema of its own — everything happens through Drush.

---

- Upgrade a legacy Drupal 6 site's content and config into the current site with a single `drush migrate:upgrade` run
- Upgrade a legacy Drupal 7 site to Drupal 10/11 from the command line
- Point at a source database inline via `--legacy-db-url='mysql://user:pw@host/d7db'`
- Reuse a source connection already defined in `settings.php` via `--legacy-db-key`
- Migrate a source site that used a shared table prefix with `--legacy-db-prefix`
- Pull legacy public files over HTTP by giving `--legacy-root=https://old.example.com`
- Migrate legacy files from a local copy by giving `--legacy-root` a filesystem path
- Generate migration config entities without running them using `--configure-only`
- Customize the id prefix of generated migrations with `--migration-prefix=d7_custom_`
- Produce editable `migrate_plus.migration.*` YAML to fold into a custom migration module
- Capture the source DB connection in a generated `migrate_plus.migration_group` entity
- Roll back a completed upgrade (content plus generated config entities) with `drush migrate:upgrade-rollback`
- Roll back an upgrade that was originally run through core's Migrate Drupal UI
- Script repeatable, non-interactive upgrades in CI instead of clicking through the core upgrade UI
- Detect the source Drupal version automatically before building migrations
- Stage a Drupal-to-Drupal migration for iterative refinement (export, edit, re-run) rather than one-shot import
- Seed a custom migration project from the real migrations core would run for your source site
- Migrate a Postgres-schema source by setting `--legacy-db-prefix=schema.`
- Combine with `migrate_tools` to selectively execute or roll back the generated migrations
- Combine with `migrate_plus` so the generated config entities are discoverable and manageable
- Run the whole upgrade unattended on a clean target install with only destination modules enabled
- Re-generate migration configuration after enabling additional destination modules on the target
- Provide a rollback safety net during upgrade rehearsals before the production cutover
