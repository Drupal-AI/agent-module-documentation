<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# content_migration_overview — agent start

info.yml name **Content Migration Overview**, version **1.0.1**, package `Migration`,
core `^10.3 || ^11`. Depends on core `migrate_drupal`. Project machine name
`content_migration_overview`.

**What it actually is:** a CLI validation/reporting tool for a **Drupal 7 → 10.3+/11**
content migration — NOT a live web dashboard. It diffs the *source* D7 database against the
*destination* `migrate_map_*` tables and reports how many users / nodes / taxonomy terms
migrated (total / passed / failed, plus the failed source IDs). There is no web report
route; the only route is the source-DB credential form.

## Core mechanism
- Drush command `drush migration:stat` (alias `drush mstat`) — class
  `src/Commands/ContentMigrationOverviewCommands.php` (registered in `drush.services.yml`,
  ctor deps `@database @state @file_system @file_url_generator @renderer`). Uses core
  `MigrationConfigurationTrait`. CLI only.
- Comparisons (source query keyed by source id, intersected with the migrate map):
  - **Users**: `users` (uid>0) vs `migrate_map_d7_user`.
  - **Nodes**: per node type from `migrate_map_d7_node_type`, counts `node` rows vs
    `migrate_map_d7_node_complete__<type>` (table name truncated to 63 chars minus prefix).
  - **Terms**: per vocabulary from `migrate_map_d7_taxonomy_vocabulary`, counts
    `taxonomy_term_data` vs `migrate_map_d7_taxonomy_term__<machine_name>`.
- Output: prints a Symfony Console summary table to the terminal, then writes three static
  HTML reports (themes `migration_summary`, `node_migration_summary`,
  `taxonomy_migration_summary`, defined in `.module` `hook_theme`; templates in
  `templates/`) to `public://migration-reports/{migration,node,taxonomy}_migration_summary_report.html`
  and logs their URLs. Reports show counts, per-type pie charts (chart.js/jQuery via CDN),
  and expandable lists of failed source IDs.

## Source-DB connection (one of two)
- Add a `migrate`-keyed connection to `$databases` in `settings.php` (core convention), OR
- Enter it in the UI form `src/Form/CredentialForm.php` at
  `/admin/config/system/migrate-database-credentials` (route
  `content_migration_overview.migrate_database_credentials`, `configure:` target, permission
  **`administer site configuration`**; menu link under Config → System). The form stores the
  driver/settings in **state** (`migrate_database_driver`, `migrate_database`) — not config.
  `checkSourceConnection()` prefers the `migrate` connection, else falls back to state.

## Facts for agents
- No `*.permissions.yml`, no `*.install`, no `config/` schema (the "configure" form uses
  `state`, not config entities). Only theme hooks + one form route + one Drush command.
- The command is read-only: it runs SELECTs and compares map tables. It does **not**
  execute, import, roll back, or stop any migration.
- Requires that a D7→D10/11 migration has already been run (the `migrate_map_d7_*` tables and
  a reachable D7 source DB must exist); otherwise counts are empty / the command errors out
  on missing tables.

No subdocs — single-file module, fully covered here. Human-oriented guide: `../human-docs/`.
