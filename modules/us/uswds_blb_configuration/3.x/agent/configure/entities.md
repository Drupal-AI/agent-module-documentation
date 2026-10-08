<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Config entities: breakpoints, layouts, layout options

The module ships three config entity types (all `ConfigEntityBase`,
`admin_permission = "administer site configuration"`, `route_provider = AdminHtmlRouteProvider`).
They define the responsive grid that the derived Layout Builder layouts use. Nine breakpoints, 12
layouts (`blb_col_1`…`blb_col_12`), and many layout options ship as default config in
`config/install/`.

## `uswds_breakpoint` (`Entity/Breakpoint.php`, config prefix `breakpoint`)

A named CSS breakpoint with a `base_class` (e.g. `grid-col`). `config_export`: `id`, `label`,
`base_class`, `status`, `weight`, `uuid`.
- Routes (entity links): `entity.uswds_breakpoint.collection`
  (`/admin/config/uswds-layout-builder/breakpoints`), `…add_form` (`/…/breakpoints/add`),
  `…edit_form`, `…delete_form`. Forms: `Form\BreakpointForm`, `Form\BreakpointDeleteForm`;
  list builder `BreakpointListBuilder`.
- Key methods: `getBaseClass()`, `getLayoutOptions($layout_id)`,
  `getClassByPosition($key, $structure_id)` — builds `<base_class>-<n>` grid classes from a
  structure id like `blb_col_2_25_75`.

## `uswds_layout` (`Entity/Layout.php`, config prefix `layout`)

A layout definition keyed by column count. `config_export`: `id`, `label`, `number_of_columns`,
`uuid`.
- Routes: `entity.uswds_layout.collection` (`/admin/config/uswds-layout-builder/layouts`),
  `entity.uswds_layout.edit_form` (`/…/layouts/{uswds_layout}`), and the custom
  `entity.uswds_layout.options_form` (`/…/layouts/{uswds_layout}/options`, defined in
  `uswds_blb_configuration.routing.yml`, `_entity_form: uswds_layout.options`, permission
  `configure uswds layout builder`). Forms: `Form\LayoutForm` (edit), `Form\LayoutOptionsForm`
  (options); list builder `LayoutListBuilder`.
- Key methods: `getNumberOfColumns()`, `setNumberOfColumns()`, `getLayoutOptions()`.

## `uswds_layout_option` (`Entity/LayoutOption.php`, config prefix `layout_option`)

A concrete column split (structure) for a layout, e.g. `25_75`, `two_equal_columns`.
`config_export`: `id`, `uuid`, `layout_id`, `label`, `structure`, `default_breakpoints`,
`breakpoints`, `weight`.
- Routes: `entity.uswds_layout_option.add_form`
  (`/…/layouts/{uswds_layout}/options/add`), `…edit_form`, `…delete_form`. Forms:
  `Form\LayoutOptionForm`, `Form\LayoutOptionDeleteForm`.
- Key methods: `getStructure()`/`setStructure()`, `getStructureId()` (returns
  `blb_col_<structure>`), `getBreakpointsIds()`, `getDefaultBreakpointsIds()`, `getLayout()`.
  `postSave()` keeps `default_breakpoints` mutually exclusive across a layout's options.

## Where they feed the grid

`Plugin/Deriver/UswdsLayoutDeriver::getDerivativeDefinitions()` loads every `uswds_layout` entity and
emits one Layout Builder layout derivative per entity (plugin id `uswds_blb_configuration:<layout_id>`,
category `USWDS`, `theme_hook = uswds_section`, regions `uswds_region_col_1..N`). So creating a
`uswds_layout` config entity creates a selectable Layout Builder layout after a cache rebuild.
