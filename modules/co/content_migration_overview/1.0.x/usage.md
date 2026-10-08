<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Content Migration Overview validates a Drupal 7 → 10.3+/11 content migration and reports how much migrated.

---

Content Migration Overview is a **CLI validation and reporting tool** for a Drupal-to-Drupal
content migration (Drupal 7 to Drupal 10.3+ / 11). It compares the *source* Drupal 7 database
against the destination site's `migrate_map_*` tables and reports, for users, nodes and
taxonomy terms, how many items migrated — total, passed and failed — including the source IDs
that failed. It depends on core Migrate Drupal and lives in the Migration package. It is not a
live web dashboard; there is no report page in the admin UI.

The work is done by a Drush command, `drush migration:stat` (alias `drush mstat`), run by a
privileged operator during or after an upgrade. Before it can report anything the module needs
to reach the source (old-site) database: either add a `migrate`-keyed connection to
`$databases` in `settings.php`, or enter the connection in the form at
`/admin/config/system/migrate-database-credentials` (permission: administer site
configuration), which stores it in Drupal state. The command prints a summary table to the
terminal and writes three static HTML reports under `public://migration-reports/` with counts,
pie charts and expandable lists of failed IDs. It only reads and compares data; it does not
run, import, roll back or stop any migration.

---

- Validate a completed Drupal 7 → Drupal 10.3+/11 content migration.
- Run `drush migration:stat` (or the alias `drush mstat`) from the CLI.
- Compare the source D7 database against the destination `migrate_map_*` tables.
- Report total / passed / failed counts for users, nodes and taxonomy terms.
- List the source IDs that failed to migrate.
- Print a migration summary table to the terminal.
- Generate HTML reports at `public://migration-reports/`.
- Configure the source database via a `migrate` connection in `settings.php`.
- Or configure the source database at `/admin/config/system/migrate-database-credentials`.
- Store the entered credentials in Drupal state (not config).
- Depend on core Migrate Drupal.
- Read migration map tables; do not execute or roll back migrations.
- Require an already-run migration and a reachable D7 source database.
- Gate the credentials form behind the administer site configuration permission.
- Track migration completeness for an upgrade.
