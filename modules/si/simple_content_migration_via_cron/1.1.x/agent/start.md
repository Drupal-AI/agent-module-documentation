<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Migrate content via cron jobs (simple_content_migration_via_cron) — agent index

**Runs configured Migrate API migrations on cron, each at its own interval, with optional update/sync flags.**

- **Version:** 1.1.x
- **Core:** ^8 || ^9 || ^10
- **Depends on:** migrate_plus.
- **Driver:** `simple_content_migration_via_cron_cron()` reads config `simple_content_migration_via_cron:migrations`; per key it stores `<key>_next_execution` in state and imports via `MigrateExecutable` when due.
- **Flags per migration:** `time` (interval, seconds), `update` (idMap prepareUpdate), `sync` (syncSource).
- **Example source:** `@MigrateSource content_migration` (`src/Plugin/migrate/source/Content.php`) — SqlBase over a `products` table keyed by sku.

**Security:** no routes, permissions or user input; execution is driven by cron and site config only. Migration source is a trusted SQL connection defined by the operator.

See [configure/migrations.md](configure/migrations.md)
