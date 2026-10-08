<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Published-entity tags & invalidation (`CacheInvalidator`)

`Drupal\cache_tools\Service\CacheInvalidator` (service `cache_tools.cache.invalidator`) builds the precise
`*_pub` cache tags and invalidates them. It is driven by the `invalidate` section of the `cache_tools`
parameter (see [../config/settings.md](../config/settings.md)) and wired to entity lifecycle hooks in
`cache_tools.module`. Constructor args: `@cache_tags.invalidator`, `%cache_tools%`. Uses
`EntityTypeManagerTrait` from `drunomics/service-utils`.

## Tag builders

- `getPublishedEntityTypeCacheTag(EntityTypeInterface)` → `"{entity_type}_pub"` (e.g. `node_pub`).
- `getPublishedEntityCacheTag(EntityInterface)` → `"{entity_type}_{bundle}_pub"` (e.g. `node_article_pub`).
- `getPublishedEntityFieldsCacheTags(FieldableEntityInterface $entity, ?$entity_compare = NULL)` →
  array of `"{entity_type}_{bundle}_pub:{field}:{value}"`. When `$entity_compare` is passed, only fields
  whose value **differs** from the compare entity are emitted (`===` value comparison); for each such field
  it emits tags for both the compare (original) values and the new values. `value` is read from the field's
  main property (`getMainPropertyName()`); fields with no main property are skipped.
- `generateTagsBasedOnInvalidationStrategy($target_type, $entity_id, $tag_prefix_field, $invalidate_term_parents=FALSE)`
  → normally `[prefix.$entity_id]`; for `taxonomy_term` targets with the `parents` rule it emits one tag per
  ancestor tid from `taxonomyGetParents()`.

## Entity-type / bundle invalidation — `invalidatePublishedEntity($entity)`

Returns FALSE (no-op) unless `invalidate[<entity_type>]` exists and the bundle is in that list. Otherwise
builds `[{type}_pub, {type}_{bundle}_pub]`, then invalidates **only if** the entity (or its `->original`
on update) has a truthy `status` — i.e. it fires when something is/goes published. Called from
`hook_entity_insert` and `hook_entity_update`.

## Field-value invalidation — `invalidatePublishedEntityFields($entity)`

Returns FALSE unless the entity is `FieldableEntityInterface` and `invalidate[<entity_type>]` is iterable.
Determines `$is_published` (via `EntityPublishedInterface::isPublished()`, defaulting TRUE if the entity
doesn't implement it) and `$was_published` (from `$entity->original`, else FALSE). Then:

| transition | tags emitted |
|---|---|
| published → published (update) | changed fields only: `getPublishedEntityFieldsCacheTags($entity, $entity->original)` |
| was published → now unpublished | original non-empty values: `getPublishedEntityFieldsCacheTags($entity->original)` |
| now published (insert / delete-of-published / update-and-publish) | all non-empty current values: `getPublishedEntityFieldsCacheTags($entity)` |

Called from `hook_entity_insert`, `hook_entity_update`, and `hook_entity_delete` (delete only calls the
field variant; on delete a published entity's current field values are used).

## Using it from custom code

```php
$inv = \Drupal::service('cache_tools.cache.invalidator');
$tag = $inv->getPublishedEntityCacheTag($node);          // "node_article_pub"
$build['#cache']['tags'][] = $tag;                        // attach to your render array
// Manual field-tag invalidation for a config not covered by hooks:
$inv->invalidatePublishedEntityFields($node);
```

## Gotchas (from source)

- `invalidatePublishedEntity()` reads `$entity->original` unconditionally; on insert that property is unset
  (accessing an undefined dynamic property yields NULL under the `if`, which is fine, but note it relies on
  core setting `->original` on updates).
- The published check uses `$entity->get('status')->value`; entity types without a `status` field would
  break here, so only add `status`-bearing (publishable) types/bundles to `invalidate`.
- Field comparison is a strict `===` on `getValue()` arrays; property-order or type changes count as a diff.
