# Observer API: EntitySubject + ObserverInterface

The whole public API is two classes plus the driver hook you write yourself. There is no
service to inject for the subject — you `new` an `EntitySubject`, attach one or more observers,
and call `notify()`. The comparator plugin manager is the only container service involved, and
`EntitySubject` fetches it internally.

## Flow (what you write)

Implement `hook_entity_presave()` (presave, so `$entity->original` still holds the pre-save
values), build a subject, attach an observer, notify:

```php
use Drupal\changed_fields\EntitySubject;
use Drupal\Core\Entity\ContentEntityInterface;
use Drupal\Core\Entity\EntityInterface;

function MYMODULE_entity_presave(EntityInterface $entity) {
  if ($entity instanceof ContentEntityInterface) {
    $subject = new EntitySubject($entity);          // uses 'default_field_comparator'
    $subject->attach(new MyObserver());             // any ObserverInterface
    $subject->notify();                             // fires MyObserver::update() per changed set
  }
}
```

## `Drupal\changed_fields\EntitySubject` (`implements \SplSubject`)

| Member | Signature | Behavior |
|---|---|---|
| constructor | `__construct(ContentEntityInterface $entity, string $field_comparator_plugin_id = 'default_field_comparator')` | Pass a comparator plugin id as 2nd arg to swap comparison logic. Instantiates the plugin via `plugin.manager.changed_fields.field_comparator`. |
| `attach(\SplObserver $observer): void` | — | Throws `\InvalidArgumentException` unless `$observer instanceof ObserverInterface`. Stored by `spl_object_hash()`. |
| `detach(\SplObserver $observer): void` | — | Same type guard; removes the observer. |
| `notify(): void` | — | The engine (see below). Returns immediately if `$entity->isNew()`. |
| `getEntity()` | `: ContentEntityInterface` | The entity under inspection — call inside `update()`. |
| `getChangedFields()` | `: array` | The changed-field diff for the current notification — call inside `update()`. |

### What `notify()` does
For each attached observer it reads `$observer->getInfo()` and, only when the current entity's
type **and** bundle match an entry, compares each listed field via the comparator's
`compareFieldValues($field_definition, $old_value, $new_value)` (old = `$entity->original`, new =
`$entity`). Fields the comparator reports as changed are collected into `$this->changedFields`
keyed by field name; if that set is non-empty, `$observer->update($this)` is called. So `update()`
fires once per observer that had at least one matching changed field, and never for a new entity.

## `Drupal\changed_fields\ObserverInterface` (`extends \SplObserver`)

Implement two methods:

- `getInfo(): array` — declares what to watch, nested `entity_type => [ bundle => [field_name, ...] ]`.
  Only these type/bundle/field combinations are compared. Example (from `BasicUsageObserver`):

  ```php
  public function getInfo() {
    return [
      'node' => ['article' => ['title', 'body']],
      'user' => ['user' => ['name', 'mail']],
      'taxonomy_term' => ['tags' => ['name', 'description']],
      // ... any content entity type/bundle/field
    ];
  }
  ```

- `update(\SplSubject $entity_subject): void` — your reaction. Pull the entity and the diff:

  ```php
  public function update(\SplSubject $entity_subject): void {
    $entity = $entity_subject->getEntity();
    $changed = $entity_subject->getChangedFields();
    // React based on which fields are present in $changed.
  }
  ```

## The changed-fields DTO shape

`getChangedFields()` returns a map keyed by the field names that changed. Each entry is what the
`DefaultFieldComparator` produced — an associative array of the raw multi-value field arrays:

```php
[
  'field_price' => [
    'old_value' => [ ['value' => '10.00'] ],   // $entity->original->get('field_price')->getValue()
    'new_value' => [ ['value' => '12.50'] ],    // $entity->get('field_price')->getValue()
  ],
  // ...only fields that actually changed appear as keys...
]
```

A field that did not change is simply absent from the array (the comparator returns `TRUE`, which
`notify()` skips). Check membership with `isset($changed['field_name'])` before reacting.

## Notes
- Content entities only — the guard is `instanceof ContentEntityInterface`; new entities are skipped.
- You can `attach()` several observers to one subject, or use one observer to watch many types.
- To change *how* a field type is compared (custom fields, extra properties), supply a different
  comparator plugin id to the constructor — see [../plugins/field-comparator.md](../plugins/field-comparator.md).
