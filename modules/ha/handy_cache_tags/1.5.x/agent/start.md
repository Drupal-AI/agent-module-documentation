# Handy Cache Tags — agent index

A developer toolkit that provides two cache tags per entity and auto-invalidates them on entity
CRUD. No UI, config, permissions, routes, or Drush. Depends on nothing beyond core.

- **The tag format, the manager/handler services, auto-invalidation, and how to attach tags** →
  [api/tags.md](api/tags.md)

Key facts:
- Tags: `handy_cache_tags:<entity_type>` and `handy_cache_tags:<entity_type>:<bundle>`
  (e.g. `handy_cache_tags:node`, `handy_cache_tags:node:article`).
- Build them with the `handy_cache_tags.manager` service: `getTag($type)`,
  `getBundleTag($entity_type, $bundle)`, `getEntityTags($entity)`.
- `hook_entity_insert/update/delete` auto-invalidate an entity's two tags via
  `handy_cache_tags.handler`. You attach the tags in `#cache['tags']`; the module invalidates them.
- Procedural helpers (`handy_cache_tags_get_tag()` etc.) are **deprecated** — use the manager.
