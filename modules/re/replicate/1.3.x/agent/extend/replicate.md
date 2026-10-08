# Control how entities & fields are duplicated — events

Replicate uses **events, not hooks** (the old D7 hooks are gone — see `replicate.api.php`).
Subscribe to shape a clone by entity type or field type, writing the least code needed.

## The four events

| Event name | Class | When | Carries |
|---|---|---|---|
| `replicate__entity__{entity_type_id}` | `ReplicateEntityEvent` | before field-level work | `getEntity()` = the **original** |
| `replicate__entity_field__{field_type}` | `ReplicateEntityFieldEvent` | once per field of the clone | `getFieldItemList()` = field on clone, `getEntity()` = clone |
| `replicate__alter` (`ReplicatorEvents::REPLICATE_ALTER`) | `ReplicateAlterEvent` | after all fields, before save | `getEntity()` = clone, `getOriginal()` = source |
| `replicate__after_save` (`ReplicatorEvents::AFTER_SAVE`) | `AfterSaveEvent` | after save (replicate* only) | `getEntity()` = saved clone |

The dynamic names are built with `ReplicatorEvents::replicateEntityEvent($entity_type_id)`
and `ReplicatorEvents::replicateEntityField($field_type)`.

## Example: tweak a cloned node

```php
use Drupal\replicate\Events\ReplicateAlterEvent;
use Drupal\replicate\Events\ReplicatorEvents;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;

class MyReplicateSubscriber implements EventSubscriberInterface {

  public static function getSubscribedEvents(): array {
    return [ReplicatorEvents::REPLICATE_ALTER => 'onAlter'];
  }

  public function onAlter(ReplicateAlterEvent $event): void {
    $clone = $event->getEntity();
    if ($clone->getEntityTypeId() === 'node') {
      $clone->setTitle($clone->getTitle() . ' [clone]');
      $clone->setUnpublished();
    }
  }
}
```

Register it in `mymodule.services.yml`:

```yaml
services:
  mymodule.replicate_subscriber:
    class: Drupal\mymodule\MyReplicateSubscriber
    tags:
      - { name: event_subscriber }
```

## Example: shape a specific field (this is where deep vs shallow lives)

Subscribe to a field-type event; the item list you receive is already the **copied** values
on the clone, so you mutate it in place. This is how the bundled `path` subscriber resets an
alias:

```php
public static function getSubscribedEvents(): array {
  // Only fires for fields whose type is 'path'.
  return [ReplicatorEvents::replicateEntityField('path') => 'onPathClone'];
}

public function onPathClone(ReplicateEntityFieldEvent $event): void {
  foreach ($event->getFieldItemList() as $item) {
    $item->alias = NULL;
    $item->pid = NULL;
  }
}
```

## Referenced-entity handling (deep vs shallow)

- **Shallow (default):** an `entity_reference` field's values are copied verbatim, so the
  clone shares the same target entities. Do nothing to keep this.
- **Deep:** subscribe to `replicate__entity_field__entity_reference` (or your specific
  reference field type), and for each item replace the target with a fresh clone —
  re-entering `replicate.replicator` on the target entity (recursion). The Layout Builder
  subscriber demonstrates this by deep-cloning inline `block_content` referenced from a
  duplicated layout.
- Use `replicate__entity__{entity_type_id}` when the decision depends on the whole entity,
  or `replicate__alter` for final cross-field cleanup before save.

## Custom fields & entities

To support a custom field type, subscribe to its `replicate__entity_field__{your_type}`
event. To customise a custom entity type, subscribe to `replicate__entity__{your_type}`.
Nothing needs to be declared in advance — the service dispatches these names for every type
it encounters.

See [api/replicate.md](../api/replicate.md) for the service that dispatches these events.
