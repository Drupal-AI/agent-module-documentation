<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API: creating, loading and reading meta entities

## Create + link a meta entity

A `meta_entity` is a content entity whose required `target` field (dynamic_entity_reference,
cardinality 1) points at one host. Set `type` (the meta entity type/bundle id) and `target`.

```php
use Drupal\meta_entity\Entity\MetaEntity;

$visits = MetaEntity::create([
  'type' => 'visits',
  'target' => $node,      // any ContentEntityInterface
  'field_count' => 10,    // a field you added to the 'visits' type
]);
$visits->save();
```

The `target` field carries two constraints (see `MetaEntity::baseFieldDefinitions()`):
- `UniquePerMetaTypeAndTarget` — a host may have at most one meta entity of a given type.
- `MappedTargetEntity` — the host's entity-type/bundle must appear in the type's `mapping`.

You can create host + metadata in one save via the reverse field (see below):

```php
Node::create([
  'type' => 'article',
  'title' => 'News',
  'visits' => MetaEntity::create(['type' => 'visits', 'field_count' => 10]),
])->save();
```

## Load-or-create helper

```php
// Returns the existing meta entity of this bundle for $target, or a new (unsaved) one.
$meta = MetaEntity::loadOrCreate('visits', $target_entity);
$meta->field_count->value++;
$meta->save();
```

`MetaEntity::getTargetEntity(): ?ContentEntityInterface` returns the host.

## Read metadata back from a host

### Reverse-reference computed field
If the type's mapping set a `field_name` for the host bundle, the host exposes a computed
`entity_reference` field with that name (class `MetaEntityReverseReferenceItemList`):

```php
$count = $node->visits->entity->field_count->value; // 'visits' == configured field_name
```

### Repository service
One repository service exists per meta entity type, tagged `meta_entity.repository`. The container
parameter `meta_entity.repositories` maps meta-entity-type-id → service id. The base module's own
service is `meta_entity.repository` (meta type `meta_entity`). Resolve and call:

```php
$service_id = \Drupal::getContainer()->getParameter('meta_entity.repositories')['meta_entity'];
/** @var \Drupal\meta_entity\MetaEntityRepositoryInterface $repo */
$repo = \Drupal::service($service_id);

$repo->getMetaEntityForEntity($node, 'visits');   // ?MetaEntityInterface
$repo->getMetaEntitiesForEntity($node);           // MetaEntityInterface[] (all types on host)
$repo->getMetaEntityTypesForBundle('node', 'article'); // type ids allowed for this bundle
$repo->getReverseReferenceFieldNames('node', 'article'); // [type_id => field_name]
$repo->getTypesWithAutoCreation($node);           // type ids auto-created for this host
```

Results are cached in a per-service chained (memory + persistent) cache backend, keyed e.g.
`meta:{entity_type}:{id}`, and invalidated via the meta entity / host cache tags. Internal repository
queries use `accessCheck(FALSE)` (they compute the full metadata set for cache and cascade logic);
rendering and route access still go through the entity access handler (see permissions doc).

## Interface surface

- `MetaEntityInterface`: `getCreatedTime()`, `setCreatedTime($ts)`, `getTargetEntity()`,
  static `loadOrCreate($bundle, $target)`.
- `MetaEntityRepositoryInterface`: the five getters above (plus setter injection used by the
  service provider).
