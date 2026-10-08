<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Generic (entity_generic) — agent index

Developer **scaffolding / base framework** for building custom content entity types. It ships
abstract base entity classes, lifecycle traits, and drop-in **handler classes** (storage, list
builder, view builder, forms, route provider, permission provider, access handler, Views data) so a
custom module can define a full-featured content entity type with little boilerplate. Package
**Entity**. Depends on the contributed **`entity`** (Entity API) module. Core `^9 || ^10 || ^11`.
License GPL-2.0-or-later. Version-dir **3.0.x** (project ships only a dev branch; **not** covered by
security advisories; maintainers label it experimental / work-in-progress). No install/settings form,
no `*.permissions.yml`, no Drush.

Nothing here does anything on its own — a **derived** entity type must extend these classes and add
an `entity_generic` marker to its annotation. See the docs below.

- **Base entity classes, traits, base fields, and how to build a custom entity on top** →
  [api/base-classes.md](api/base-classes.md)
- **Handlers: storage/schema, list/view builders, forms, controllers, route provider, permissions,
  access, managers, config bundle entity, hooks & theming** → [api/handlers.md](api/handlers.md)
- **Action plugins (enable/approve/archive/delete flags), Views field/filter plugins, local task** →
  [api/plugins.md](api/plugins.md)

## What it provides (from source)

- **Entity base classes** (`src/Entity/`): `Basic` (extends core `ContentEntityBase`) → `Simple`
  (adds owner/label/published/revision-log) → `Generic` (adds bundle/type support). Abstract —
  a real entity subclasses one of them.
- **Lifecycle traits + interfaces** (`src/Generic/`): created, changed (core), archived, deleted,
  approved, status, label, typed, description, hidden, locked — each `Entity<X>Trait` +
  `Entity<X>Interface`.
- **Handlers** (`src/`): `GenericStorage` (+ `GenericStorageInterface`), `GenericStorageSchema`,
  `GenericListBuilder`, `GenericTypeListBuilder`, `GenericConfigListBuilder`, `GenericViewBuilder`,
  `GenericViewsData`, `GenericManager` (+interface), `GenericConfigManager` (+interface).
- **Forms** (`src/Form/`): `GenericForm`/`GenericModalForm`, `GenericDeleteForm`/
  `GenericDeleteModalForm`/`GenericDeleteMultipleForm`, `GenericToggleStatusModalForm`,
  `GenericTypeForm`/`GenericTypeDeleteForm`, `GenericConfigForm`/`GenericConfigDeleteForm`.
- **Controllers** (`src/Controller/`): `GenericController` (add-page/add-list), `GenericModalController`
  (AJAX add/edit/delete/toggle modals).
- **Routing/permissions/access**: `GenericRouteProvider` (adds modal + merge routes),
  `GenericPermissionProvider` (extends Entity API's), `GenericAccessControlHandler`,
  `GenericConfigAccessControlHandler`, `GenericTypeAccessControlHandler`.
- **Config bundle entities** (`src/Entity/`): `GenericType` (ConfigEntityBundleBase), `GenericConfig`
  (ConfigEntityBase).
- **Plugins** (`src/Plugin/`): 12 lifecycle `Action` plugins + derivers; Views field plugins
  (edit/delete/toggle-status modal links) and filter plugins (`IdAutocomplete`, `IdSelect`); a
  `LocalTaskDeriver`.
- **Hooks/theme** (`entity_generic.module`): `hook_entity_type_build` (injects delete-/merge-multiple
  handlers into `entity_generic`-marked types), `hook_entity_view_alter`, theme suggestions/registry
  alters, `entity_generic` + `entity_generic_add_list` themes. Templates in `templates/`.
- **Config schema**: `config/schema/entity_generic.schema.yml` (schema for the enable/disable action
  configuration only). No `config/install`.

## Notes

- The autoloaded code lives under `src/`. The `tmp/` directory (`GenericAccessCheck`,
  `GenericViewController`, `GenericServiceProvider`, `LockException`) is outside the PSR-4 root and is
  **not** loaded — legacy/scratch, ignore it.
- Some referenced pieces are incomplete on this branch: `hook_entity_type_build` and
  `GenericRouteProvider::getMergeMultipleFormRoute()` wire up a `GenericMergeMultipleForm` /
  `_entity_generic_merge_multiple_access` that are not present in `src/`, so the merge-multiple feature
  is not functional as shipped. Documented for accuracy; treat merge as unavailable.
