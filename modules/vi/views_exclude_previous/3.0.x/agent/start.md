<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views exclude previous — agent index

Excludes entities already rendered on the current page from a view. Tracks rendered entities per request and
provides a Views argument-default plugin to subtract them. No admin UI (`configure` null), no permissions,
no Drush, no config schema. 3.x is a rewrite with no upgrade path from 2.x.

- **Wiring the contextual filter up in a view (incl. the must-tick "Exclude" step)** →
  [configure/views.md](configure/views.md)
- **The render-history service and trait for custom code** → [api/service.md](api/service.md)

Key facts:
- Service `views_exclude_previous.render_history` (`EntityRenderHistory`): `add($entity)` /
  `getRenderedEntities($entityTypeId)` — in-memory, keyed by entity type id.
- Tracking hook: `hook_entity_build_defaults_alter()` (fires even for render-cached entities).
- Views argument default plugin id `views_exclude_default_render_history` ("Previously rendered entities");
  `getArgument()` returns `id1+id2+...` or `all` (no-op) when none.
