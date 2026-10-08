# panels_ipe — enable & use

No settings form (`configure: null`). Enable the module (`drush en panels_ipe -y`); it
requires `panels`, `block_content` and `jquery_ui_droppable`. It needs a Panels display
backed by a `PanelsStorage` plugin (typically a Page Manager `panels_variant`), because the
editor persists changes through that storage.

## How it renders

Panels IPE provides `InPlaceEditorDisplayBuilder` (DisplayBuilder plugin id `ipe`). When a
display uses this builder it renders the normal output plus the IPE JavaScript app
(`panels_ipe` library: Backbone models/views under `js/`, jQuery UI draggable/droppable).
The app talks to AJAX endpoints on `PanelsIPEPageController`.

## Routes (`/admin/panels_ipe/variant/{panels_storage_type}/{panels_storage_id}/…`)

All require the `access panels in-place editing` permission and a `_panels_storage_access`
op (`read`, `update`, or `change layout`):

| Route | Op | Purpose |
|---|---|---|
| `panels_ipe.block_plugins` | read | list available block plugins |
| `panels_ipe.block_plugin.form` | read | block plugin config form |
| `panels_ipe.block_content_types` / `.block_content.form` | read | new custom block content (also needs `administer blocks`) |
| `panels_ipe.layouts` / `panels_ipe.layout.form` | read / change layout | pick & configure a layout |
| `panels_ipe.layout.update` (PUT) / `.save` (POST) / `.update_tempstore` (PUT) | update | persist layout/blocks (or just draft tempstore) |
| `panels_ipe.remove_block` (DELETE) | update | remove a block |
| `panels_ipe.cancel` | update | discard tempstore edits |

## Permissions

- `access panels in-place editing` — use the in-place editor (defined here).
- `use ipe with page manager` (defined by the parent `panels` module) — lets users without
  "use page manager" administer page manager pages through the IPE.
