<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Using the unique queue

## The dedup contract

`UniqueDatabaseQueue::doCreateItem()` inserts into the `queue_unique` table. Duplicates are
blocked by a **unique key on a `hash` column** (`char(48)`). On an
`IntegrityConstraintViolationException` it returns `FALSE` (per `QueueInterface`: no item was
created). So:

```php
$queue = \Drupal::service('queue_unique.database')->get('your_queue_name');
$queue->createItem($data);               // 1st time: returns the item id
if ($queue->createItem($data) === FALSE) {
  // Duplicate — nothing was added. Respond appropriately.
}
```

The hash is `UniqueDatabaseQueue::hash($name, serialize($data))` =
`'sha2' . substr(base64_encode(hash('sha512', $name . $serialized_data, TRUE)), 0, 45)`.
Because the queue **name** is part of the hash, the same payload can live in two different
unique queues independently.

## Three ways to opt a queue into uniqueness

### 1. Route a specific named queue (settings.php)

```php
// The default core queue service ($settings['queue']) then hands this queue to us:
$settings['queue_service_your_queue_name'] = 'queue_unique.database';
```

Now `\Drupal::service('queue')->get('your_queue_name')` returns a unique queue.

### 2. Get the factory directly (no settings change)

```php
$queue = \Drupal::service('queue_unique.database')->get('your_queue_name');
$queue->createItem($data);
```

### 3. Replace core's QueueFactory + use the `queue_unique/` prefix

Override the core `queue` service (e.g. in a site `services.yml`):

```yaml
services:
  queue:
    class: Drupal\queue_unique\QueueFactory
    arguments: ['@settings']
    calls:
      - [setContainer, ['@service_container']]
```

Then any queue whose name starts with `queue_unique/` is auto-served by
`queue_unique.database`, with the prefix stripped for the actual queue/table name:

```php
// Stored under queue name "your_queue_name":
$queue = \Drupal::service('queue')->get('queue_unique/your_queue_name');
```

`QueueFactory::get()` still honors `$settings['queue_service_<name>']`,
`$settings['queue_reliable_service_<name>']` (when `$reliable` is TRUE), and
`$settings['queue_default']` first, falling back to the prefix rule.

## Unique cron queue worker

Name a `@QueueWorker` plugin with the prefix so core cron pulls from the unique queue:

```php
/**
 * @QueueWorker(
 *   id = "queue_unique/mymodule_entity_update",
 *   title = @Translation("Handle entity create or update."),
 *   cron = {"time" = 20}
 * )
 */
class EntityUpdateQueueWorker extends QueueWorkerBase { /* … */ }
```

Add items to `mymodule_entity_update` (via the unique queue) and cron processes them — see
`\Drupal\Core\Cron::processQueues()`.

## Inspect / process

```php
$queue->numberOfItems();                 // items currently queued (per name)
```

```bash
drush queue:run your_queue_name          # core command; no module-specific Drush
```

`queue_unique_update_8001()` (in `.install`) migrates any pre-existing `queue_unique` table
data into the current schema.
