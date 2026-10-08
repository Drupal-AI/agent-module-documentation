<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Migrate content via cron jobs executes named Migrate API migrations on a schedule during Drupal cron runs.

---

Migrations normally run on demand via Drush or the migrate UI; this module lets a site run them unattended. `hook_cron()` reads a `migrations` list from the `simple_content_migration_via_cron` config, and for each entry stores a `<key>_next_execution` timestamp in state so the migration runs again only after its configured `time` interval has elapsed. Per-entry flags mirror Drush options: `update` calls `prepareUpdate()` on the id map and `sync` sets `syncSource` on the migration before import.

The module ships an example SQL source plugin (`src/Plugin/migrate/source/Content.php`, id `content_migration`) that reads a `products` table (title, sku, price, valid_date) keyed by sku, plus a matching example migration config. It depends on `migrate_plus`. Operators define their own migrations and add their machine names (with an interval and optional update/sync flags) to the module's config to have cron drive them.
---
- Install migrate_plus and this module together.
- Add a migration machine name to the module's `migrations` config with a `time` interval.
- Have a migration run automatically on cron instead of manual Drush execution.
- Set a per-migration interval (seconds) controlling how often cron re-runs it.
- Enable the `update` flag to re-import previously migrated rows on each run.
- Enable the `sync` flag to remove destination items missing from the source.
- Schedule a nightly product import from an external SQL database.
- Use the bundled `content_migration` example migration as a starting template.
- Read a legacy `products` table (title, sku, price, valid_date) via the example source plugin.
- Key incoming rows by `sku` string id as the example source does.
- Reformat a `valid_date` "date time" string into ISO `T`-separated datetime in prepareRow.
- Reset a stuck migration to IDLE automatically before each cron import.
- Skip execution for a migration whose interval has not yet elapsed.
- Avoid breaking cron when a configured migration key no longer exists (guarded instance creation).
- Drive multiple independent migrations from one cron run, each with its own timer.
- Adapt the source plugin to a different source table for custom imports.
