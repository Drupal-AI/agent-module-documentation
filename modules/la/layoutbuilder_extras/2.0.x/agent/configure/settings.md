# Configure Layout builder extras

One settings form drives everything. Route `layoutbuilder_extras.settings_form` at
`/admin/config/content/layout-builder-extras-settings`; permission `manage layoutbuilder_extras settings`.
Config object: `layoutbuilder_extras.settings` (form class `LayoutBuilderExtrasSettingsForm`,
constant `SETTINGSNAME`). Every feature is off/neutral by default.

## Settings keys (defaults from `config/install/layoutbuilder_extras.settings.yml`)

| Key | Type | Default | Effect |
|---|---|---|---|
| `section_actions_position` | string (`left`\|`top`) | `left` | Where per-section action buttons sit. Schema constrains to the two choices. |
| `enable_redirect_on_save` | bool | `false` | After saving a Layout Builder-enabled node, redirect to its Layout Builder edit page (`layout_builder.overrides.node.view`). Added via `hook_form_node_form_alter`, only if the user has access to that route. |
| `enable_configure_ajax_save` | bool | `false` | Enable live AJAX changes on the section configure form. |
| `remove_empty_divs` | bool | `false` | In `hook_preprocess_layout`, strip region wrappers whose only content is a `#cache` array so empty `<div>`s are not printed on the rendered page (front-end only, skipped on LB routes). |
| `enable_drag_handle_icon` | bool | `false` | Attach `layoutbuilder_extras/drag_handle` CSS (adds a visible drag handle to the off-canvas sidebar). |
| `enable_admin_css` | bool | `false` | Turn on the icon-only buttons + admin restyle (`LayoutBuilderElementOverride::preRenderOverride`). Also selects `admin_section_actions_left`/`_top` per `section_actions_position`. |
| `contextual_links_only_lb` | bool | `false` | Hide contextual links everywhere except Layout Builder (see below). |
| `contextual_links_roles` | sequence of role ids | `[]` | Roles that keep seeing contextual links everywhere even when the above is on. |

Config is a standard `ConfigFormBase`; `submitForm` writes each value with `getValue(..., FALSE)`.

## The layout-swap flow (the headline feature)

Enabled structurally (no toggle needed), this lets an editor convert an existing section to a
different layout while keeping its components:

1. `RouteSubscriber::alterRoutes` repoints core `layout_builder.configure_section` to the subclass
   `LayoutBuilderExtrasConfigureSectionForm` (adds `getDelta()`/`isUpdate()` accessors).
2. The `LayoutBuilderExtrasLayout` layout class (extends `LayoutDefault`) adds a **"Change layout"**
   details element listing every available layout as an AJAX/off-canvas link to
   `layoutbuilder_extras.alter_section`.
3. `AlterSectionController::build` builds a new `Section` with the target layout id but the **old
   section's layout settings, components and third-party settings**, reorders components across the
   new layout's regions (`reorderComponents`), removes the old section and inserts the new one in the
   Layout Builder tempstore, then rebuilds the layout and re-renders the configure form.

The list of offered layouts can be filtered via `hook_layoutbuilder_extras_allowed_layouts_alter()`
(see [../hooks/alter.md](../hooks/alter.md)).

## Section-actions dialog

`layoutbuilder_extras.section_actions` (`LayoutBuilderExtrasSectionActionsController`) renders core's
`ChooseSectionController` ("Choose section") and, **if `section_library` is enabled**, Section
Library's `ChooseSectionFromLibraryController` ("From library") together in one off-canvas dialog.
The icon-only override (`enable_admin_css`) wires the `+` button to this route.

## Access of the custom routes

`layoutbuilder_extras.alter_section` and `layoutbuilder_extras.section_actions` both require
`_layout_builder_access: 'view'` with the `section_storage` resolved from the Layout Builder
tempstore — i.e. **the identical access check core Layout Builder applies to its own
choose/configure/remove-section routes.** The module does not add a laxer access path to layout
editing; anyone who can reach these routes could already edit that layout through core.

## External/optional dependency

- `drupal/section_library` is optional. When absent, only "Choose section" is shown and the
  add-section override falls back to core's link.
