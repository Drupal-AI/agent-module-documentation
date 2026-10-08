Handy Cache Tags provides two developer-friendly cache tags per entity — `handy_cache_tags:<entity_type>` and `handy_cache_tags:<entity_type>:<bundle>` — and automatically invalidates them whenever an entity is created, updated, or deleted, so you can attach them to render arrays and get precise cache clearing.

---

The module has no UI, config, permissions, routes, or Drush commands — it is a small toolkit for developers. It registers `hook_entity_insert/update/delete` implementations that, for every entity CRUD operation, invalidate that entity's two "handy" tags via the `handy_cache_tags.handler` service (`HandyCacheTagsHandler::invalidateEntity()`). The tag strings are produced by the `handy_cache_tags.manager` service (`HandyCacheTagsManager`), which prefixes everything with `handy_cache_tags:` — `getTag($type)` → `handy_cache_tags:<type>`, `getBundleTag($entity_type, $bundle)` → `handy_cache_tags:<entity_type>:<bundle>`, plus entity-aware helpers `getEntityTags()`, `getEntityTypeTagFromEntity()`, `getBundleTagFromEntity()`. The entity-type tag (e.g. `handy_cache_tags:node`) roughly parallels core's `node_list`, but the bundle-level tag (e.g. `handy_cache_tags:node:article`) is the real value: core has no built-in "any node of bundle article changed" tag. The handler additionally invalidates useful related tags when a bundle config entity (`ConfigEntityBundleBase`), a `FieldStorageConfig`, or a `FieldConfig` changes, so bundle/field edits also clear the relevant handy tags. Older procedural helper functions (`handy_cache_tags_get_tag()` etc.) exist but are deprecated in favour of the manager service. You attach the tags yourself in a `#cache` array; the module handles the invalidation.

---

- Add a `handy_cache_tags:node:article` tag to a custom block so it re-renders only when an Article is created/updated/deleted.
- Cache a "latest articles" listing and invalidate it precisely when any Article changes, not on every node change.
- Tag a Views-adjacent custom render array with a bundle-specific cache tag core doesn't provide.
- Invalidate a menu/sidebar of "recent products" whenever a product entity of a given bundle changes.
- Use `handy_cache_tags:node` as a drop-in for a node_list-style invalidation on any entity type.
- Get a per-bundle cache tag for a custom entity type (e.g. `handy_cache_tags:my_entity:premium`).
- Attach the tag to a JSON/REST or normalizer output so API responses invalidate on the right entity changes.
- Cache an expensive computed value keyed to a taxonomy vocabulary's terms via `handy_cache_tags:taxonomy_term:tags`.
- Precisely bust a homepage component cache when content of one bundle is edited.
- Build the tag from an entity in code with `getEntityTags($entity)` when you don't know the bundle statically.
- Get just the entity-type tag from an entity via `getEntityTypeTagFromEntity($entity)`.
- Get just the bundle tag from an entity via `getBundleTagFromEntity($entity)`.
- Ensure a block that lists items of a bundle clears automatically when the bundle's fields change (field config invalidation).
- Clear caches tied to a bundle when that bundle (config entity) is renamed or deleted.
- Reduce over-invalidation by tagging with a bundle tag instead of a broad entity-type tag.
- Give front-end/decoupled caches a stable, predictable tag naming scheme (`handy_cache_tags:*`).
- Tag a computed field or twig extension output so it refreshes on relevant entity edits.
- Provide consistent cache tags across many custom modules without each reinventing the format.
- Avoid writing your own `hook_entity_*` invalidation logic for common per-bundle caching.
- Attach both the entity-type and bundle tags to a render array to cover "any of this type" and "this bundle" cases.
