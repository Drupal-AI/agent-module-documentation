# Entity Registry — manual setup guide

**Entity Registry** (`entity_registry`) is a developer framework that automatically
tracks every insert, update, and delete on content entities — per translation — and
dispatches those changes to **consumer plugins** you write. The point is that you
only write the processing logic (index this, sync that, audit the other), and the
module handles all the plumbing around it: tracking which entities changed, the
status lifecycle, retries, queueing, batching, and locking for concurrency safety.

Typical uses are keeping an external search engine (Elasticsearch, Algolia) in sync
with content, pushing entity changes to an external API or CRM, building a change
audit trail, warming caches, or feeding analytics — anything that fits the pattern
"when content changes, do X." Because it's core-only (no contrib dependencies), it's
a lightweight way to standardise that pattern.

A consumer is a small PHP class marked with the `#[EntityRegistryConsumer]` attribute
that implements two methods — `processItem()` (do the work) and `deleteItem()` (clean
up when an entity is deleted). Processing runs in three phases: **save**
(synchronously during the entity save), **cron** (asynchronously via a queue worker),
and **batch** (an admin bulk operation or a Drush command). An admin dashboard shows
live pending / processed / failed counts per consumer, and every operation is also
available as a Drush command for automation.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead — in particular
[`plugins/consumer.md`](../agent/plugins/consumer.md) for the full consumer contract.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the admin dashboard, global settings,
   the permission, and the Drush commands.

## Where it lives in the admin menu

The dashboard is at **Configuration → System → Entity Registry**
(`/admin/config/system/entity-registry`), gated by the restricted *administer entity
registry* permission.

## How to use it

Entity Registry only does something once you (or another module) provide a consumer
plugin. A consumer lives in your module under
`src/Plugin/EntityRegistryConsumer/`:

```php
namespace Drupal\my_module\Plugin\EntityRegistryConsumer;

use Drupal\entity_registry\Attribute\EntityRegistryConsumer;
use Drupal\entity_registry\Plugin\EntityRegistryConsumerBase;
use Drupal\Core\StringTranslation\TranslatableMarkup;

#[EntityRegistryConsumer(
  id: 'my_consumer',
  label: new TranslatableMarkup('My Consumer'),
)]
final class MyConsumer extends EntityRegistryConsumerBase {

  public function processItem(string $entity_type, int $entity_id, string $langcode, string $phase): ?bool {
    // Your index/sync logic.
    // Return TRUE = done, FALSE = failed (will retry), NULL = defer to cron.
    return TRUE;
  }

  public function deleteItem(string $entity_type, int $entity_id, string $langcode): bool {
    // Clean up stored data for this entity translation.
    return TRUE;
  }
}
```

After adding a plugin, run `drush cr`; it then appears on the dashboard automatically.
You can restrict which entity types/bundles it tracks (via the admin form or the
`getTrackedEntityTypes()` method), filter individual items at runtime with
`shouldProcessItem()`, and report progress with `getStoredItemCount()` /
`getTotalItems()`. See the agent
[`plugins/consumer.md`](../agent/plugins/consumer.md) reference for the complete method
list. Day-to-day operations — process, queue (full reindex), retry failed, clear,
rebuild — are done from the dashboard or with Drush, covered in
[Configuration](configuration/index.md).
