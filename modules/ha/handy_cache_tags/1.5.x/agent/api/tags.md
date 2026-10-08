# Handy Cache Tags — tag format & API

## The two tags (prefix `handy_cache_tags:`)

| Tag | Meaning |
|---|---|
| `handy_cache_tags:<entity_type>` | Any entity of that type changed. E.g. `handy_cache_tags:node` (parallels core `node_list`). |
| `handy_cache_tags:<entity_type>:<bundle>` | Any entity of that type **and bundle** changed. E.g. `handy_cache_tags:node:article`. Core has no equivalent. |

## Building tags — `handy_cache_tags.manager`

Service id `handy_cache_tags.manager` → `HandyCacheTagsManager` (const `CACHE_PREFIX = 'handy_cache_tags'`).

```php
$m = \Drupal::service('handy_cache_tags.manager');
$m->getTag('node');                       // 'handy_cache_tags:node'
$m->getBundleTag('node', 'article');      // 'handy_cache_tags:node:article'
$m->getEntityTags($entity);               // [type tag, bundle tag] for $entity
$m->getEntityTypeTagFromEntity($entity);  // 'handy_cache_tags:<type>'
$m->getBundleTagFromEntity($entity);      // 'handy_cache_tags:<type>:<bundle>'
```

## Attaching tags to a render array

The module invalidates; you attach. Example:

```php
$build['#cache']['tags'][] = \Drupal::service('handy_cache_tags.manager')
  ->getBundleTag('node', 'article');           // clears when any Article changes
$build['#cache']['tags'][] = \Drupal::service('handy_cache_tags.manager')
  ->getTag('node');                            // clears when any node changes
```

## Automatic invalidation — `handy_cache_tags.handler`

`hook_entity_insert()`, `hook_entity_update()`, and `hook_entity_delete()` call
`HandyCacheTagsHandler::invalidateEntity($entity)`, which runs
`Cache::invalidateTags($manager->getEntityTags($entity))` — i.e. it invalidates both the entity-type
tag and the bundle tag for every created/updated/deleted entity. Additionally, `invalidateEntity()`
handles config changes:

- **`ConfigEntityBundleBase`** (a bundle config entity, e.g. a node type) → also invalidates the
  bundle tag and entity-type tag for the entities it defines.
- **`FieldStorageConfig`** → invalidates the target entity type's tag.
- **`FieldConfig`** → invalidates the bundle tag and entity-type tag for the field's bundle.

So bundle and field edits also clear the relevant handy tags, not just content saves.

## Deprecated procedural helpers

`handy_cache_tags_get_tag()`, `handy_cache_tags_get_entity_tags()`,
`handy_cache_tags_get_entity_type_tag_from_entity()`, `handy_cache_tags_get_bundle_tag_from_entity()`,
`handy_cache_tags_get_bundle_tag()` — all deprecated (removed in 2.0.0). Use the equivalent
`handy_cache_tags.manager` methods instead.
