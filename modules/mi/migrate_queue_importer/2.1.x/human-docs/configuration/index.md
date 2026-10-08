# Configuration

You configure Migration queue importer by creating one **cron migration** entity
per migration you want to run on a schedule. Each one pairs a migration with an
interval and a few flags.

## Open the admin screen

1. Log in as a user with the **Administer cron migrations** permission.
2. Go to **Configuration → Development → Cron migration**
   (`/admin/config/migrate_queue_importer/cron_migration`). Reach it via this menu
   link — the module doesn't add a *Configure* button on the Extend page.
3. Choose **Add** to create a cron migration (edit, delete, and enable/disable are
   available on each row).

## The cron migration form, field by field

- **Label** — a human‑friendly name for the schedule (for example "Hourly article
  import"). Admin‑facing only.
- **Machine name** — the internal id, generated from the label.
- **Migration** — the **migration plugin id** to import, entered as a string (for
  example `article_import`, or the id of a Migrate Plus migration). The migration
  itself must already exist; it's resolved at cron time.
- **Time (interval)** — the minimum number of **seconds** between imports of this
  migration. For example `3600` runs it at most once an hour; `0` makes it eligible
  on essentially every cron run. Give expensive migrations a long interval and
  cheap ones a short one, and stagger many migrations by giving each its own value.
- **Update** — when on, runs the migration as an update: previously imported rows
  are re‑processed so changes in the source are picked up.
- **Sync** — when on, removes destination items that no longer exist in the source,
  keeping the destination reconciled with the source. Combine **Update** + **Sync**
  to fully reconcile a destination on a schedule.
- **Ignore dependencies** — when on, skips dependency resolution for this migration
  (it won't queue required migrations first). Leave it off if your migration
  depends on others that also need to run.
- **Status (enabled)** — only **enabled** cron migrations are considered each cron
  run. Disable one to pause it without deleting it.

## How the interval and scheduling work

On each cron run the module loads all *enabled* cron migrations and, for each one,
compares the time since its last import (tracked by Migrate's own
`migrate_last_imported` record) against the interval. If enough time has passed —
and the queue isn't already backed up — it queues that migration for import. Unless
**Ignore dependencies** is set, it queues required dependency migrations first, in
the correct order.

A separate queue worker then processes the queued items, running the actual import
with a per‑run time budget (about 30 seconds), so a large import naturally spreads
across successive cron runs. If an import throws an error, the item stays in the
queue and is retried on the next cron run.

The interval is therefore a **minimum** time between imports, not a guaranteed
"run exactly every N seconds" — the migration runs on the first cron after the
interval has elapsed.

## Testing a schedule

Trigger cron the right way — the module intentionally **skips scheduling when cron
is run from the system cron settings form** (to avoid blocking that interactive
request). Use real cron instead:

```bash
drush cron
```

Make sure the `migration` id you referenced actually exists, then check that the
migration imported as expected. You can inspect how many items are waiting in the
queue named `migrations_importer` if you need to debug backlog.

## Managing schedules as configuration

Each cron migration is exportable configuration (named
`migrate_queue_importer.cron_migration.<id>`), so include them in your normal
`drush cex` / `drush cim` workflow to move schedules between environments, or split
them per‑environment with Config Split. There are no Drush commands specific to this
module — it runs entirely off `drush cron` or your real cron job.
