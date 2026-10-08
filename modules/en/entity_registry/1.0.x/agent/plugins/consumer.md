# Write an EntityRegistryConsumer plugin

A consumer decides what happens when tracked entities change. Discovery is attribute-based
(PHP 8.1+), directory `src/Plugin/EntityRegistryConsumer/` in your module.

## Skeleton

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
    // Index/sync logic. TRUE=success(PROCESSED), FALSE=fail(FAILED+retry), NULL=defer(stay PENDING).
    return TRUE;
  }

  public function deleteItem(string $entity_type, int $entity_id, string $langcode): bool {
    // Clean up stored data for this entity translation.
    return TRUE;
  }
}
```

The attribute accepts **only** `id` and `label`. Run `drush cr` after adding a plugin; it then
appears on the dashboard automatically.

## Methods

Interface: `EntityRegistryConsumerInterface`; base `EntityRegistryConsumerBase` provides
`create()` (plain `new static(...)`, no injected services by default — override `create()` to
inject) and defaults for everything except `processItem()`/`deleteItem()`.

| Method | Required? | Default | Purpose |
|---|---|---|---|
| `processItem($entity_type,$entity_id,$langcode,$phase): ?bool` | yes | — | Do the work. Return contract below. |
| `deleteItem($entity_type,$entity_id,$langcode): bool` | yes | — | Remove data when an entity/translation is deleted. |
| `shouldProcessItem($entity_type,$entity_id,$bundle,$langcode): bool` | no | `TRUE` | Per-item runtime filter; authoritative. |
| `getTrackedEntityTypes(): ?array` | no | `NULL` | Coarse hint of trackable types/bundles so populate/rebuild skips irrelevant tables and pushes bundle filters into SQL. |
| `clearData(): void` | no | no-op | Delete the consumer's own persistent store (called by "Clear all consumer data"). Tracker rows are marked PENDING separately, not deleted here. |
| `getStoredItemCount(): int` | no | `0` | How many records the consumer has produced (admin detail page). |
| `getTotalItems(): int` | no | `0` | How many eligible items exist (admin detail page). |
| `getLabel(): string` | no | from definition | Human label. |

## `processItem()` return contract

- `TRUE` → tracker row marked **PROCESSED**.
- `FALSE` → row marked **FAILED**, `retry_count` incremented (retried until the cap).
- `NULL` → **deferred**; row left PENDING so the next cron/batch run retries. Use for expensive
  work on `phase='save'`.

Catch your own exceptions and return FALSE (or let them propagate if the caller handles them).

## Phases (`$phase`)

- `save` — synchronous, during the entity save request.
- `cron` — via `hook_cron` → `IndexProcessor::processConsumer()` and the
  `EntityRegistryQueueWorker`.
- `batch` — admin bulk operation or a Drush command.

## `getTrackedEntityTypes()` shape

```php
public function getTrackedEntityTypes(): ?array {
  return [
    'node' => ['bundles' => ['article', 'page']], // specific bundles
    'taxonomy_term' => ['bundles' => NULL],        // all bundles
  ];
  // NULL = no hint (scan all content entity types); [] = track nothing.
}
```

## Alter hook

`hook_entity_registry_consumer_info(&$definitions)` — alter discovered consumer definitions
(the manager calls `alterInfo('entity_registry_consumer_info')`).
