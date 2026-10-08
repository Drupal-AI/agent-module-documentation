<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CachedNormalizer, placeholders & the entity-UUID param converter

## `api_toolkit.cached_normalizer` (`Normalizer\CachedNormalizer`)

A drop-in replacement for the core `serializer` service that caches normalization results and
auto-invalidates them by cache tags — think "Dynamic Page Cache for individual API results", useful for
search/list endpoints with many filters. It extends Symfony's `Serializer`; at compile time
`RegisterSerializationClassesCompilerPass` copies the core serializer's registered normalizers (arg 3)
and encoders (arg 4) into it, so it can normalize the same objects. It has its own cache bin service
`cache.api_toolkit_normalizer` (bin id `api_toolkit_normalizer`).

`normalize($data, $format, $context)` behavior:

- **Arrays / iterables** are normalized element-by-element, each with a cloned cacheability object, and
  the child cacheabilities are folded back into `$context['cacheability']`.
- A **cache id** is built by `createCacheId()` → `getCacheKeys()`: keys come from the object type
  (`entity`/`field_item_list`/`field_item` + type id, entity id, revision id, langcode, field name),
  plus any keys from a `CacheableMetadataWithKeys` cacheability object, the cache **contexts** (converted
  to keys and sorted), the format, and scalar context values. If no keys can be derived, it falls back to
  the parent (uncached) normalize.
- If `cacheability->getCacheMaxAge() === 0`, caching is skipped.
- On a cache hit the stored data + cacheability are returned (and placeholders replaced); on a miss the
  parent normalizes, placeholders are stored in normalized form, and the entry is written with the
  cacheability's max-age and tags.

**Contract for your normalizers**: collect cacheability into `$context['cacheability']` (a
`CacheableMetadata`) and `addCacheableDependency($object)` so entries invalidate correctly:

```php
public function normalize($object, $format = NULL, array $context = []): array {
  $context['cacheability'] ??= new CacheableMetadata();
  $context['cacheability']->addCacheableDependency($object);
  return ['uuid' => $object->uuid(), 'title' => $object->getTitle()];
}
```

## Placeholders (`Normalizer\Placeholder\Placeholder`)

Use a placeholder for highly dynamic bits (current user/time) or to cache nested normalizations
separately from the parent. Instead of the value, a callback reference is stored in cache and executed on
every read:

```php
'attendees' => new Placeholder([$this->normalizer, 'normalize'], [$object->getAttendees()]),
```

A `Placeholder` holds `callback` (`[$serviceInstance, ...args]`) and `arguments`. Before caching,
`CachedNormalizer::normalizeArguments()` serializes each argument into a `PlaceholderArgument` with a
`PlaceholderArgumentType` (`Value`, `Array`, `Entity`, `FieldItemList`, `FieldItem`) — entities/field
items are stored as `[type, id, langcode, (field, delta)]`, scalars stored verbatim. On read,
`denormalizeArguments()` reloads the entity/field item (respecting translations) and invokes the
callback. Nested placeholders keep child normalizations out of the parent's cache entry.

`Cache\CacheableMetadataWithKeys` extends `CacheableMetadata` with an explicit `getCacheKeys()`/`setCacheKeys()`
so you can force cache keys for data that isn't an entity/field item.

## Entity-UUID param converter (`ParamConverter\EntityUuidConverter`)

Service `paramconverter.api_toolkit.entity_uuid` (parent `paramconverter.entity`, tagged `paramconverter`).
It upcasts a **UUID** in a route path to the full entity, instead of an internal id. Use the param type
`entity_uuid:<entity_type>` (or `entity_uuid:{slug}` referencing another path variable):

```yaml
options:
  parameters:
    node:
      type: entity_uuid:node
```

`applies()` matches when the definition type starts with `entity_uuid:`. `convert()` calls
`entityRepository->loadEntityByUuid()` and returns `NULL` (→ 404) on storage error or when a `bundle`
restriction in the definition doesn't match — so bundle filtering works like the core entity converter.
