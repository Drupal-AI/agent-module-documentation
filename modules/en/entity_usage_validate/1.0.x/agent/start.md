<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Usage Validate (entity_usage_validate) — agent index

Adds a `messenger` **warning** when an already-published node is re-saved while it references
**unpublished media**, using Entity Usage's relationship data. Advisory only — it never blocks
the save. Package `Other`. Version 1.0.x (release 1.0.0-alpha5, pre-release).

- **Core:** `^8.9 || ^9 || ^10 || ^11`. **License:** GPL-2.0-or-later.
- **Dependency:** `entity_usage` (`drupal/entity_usage ^2.0`).
- **No** routes, config, schema, permissions, services, plugins, or Drush commands.

## What it actually is

- The whole module is `entity_usage_validate.module` — two hooks, no `src/`.
- `hook_module_implements_alter()` reorders this module's `entity_update` implementation to run
  **after** `entity_usage_entity_update()`.
- `hook_entity_update()` → for published **nodes** only → `entity_usage.usage::listTargets($node, $revisionId)`
  → `Media::loadMultiple()` on the `media` targets → `messenger` warning (title + ID) for each
  unpublished item.
- Fires on `hook_entity_update()` (re-save of an existing node), **not** on initial insert.

## Solution docs

- **The full hook mechanism, filters, and how to operate/verify it** →
  [mechanism/warning.md](mechanism/warning.md)
