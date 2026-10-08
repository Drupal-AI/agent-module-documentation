<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# EntityReference Separate Selection and Validation (ersv) — agent index

A single EntityReference **selection plugin** (id `ersv`) that decouples the two jobs a
normal selection handler does: **building the selectable options** and **validating a
submitted reference**. On a reference field you configure a separate *selection* handler and
*validation* handler, so the set of options a user sees can legitimately differ from the set a
value is validated against.

- **Version:** 8.x-1.x (8.x-1.3). **Core:** `^8.7.7 || ^9 || ^10 || ^11`. **License:** GPL-2.0-or-later.
- **Requires:** `ajax_dependency` (`drupal/ajax_dependency:^2.0`) — hard dependency, used to
  make the nested handler-settings subforms rebuild when the handler `select` changes.
- **Provides:** one plugin. No routes, permissions, services, hooks, Drush, config schema or
  install config.

## The one plugin → [plugins/selection.md](plugins/selection.md)

- `Drupal\ersv\Plugin\EntityReferenceSelection\SeparateSelectionAndValidation`
  (`@EntityReferenceSelection` id `ersv`, group `ersv`, label *"Separate selection and
  validation"*), extends core `SelectionPluginBase`, implements
  `ContainerFactoryPluginInterface` and `SelectionWithAutocreateInterface`.
- Holds two child selection plugins — `$selectionPlugin` and `$validationPlugin` — each an
  ordinary core selection handler (default, views, etc.) instantiated from the field config.
- **Selection side** drives `getReferenceableEntities()` / `countReferenceableEntities()`.
- **Validation side** drives `validateReferenceableEntities()`, `entityQueryAlter()`,
  `createNewEntity()` and `validateReferenceableNewEntities()` (autocreate).

## Configure

Set **Reference method = "Separate selection and validation"** on an entity reference field's
storage/field settings, then choose a Handler under both the *Selection* and *Validation*
fieldsets and configure each handler's own settings. See
[plugins/selection.md](plugins/selection.md) for the config array shape and validation flow.
