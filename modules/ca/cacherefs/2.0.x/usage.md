<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
CacheRefs keeps referenced content fresh by invalidating the cache tags of nodes that a saved node points to via entity reference fields. When a node is inserted, updated, or deleted, it collects the `field_*` entity-reference targets and invalidates their `node:<id>` cache tags, so pages displaying the referenced node re-render.

Use it when a node's display depends on nodes that reference it (or that it references) and Drupal's default cache tags don't cover the relationship you care about.
---
Enable with `drush en cacherefs`. There is no configuration — per its help text, "Install the module and it does the rest." It has no routes, permissions, or admin form.

Implementation is entirely in `cacherefs.module`: `hook_ENTITY_TYPE_insert/update/delete` for nodes call `cacherefs_clear()`, which reads the bundle's entity-reference fields (those whose machine name starts with `field_`) and calls `cache_tags.invalidator` on the referenced `node:<target_id>` tags.
---
- Refresh pages showing a referenced node after edits.
- Invalidate `node:<id>` cache tags automatically.
- Keep entity-reference displays from going stale.
- Clear caches for referenced nodes on save.
- Handle insert, update, and delete of nodes.
- Avoid manual cache clears after content updates.
- Cover reference relationships core tags may miss.
- Work with zero configuration.
- Target only `field_`-prefixed entity-reference fields.
- Improve correctness of cached reference lists.
- Reduce stale-content bug reports.
- Complement Drupal's cache tag system.
- Support content editors without dev intervention.
- Trigger invalidation via entity hooks.
- Keep aggregated/landing pages current.
- Install-and-forget cache correctness for references.