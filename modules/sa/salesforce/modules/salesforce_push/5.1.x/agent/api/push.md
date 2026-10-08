# How push works

## Trigger

`salesforce_push_entity_insert/update/delete()` run on every entity save/delete. For each
`salesforce_mapping` matching the entity type/bundle whose `sync_triggers` include the
matching `push_create` / `push_update` / `push_delete`, a push is initiated. Synchronous when
the mapping's `async` is false; otherwise enqueued.

## Queue & processors

- Queue: `queue.salesforce_push` (`PushQueue`, DB-backed).
- Processor plugin type: `plugin.manager.salesforce_push_queue_processor`. Shipped:
  `Rest` (`Plugin/SalesforcePushQueueProcessor/Rest.php`) — pushes via the REST client.
- Processing: `salesforce_push_cron()` drains the queue on cron, unless
  `salesforce.settings.standalone` is true, in which case use the endpoints:
  - `/salesforce_push/endpoint/{key}` (all mappings)
  - `/salesforce_push/{salesforce_mapping}/endpoint/{key}` (one mapping)

## Limits (config)

- `salesforce.settings.global_push_limit` — max records per queue run.
- Per mapping (`salesforce_mapping`): `push_limit`, `push_retries`, `push_frequency`,
  `push_standalone`, `always_upsert`.

## Add a custom push-queue processor

```php
namespace Drupal\my_module\Plugin\SalesforcePushQueueProcessor;

use Drupal\salesforce_push\PushQueueProcessorInterface;
// annotate with the module's push-queue-processor annotation and implement process()
```

## Read/verify config

```bash
drush cget salesforce.mapping.<id>                     # push_* sync_triggers, push_limit, async
drush cget salesforce.settings global_push_limit
```

Actual delivery to Salesforce requires a working authorization; the trigger/limit config that
determines *what and when* is local.
