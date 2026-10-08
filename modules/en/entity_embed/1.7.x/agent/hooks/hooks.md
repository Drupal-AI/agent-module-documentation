# Hooks (entity_embed.api.php)

All are alter hooks — no info hooks. Implement in `my_module.module`.

- `hook_entity_embed_display_plugins_alter(array &$info)` — add/remove/modify
  EntityEmbedDisplay plugin definitions globally.
- `hook_entity_embed_display_plugins_for_context_alter(array &$definitions, array $contexts)`
  — narrow which display plugins are offered for a specific embed; `$contexts['entity']` is
  the entity being embedded (e.g. force images to the image formatter).
- `hook_entity_embed_context_alter(array &$context, EntityInterface $entity)` — change the
  embed context (overrides, display, attributes) before rendering.
- `hook_ENTITY_TYPE_embed_context_alter(array &$context, EntityInterface $entity)` — same,
  per entity type.
- `hook_entity_embed_alter(array &$build, EntityInterface $entity, array &$context)` — alter
  the final render array of an embedded entity (e.g. strip `#contextual_links`).
- `hook_ENTITY_TYPE_embed_alter(array &$build, EntityInterface $entity, array &$context)` —
  same, per entity type.
