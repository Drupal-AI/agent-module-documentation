<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API — render-history service & trait

## Service `views_exclude_previous.render_history` (`EntityRenderHistory`)
In-memory registry of rendered entity ids, keyed by entity type id, for the current request only.

```php
$history = \Drupal::service('views_exclude_previous.render_history');

// Record that an entity was rendered (also done automatically by the module).
$history->add($entity);                        // EntityInterface

// Read the ids already rendered for an entity type.
$ids = $history->getRenderedEntities('node');  // ['12' => 12, '34' => 34] or []
```

The module populates this automatically via `hook_entity_build_defaults_alter()`
(`views_exclude_previous_entity_build_defaults_alter()`), which runs even when the entity is served from the
render cache — so you rarely need to call `add()` yourself unless you build entity markup outside the normal
render pipeline.

## Trait `EntityRenderHistoryTrait`
Setter-injection helper for classes that need the service:
- `setEntityRenderHistory(EntityRenderHistory $h): $this`
- `getEntityRenderHistory(): EntityRenderHistory` — lazy-loads the `views_exclude_previous.render_history`
  service if not injected.

Used by the argument-default plugin `EntityRenderHistory`
(`Plugin/views/argument_default/EntityRenderHistory`, id `views_exclude_default_render_history`), whose
`getArgument()` returns `implode('+', $ids) ?: 'all'`.

No persistence: the registry is per-request; nothing is stored in state or the database.
