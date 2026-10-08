<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Content Visibility (entity_content_visibility) — agent index

**Provides a `no_ui` field type + widget that stores Drupal block-style visibility conditions on a content entity, plus helper classes to evaluate them and expose their cacheability.**

- **Version:** 1.0.x (release 1.0.0, 2023)
- **Core requirement:** ^9 || ^10 (Drupal 10 module)
- **Package:** Visibility
- **Dependencies:** none declared (uses core condition/context subsystems)
- **UI surface:** none — no routes, no permissions.yml, no services.yml, no menu links. Install only as a dependency of another module (e.g. `popup_entity`).

**Plugins**
- Field type `entity_content_visibility` (`src/Plugin/Field/FieldType/EntityContentVisibilityItem.php`) — `no_ui` `StringLongItem`, default widget `entity_content_visibility`.
- Field widget `entity_content_visibility` (`src/Plugin/Field/FieldWidget/EntityContentVisibilityWidget.php`) — renders context-aware condition plugins as vertical tabs; serializes non-default config into the value; skips `current_theme`.

**Helper classes (used by dependent modules)**
- `EntityContentVisibilityChecker::isVisible()` — `unserialize`s stored conditions, applies runtime contexts, AND-evaluates; FALSE if any fails.
- `EntityContentVisibilityCache::getCacheContexts()/getCacheTags()/getCacheMaxAge()` — merged cacheability of the stored conditions.

**Security:** No anonymous, mutating, or web-facing endpoints — the module exposes no routes or permissions; access is entirely governed by the host entity's own edit access. Note both helpers reference the removed `entity.manager` service and `EntityContentVisibilityChecker.php` uses a stale `entityContent_visibility` namespace, so runtime use requires patching on D10.

See [api/helpers.md](api/helpers.md)
