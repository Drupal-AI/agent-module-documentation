Panels IPE (In-Place Editor) is the Panels submodule that lets editors build a Panels display directly on the rendered front end — dragging blocks between layout regions and swapping layouts without a separate admin wizard.

---

Panels IPE provides a JavaScript (Backbone/jQuery UI) single-page app that overlays a Panels display, letting an editor change the layout, add/move/remove blocks (panes), and create new custom block content in place, then save. It swaps in its own `InPlaceEditorDisplayBuilder` (DisplayBuilder plugin id `ipe`) so a Panels display renders with the editor UI attached. All editing happens over AJAX routes under `/admin/panels_ipe/variant/{panels_storage_type}/{panels_storage_id}/…` handled by `PanelsIPEPageController` (get block plugins, block/layout forms, update/save/remove, block content types), each gated by the `_panels_storage_access` check plus the `access panels in-place editing` permission. It depends on `panels`, core `block_content`, and `jquery_ui_droppable`. It defines an `IPEAccess` plugin type (manager `plugin.manager.ipe_access`) for pluggable access rules, and offers hooks to alter the block/layout lists and act before a display is saved (`hook_panels_ipe_blocks_alter`, `hook_panels_ipe_layouts_alter`, `hook_panels_ipe_panels_display_presave`). It requires a Panels display backed by a storage plugin (e.g. Page Manager), since it needs somewhere to persist changes.

---

- Edit a Panels display directly on the front end instead of a back-end wizard.
- Drag and drop blocks between a layout's regions in the browser.
- Add an existing block plugin into a region via the in-place block picker.
- Create new custom block content inline while editing a page.
- Change the layout of a display and remap blocks without leaving the page.
- Remove a block from a region with a single click.
- Reorder blocks within a region visually.
- Save layout/block changes over AJAX back to the display's storage.
- Cancel in-progress edits and discard tempstore changes.
- Restrict who can use the editor with the `access panels in-place editing` permission.
- Add custom access logic with an `IPEAccess` plugin (e.g. per-role or per-context rules).
- Filter which block plugins appear in the picker via `hook_panels_ipe_blocks_alter()`.
- Filter which layouts appear in the layout picker via `hook_panels_ipe_layouts_alter()`.
- Act on a display before it is saved via `hook_panels_ipe_panels_display_presave()`.
- Give Page Manager editors an on-page editing experience for panels variants.
- Let non-technical editors rearrange page regions without touching config forms.
- Preview block plugin configuration forms inline before placing them.
- Choose from available block content types when creating new inline content.
- Update just the tempstore (draft) state of a layout without a full save.
- Grant IPE access to Page Manager pages via the `use ipe with page manager` permission.
