# ECK programmatic API

ECK has no service facade — you use the standard entity APIs against its config entities.
Saving/deleting an `eck_entity_type` triggers `EntityUpdateService::applyUpdates()` (via the
type's `postSave`/`postDelete`) which installs/uninstalls the real content entity type and
its DB tables through core's entity-definition-update system.

## Create an entity type (installs tables `{id}` + `{id}_field_data`)

```php
use Drupal\eck\Entity\EckEntityType;

$type = EckEntityType::create([
  'id' => 'event',           // machine name, max 27 chars (ECK appends "_type" to bundle id)
  'label' => 'Event',
  'description' => 'Custom event entity',
  // Optional base fields — omit or FALSE to leave them out:
  'title'   => TRUE,         // adds title (becomes the label key)
  'uid'     => TRUE,         // adds author/owner
  'created' => TRUE,
  'changed' => TRUE,
  'status'  => TRUE,         // adds published flag
  'standalone_url' => TRUE,  // canonical /event/{id}
]);
$type->save();               // <-- postSave installs the content entity type + tables
```

After save, `\Drupal::entityTypeManager()->getDefinition('event')` returns a live
`ContentEntityType`, and `\Drupal::database()->schema()->tableExists('event')` is TRUE.

## Create a bundle (config name `eck.eck_type.{type}.{bundle}`)

Use the **dynamic bundle storage `{type}_type`** (not the `eck_entity_bundle` id):

```php
\Drupal::entityTypeManager()->getStorage('event_type')->create([
  'type' => 'conference',    // bundle machine name (this is the id/label key)
  'name' => 'Conference',    // human label
  'description' => 'In-person events',
])->save();
```

(Equivalently, `\Drupal\eck\Entity\EckEntityBundle::create([...])` resolves to that storage.)

## Create / load / query entities

Entities of an ECK type are ordinary content entities keyed by `type` = bundle:

```php
$storage = \Drupal::entityTypeManager()->getStorage('event');
$entity = $storage->create(['type' => 'conference', 'title' => 'DrupalCon']);
$entity->save();

$results = $storage->getQuery()->accessCheck(FALSE)
  ->condition('type', 'conference')->execute();
$entities = $storage->loadMultiple($results);
```

## Load types & bundles

```php
\Drupal\eck\Entity\EckEntityType::loadMultiple();     // all types
\Drupal\eck\Entity\EckEntityType::load('event');      // one type
// Bundles of a type (EckEntityBundle::loadMultiple aggregates across all types):
\Drupal::entityTypeManager()->getStorage('event_type')->loadMultiple();
// Convenience helpers on the type entity:
$type->hasTitleField(); $type->hasAuthorField(); $type->hasStatusField();
$type->hasCreatedField(); $type->hasChangedField(); $type->hasStandaloneUrl();
```

## Delete cleanly (drops tables + purges reference fields)

Delete bundles first, then the type. `EckEntityType::preDelete` purges entity_reference
fields that target the type; `postDelete` uninstalls the entity type and drops its tables.

```php
foreach (\Drupal::entityTypeManager()->getStorage('event_type')->loadMultiple() as $b) {
  $b->delete();
}
\Drupal\eck\Entity\EckEntityType::load('event')?->delete();
// Rebuild caches in a SEPARATE request/drush call afterwards:
//   drush cr
```

Gotcha: after deleting inside a single PHP request, do the cache rebuild (`drush cr`) in a
fresh invocation — querying the just-removed definition in the same request can throw.
