# `PushFrameworkSource` plugin type — feed items into the queue

A source plugin answers "what needs to be pushed, and to whom?". `push_framework.service` calls every
source's `getAllItemsForPush()` on each cron / `pf:sources:collect`, turns each returned `SourceItem`
into an Advanced Queue job, and later (on delivery) calls the source back to confirm each attempt and
the final delivery. The base module ships **no** concrete source — DANSE is the maintainers'
recommended source provider; you can also write your own.

- Discovery dir: `Plugin/PushFrameworkSource`. Manager: `push_framework.source.plugin.manager`
  (`SourcePluginManager`, extends `DefaultPluginManager`).
- Interface: `Drupal\push_framework\SourcePluginInterface`. Base: `Drupal\push_framework\SourceBase`
  (injects `entity_type.manager`; `create()`/constructor are `final`).
- Annotation: `@SourcePlugin` (`Drupal\push_framework\Annotation\SourcePlugin`) — `id`, `title`,
  `description`. Alter hook: **`hook_push_framework_source_info(&$definitions)`**.

## Interface contract

```php
// SourcePluginInterface (extends PluginInspectionInterface)
public function label(): string;
public function getAllItemsForPush(): array;              // \Drupal\push_framework\SourceItem[]
public function getObjectAsEntity(string $oid): ?ContentEntityInterface;
public function confirmAttempt(string $oid, UserInterface $user,
                     ChannelPluginInterface $channelPlugin, string $result): SourcePluginInterface;
public function confirmDelivery(string $oid, UserInterface $user): SourcePluginInterface;
```

- `getAllItemsForPush()` returns `SourceItem` objects; construct each with
  `new SourceItem($this, (string) $oid, (int) $uid)` — `$oid` identifies your object, `$uid` the
  recipient. `SourceBase` gives you `label()` and `$this->entityTypeManager`.
- `getObjectAsEntity($oid)` maps your `$oid` back to a renderable `ContentEntityInterface` (the entity
  the channel renders). Returning `NULL` makes the channel task fail for that attempt.
- `confirmAttempt()` is called after each channel `send()` with one of the channel
  `RESULT_STATUS_*` strings — record delivery state / logging here.
- `confirmDelivery()` is called once all tasks for the item are done (queue drained for that item).

## How the service uses a source

`Service::collectAllSourceItems()` (`src/Service.php`):
1. instantiates every source plugin, iterates `getAllItemsForPush()`;
2. **skips any item whose recipient has the `push_framework`/`block push` user-data flag set** (opt-out);
3. skips items already queued (`isItemQueued()` compares `oid`+`uid` against non-final
   `pf_sourceitem` jobs in the `advancedqueue` table — dedup so the same object/recipient is not
   enqueued twice);
4. enqueues `Job::create('pf_sourceitem', $item->toArray())` on the `push_framework` queue.

`SourceItem::toArray()` payload: `oid`, `uid`, `plugin id`, `initialized`, `tasks`.
`SourceItem::fromArray($sourcePluginManager, $payload)` rebuilds it (used by the queue job).

## Per-item delivery (`SourceItem::process()`)

When the `pf_sourceitem` job runs (see [../api/services.md](../api/services.md)), the item:
- on first run, builds its **task list**: one task per channel whose `applicable($user)` is TRUE
  (`{'channel plugin id', 'attempt' => 0, 'mute subsequent until completed' => TRUE,
  'skip subsequent on success' => TRUE}`), in the channel manager's configured order;
- for each task, if the channel `isActive()` and `getObjectAsEntity($oid)` yields an entity, calls
  `prepareContent()` then `send()`; the result drives retry/stop:
  - `RETRY` → task kept for a later run (job re-fails with a 300s delay);
  - `SUCCESS` with `skip subsequent on success` → remaining channels skipped (no cross-channel spam);
  - `mute subsequent until completed` mutes later tasks in the same run until the first completes;
- calls `confirmAttempt()` after each `send()`, and `confirmDelivery()` once no tasks remain.

## Minimal skeleton

```php
namespace Drupal\my_source\Plugin\PushFrameworkSource;

use Drupal\Core\Entity\ContentEntityInterface;
use Drupal\push_framework\ChannelPluginInterface;
use Drupal\push_framework\SourceBase;
use Drupal\push_framework\SourceItem;
use Drupal\push_framework\SourcePluginInterface;
use Drupal\user\UserInterface;

/**
 * @SourcePlugin(
 *   id = "my_source",
 *   title = @Translation("My source"),
 *   description = @Translation("Pushes my_entity items to their subscribers."),
 * )
 */
class MySource extends SourceBase {

  public function getAllItemsForPush(): array {
    $items = [];
    // ... find pending (object, recipient) pairs ...
    $items[] = new SourceItem($this, (string) $oid, (int) $uid);
    return $items;
  }

  public function getObjectAsEntity(string $oid): ?ContentEntityInterface {
    return $this->entityTypeManager->getStorage('node')->load($oid);
  }

  public function confirmAttempt(string $oid, UserInterface $user, ChannelPluginInterface $channelPlugin, string $result): SourcePluginInterface {
    // record $result for ($oid, $user, channel)
    return $this;
  }

  public function confirmDelivery(string $oid, UserInterface $user): SourcePluginInterface {
    // mark ($oid, $user) delivered
    return $this;
  }
}
```
