# Configuration

Entity Registry has no traditional settings-only page in its module info, but it does
provide a real admin **dashboard** for managing consumers, a small set of global
settings, a permission, and matching Drush commands.

## Permission

All the admin pages and bulk operations are gated by the **administer entity
registry** permission, which is restricted — keep it on trusted administrator roles
only. Grant it under **People → Permissions**.

## The dashboard

Go to **Configuration → System → Entity Registry**
(`/admin/config/system/entity-registry`). It lists every consumer plugin with live
**pending / processed / failed** counts. Each consumer has a detail page where you
can:

- **Configure tracked bundles** — restrict which entity types and bundles this
  consumer handles, without editing plugin code.
- **Process** — run the pending items now.
- **Queue** — mark all tracked items pending (a full reindex).
- **Retry** — reset failed items back to pending.
- **Clear** — clear the consumer's own stored data and re-mark its items pending.
- **Rebuild** — delete the tracking rows and re-discover all matching entities (do
  this after adding a consumer or changing which bundles it tracks).
- **Inspect failed items** — see what failed and why.

## Global settings

The module stores a few global tuning values in the `entity_registry.settings`
configuration:

- **Cron enabled** (`cron_enabled`, default **true**) — whether asynchronous items
  are processed on cron. Turn it off to pause background processing.
- **Batch size** (`batch_size`, default **50**) — how many items each consumer
  processes per cron run.
- **Chunk size** (`chunk_size`, default **1000**) — the database chunk size used for
  bulk inserts.

Each consumer can also override the batch size independently via a per-consumer
configuration object (`entity_registry.consumer.<id>.batch_size`), used when it's
greater than zero, otherwise the global value applies.

## Drush commands

Every dashboard operation has a matching Drush command (each takes a consumer plugin
id):

| Command | Alias | Does |
|---------|-------|------|
| `entity-registry:status [consumer_id]` | `er-status` | Show pending/processed/failed counts for all consumers or one. |
| `entity-registry:process <consumer_id>` | `er-process` | Process pending items now (supports `--limit`, `--batch-size`). |
| `entity-registry:queue <consumer_id>` | `er-queue` | Mark all tracked items pending (full reindex). |
| `entity-registry:retry <consumer_id>` | `er-retry` | Reset failed items to pending. |
| `entity-registry:clear <consumer_id>` | `er-clear` | Clear the consumer's stored data and re-mark items pending. |
| `entity-registry:rebuild <consumer_id>` | `er-rebuild` | Delete tracking rows and re-discover matching entities. |

Examples:

```bash
drush er-status
drush entity-registry:process my_consumer --limit=500 --batch-size=100
drush er-queue my_consumer      # full reindex
drush er-retry my_consumer      # after fixing a transient failure
drush er-rebuild my_consumer    # after changing which bundles are tracked
```

## The processing lifecycle (for reference)

Each tracked change becomes a row keyed by consumer, entity type, entity id, and
language, with a status of pending, processed, or failed (with a retry count). Your
consumer's `processItem()` return value drives that status: **TRUE** marks it
processed, **FALSE** marks it failed and increments the retry count (retried up to a
cap), and **NULL** defers it — leaving it pending so the next cron or batch run picks
it up. That last option is handy for expensive work you don't want to run
synchronously during the entity save.
