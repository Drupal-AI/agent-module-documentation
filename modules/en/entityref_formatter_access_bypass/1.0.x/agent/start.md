<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Reference Formatter Access Bypass (entityref_formatter_access_bypass) — agent index

A single field formatter that extends core's rendered-entity reference formatter and, for referenced entities the current user cannot view, renders them in an administrator-chosen fallback view mode instead of omitting them.

- **Version:** 1.0.x  •  **Core:** ^10 || ^11 || ^12  •  **Package:** Fields  •  **License:** GPL-2.0-or-later
- **Dependencies:** none (no composer.json, no `dependencies:` in info.yml). No routes, permissions, services, hooks, config UI, Drush, or shipped config schema.
- **What it provides:** one FieldFormatter plugin, id `entity_reference_entity_view_access_bypass_fallback`, label "Rendered entity with access bypass fallback", for `entity_reference` fields. Adds one setting `view_mode_fallback` (default `default`) on top of the core formatter's settings.

- **The formatter — plugin id, mechanism vs. core, settings, and how to enable it** → [fields/formatter.md](fields/formatter.md)

## What it actually is (from source)

- One class: `EntityReferenceEntityViewAccessBypassFallback` in `src/Plugin/Field/FieldFormatter/EntityReferenceEntityViewAccessBypassFallback.php`, extending core `EntityReferenceEntityFormatter`.
- Difference from core: core's `EntityReferenceFormatterBase::getEntitiesToView()` adds an entity to the render list only `if ($access->isAllowed())`, so inaccessible targets are dropped. This override returns every loaded entity paired with an `access` boolean, and `viewElements()` renders each one — using `view_mode` when allowed and `view_mode_fallback` when not (`EntityReferenceEntityViewAccessBypassFallback.php:132-201`).
- The fallback view mode is what limited/anonymous users see for entities they cannot access, so it should hold only fields intended for those viewers. Per-field access is still applied by the core entity view pipeline. Recursion is capped at depth 20.
