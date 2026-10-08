<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Warmer services & programmatic warming

Two services (`warmer.services.yml`):

| Service ID | Class | Role |
|---|---|---|
| `plugin.manager.warmer` | `Drupal\warmer\Plugin\WarmerPluginManager` | Discovers and instantiates warmer plugins. |
| `warmer.queue_manager` | `Drupal\warmer\QueueManager` | Pushes warming batches onto the `warmer` queue. |

## Plugin manager

```php
$manager = \Drupal::service('plugin.manager.warmer');

// All warmer instances (WarmerPluginBase[]), or a subset by id:
$warmers = $manager->getWarmers();               // every warmer
$warmers = $manager->getWarmers(['entity']);     // only the entity warmer

// Raw plugin definitions (id => definition array):
$defs = $manager->getDefinitions();
```

Each instance's config (`frequency`, `batchSize`, plugin-specific keys) is hydrated from
`warmer.settings` in `WarmerPluginBase::create()`. Useful accessors on an instance:
`getFrequency()`, `getBatchSize()`, `getConfiguration()`, `isActive()`, `buildIdsBatch()`,
`loadMultiple()`, `warmMultiple()`.

## Enqueue from code

Mirror what `WarmerCommands::enqueue()` does:

```php
use Drupal\warmer\HookImplementations;

$manager = \Drupal::service('plugin.manager.warmer');
$queue   = \Drupal::service('warmer.queue_manager');

foreach ($manager->getWarmers(['entity']) as $warmer) {
  $ids = [NULL];
  while ($ids = $warmer->buildIdsBatch(end($ids))) {
    // Stores a queue item AND marks the warmer as enqueued (updates its state timestamp).
    $queue->enqueueBatch(HookImplementations::class . '::warmBatch', $ids, $warmer);
  }
}
// Then drain: drush queue:run warmer  (or \Drupal::service('queue')->get('warmer')).
```

`QueueManager::QUEUE_NAME` is `warmer`. The queue worker plugin `ItemWarmer`
(`src/Plugin/QueueWorker/ItemWarmer.php`) processes each `QueueData` item by calling the
warmer's `loadMultiple()` then `warmMultiple()`. Cron entry point is
`HookImplementations::enqueueWarmers()` (called from `warmer_cron()`), which enqueues only
warmers whose `isActive()` is true.
