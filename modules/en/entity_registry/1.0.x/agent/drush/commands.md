# Entity Registry — Drush commands

Provided by `Drush\Commands\EntityRegistryDrushCommands` (tagged `drush.command`). Each mirrors an
admin bulk operation. `<consumer_id>` is a consumer plugin ID.

| Command | Alias | Args / options | Does |
|---|---|---|---|
| `entity-registry:status [consumer_id]` | `er-status` | optional id | Show pending/processed/failed counts for all consumers or one. |
| `entity-registry:process <consumer_id>` | `er-process` | `--limit`, `--batch-size` | Process PENDING items now (Batch API). |
| `entity-registry:queue <consumer_id>` | `er-queue` | — | Mark all tracked items PENDING (queue all / reindex). |
| `entity-registry:retry <consumer_id>` | `er-retry` | — | Reset all FAILED items to PENDING. |
| `entity-registry:clear <consumer_id>` | `er-clear` | — | Call the consumer's `clearData()` and mark all its items PENDING. |
| `entity-registry:rebuild <consumer_id>` | `er-rebuild` | — | Delete all tracking rows and re-discover matching entities. |

Examples:

```bash
drush er-status
drush er-status my_consumer
drush entity-registry:process my_consumer --limit=500 --batch-size=100
drush er-queue my_consumer      # full reindex
drush er-retry my_consumer      # after fixing a transient failure cause
drush er-rebuild my_consumer    # after adding/changing getTrackedEntityTypes()
```

Backing service: `entity_registry.processor` (`IndexProcessor`) + `entity_registry.tracker`.
