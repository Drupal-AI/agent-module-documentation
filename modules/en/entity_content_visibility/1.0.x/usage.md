<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Content Visibility provides a field type and matching widget so other modules can attach Drupal block-style visibility conditions to their own content entities.

---

The module solves a narrow developer problem: core lets you gate *blocks* by condition plugins (request path, user role, node type, etc.) via the block visibility UI, but there is no reusable way to store and evaluate that same set of conditions against an arbitrary content entity. This module fills that gap. It ships a `entity_content_visibility` field type (a `no_ui = TRUE` extension of `StringLongItem`) plus an `entity_content_visibility` field widget that renders every context-appropriate condition plugin as vertical tabs — exactly the form the core block UI builds. Submitted condition configuration is `serialize()`d into the single long-string field value, storing only conditions whose configuration differs from their default.

The module deliberately has **no UI, no routes, no permissions, and no services** — the README states it should only be installed as a dependency of another module (for example `popup_entity`). Two helper classes do the runtime work: `EntityContentVisibilityChecker::isVisible()` `unserialize()`s the stored value, instantiates each condition through the condition plugin manager, applies runtime contexts, and returns FALSE if any condition fails (AND logic; a `ContextException` is treated as passing). `EntityContentVisibilityCache` mirrors this to expose merged cache contexts, tags, and max-age from the stored conditions so a host entity can bubble correct cacheability. Note the widget excludes the `current_theme` condition, and both helpers still call the removed `entity.manager` service and a stale `entityContent_visibility` namespace in one file — signs the module is dated (last release 2023, `^9 || ^10`).

---

- Add block-style visibility conditions to a custom content entity type
- Attach the `entity_content_visibility` field to a bundle from another module's install/config
- Render all context-aware condition plugins as a vertical-tab form on an entity form
- Store request-path visibility rules against an entity
- Store user-role visibility rules against an entity
- Store node-type / entity-bundle visibility rules against an entity
- Store language-based visibility rules against an entity
- Persist only non-default condition configuration to keep field values compact
- Evaluate whether an entity should be shown via `EntityContentVisibilityChecker::isVisible()`
- Build an AND-combined visibility gate for pop-ups, banners, or promotional entities
- Reuse core condition plugins without reimplementing the block visibility UI
- Derive cache contexts for a visibility-gated entity via `EntityContentVisibilityCache::getCacheContexts()`
- Derive cache tags for a visibility-gated entity via `getCacheTags()`
- Derive cache max-age for a visibility-gated entity via `getCacheMaxAge()`
- Bubble correct cacheability metadata when rendering a conditionally-shown entity
- Provide a dependency for modules like `popup_entity`
- Let site builders configure per-entity display conditions through a familiar tabbed form
- Exclude the `current_theme` condition from the offered options
- Extend the checker to add custom condition plugins that appear automatically in the widget
- Gate an entity's visibility by current user's role and current page path simultaneously
- Treat missing runtime context gracefully (condition passes on `ContextException`)
