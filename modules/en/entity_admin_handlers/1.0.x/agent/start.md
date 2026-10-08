<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Admin Handlers (entity_admin_handlers) — agent index

Reusable **entity-type handler classes** (route providers + links providers + controllers) that give a
custom entity type a **Field UI admin interface** without hand-written boilerplate. You reference a set
from the entity type's annotation/attribute; the handlers generate the `field_ui_base` route (and a
bundle list, for multi-bundle types) that Field UI attaches its Manage fields/form/display tabs to.

- Depends on core **`field_ui`**. License GPL-2.0-or-later. Version dir 1.0.x (installed 1.0.0-beta8).
- Core `^8 || ^9 || ^10 || ^11`. **No** config, schema, permissions, services, plugins, hooks, or Drush.
- No `*.routing.yml` — routes are produced at runtime by the route-provider handler classes.
- Full menu/task/action links need the core patch at drupal.org issue **2976861**; routes work without it.

## What it actually is (from source)

Two handler sets under `src/`, each mirroring core's `AdminHtmlRouteProvider` /
`DefaultContentEntityLinksProvider`:

- **SingleBundleEntity** — bundleless entity types (like core `user`). Adds one route
  `entity.ENTITY_TYPE.field_ui_base` rendering a dummy settings page for Field UI to hang tabs on.
- **PlainBundleEntity** — multi-bundle types whose bundles come from code (hook_entity_bundle_info() or
  Entity API bundle plugins), not a config bundle entity. Adds an `.admin` bundle-list route plus a
  per-bundle `.field_ui_base` route (`…/{bundle}`).

Every generated route requires the entity type's own **admin permission**; the route providers throw
`UnsupportedEntityTypeDefinitionException` unless the entity type defines `field-ui-base` link template,
an `admin_permission`, and `field_ui_base_route` = `entity.ENTITY_TYPE.field_ui_base`.

## Solution docs

- **How to opt an entity type in; the two handler sets, routes, controllers, links** →
  [api/handlers.md](api/handlers.md)
