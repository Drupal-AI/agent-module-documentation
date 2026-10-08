# Migrate retry — manual setup guide

**Migrate retry** (`migrate_retry`) makes migrations more resilient by
automatically re‑queuing rows that failed because of *transient* errors — a
network hiccup, a timeout, or a temporary problem at a third‑party destination —
so they can be migrated again later instead of being left permanently failed.

The classic scenario is a migration whose destination is an external service that
is briefly unavailable. Without this module those rows just fail and stay failed
until you notice and re‑run the whole migration. With Migrate retry, a row that
signals it needs retrying is put onto a queue, and a queue worker (run via cron)
picks it up and re‑migrates it. Retries are capped (at most five attempts per
row) so a persistently failing row can't clog the queue forever.

There is a small amount of wiring required — a line in `settings.php` to point
Drupal at the module's queue service — and a configuration page where you choose
*which* migrations should use the retry system. The actual "this row needs a
retry" signal comes from your migration code throwing a `MigrateException` with
the module's `STATUS_NEEDS_RETRY` status (or by enqueuing rows directly via the
module's queue manager service), so this is developer‑oriented tooling that lives
inside the Migrate framework. It depends only on core **Migrate** and provides
its own permissions.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, add the
   required `settings.php` line, and enable the module.
2. [Configuration](configuration/index.md) — choose which migrations use the
   retry system.

## Where it lives in the admin menu

After installation, the settings form lives at the `migrate_retry.settings`
configuration route, where you tick the migrations that should participate in the
retry system. See [Configuration](configuration/index.md).

## How it works

To make rows retry, your migration must mark them as needing a retry when they
fail — throw a `MigrateException` with
`\Drupal\migrate_retry\MigrateIdMapInterface::STATUS_NEEDS_RETRY`. Only rows with
that `source_row_status` are retried. Once marked, the row is enqueued by cron and
a queue worker re‑migrates it (up to the five‑attempt limit). The module ships an
example of throwing this exception in its test destination.

You can also enqueue rows to retry programmatically:

```php
// IDs of a migrate row where sourceid1 is 1 and sourceid2 is 34.
$source_ids = [1, 34];
$migration_id = 'my_custom_migration';
\Drupal::service('migrate_retry.queue_manager')
  ->enqueueMigrateRow($migration_id, $source_ids);
```
