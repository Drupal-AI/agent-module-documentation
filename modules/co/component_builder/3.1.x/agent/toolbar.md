<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Component Builder Toolbar submodule

`component_builder_toolbar` (`modules/toolbar/`) — **experimental** (`lifecycle: experimental`), depends on
`component_builder`. Adds the in-context drag-and-drop builder UI attached to the canonical page of any entity
that has a `component_wrapper` reference field.

## Routes

Static (`component_builder_toolbar.routing.yml`):
- `component_builder_toolbar.tmp_page` — `/admin/cbtoolbar/tmp`, perm `administer site configuration`
  (a near-empty debug controller).

Dynamic (`ToolbarRoutes::routes`, via `route_callbacks`): for **every host entity type** that has a field
referencing `component_wrapper` (discovered by `component_builder.helper::getFieldsReferencedComponent`), it
registers, on that entity's canonical path + `/component-builder-toolbar[...]`:

- `.component_builder_toolbar` — render the builder page (`ToolBarController::page`).
- `.component_builder_toolbar_add_component` — `ToolBarController::addNewComponent` (entity form
  `toolbar-form`).
- `.component_builder_toolbar_edit_component` — `ToolBarController::editComponent`.
- `.component_builder_toolbar_move_component` — `ToolBarController::moveWrapper` (AJAX; reorders/moves a
  wrapper between deltas/regions).
- `.component_builder_toolbar_delete_component_field` — `ComponentWrapperDeleteItem` form.
- `.component_builder_toolbar_edit_properties` — `ComponentWrapperPropertiesForm`.

## Access

The page/add/edit/move/delete routes require **`_entity_access: {host_entity_type}.update`** — i.e. the user
must have update access to the host entity being edited. The **properties** route requires
`administer site configuration`. (`ToolBarController::checkMoveWrapperAccess()` returns
`AccessResult::allowed()` but is not wired to any route.)

## Forms / manager

- `ToolbarComponentWrapperForm` (`toolbar-form`) — inline add/edit of a `component_wrapper` from within the
  host page; saves the new/edited wrapper back onto the host field.
- `ComponentWrapperPropertiesForm` — reads the component's shipped `component_<id>.yml` `properties:` section
  (`file_get_contents` of the plugin's define path, module-shipped) and renders select widgets; saves the
  chosen options as the wrapper's `field_properties` JSON.
- `ComponentWrapperDeleteItem` — removes one wrapper item at a delta.
- `ToolbarManager` (service `component_builder_toolbar.manager`) — `accessToolbar()`, builds the toolbar
  markup, `moveWrapper()`. `hook_entity_view_alter` injects the toolbar when the user can edit.
