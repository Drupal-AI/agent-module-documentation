Panels is a display engine that lays out content into the regions of a chosen layout, placing blocks (panes) into those regions. It provides the `panels_variant` display variant and no external UI of its own — pair it with Page Manager (or Panels IPE) to actually build pages.

---

Panels supplies a ctools `DisplayVariant` plugin, `PanelsDisplayVariant` (id `panels_variant`), that extends ctools' `BlockDisplayVariant`. A Panels display holds three things: a Layout plugin (from core Layout Discovery — e.g. `layout_onecol`, `layout_twocol`), a set of regions defined by that layout, and blocks assigned to each region with per-block visibility conditions, CSS classes and caching. It renders through a pluggable **DisplayBuilder** (the `StandardDisplayBuilder` by default; Panels IPE swaps in an in-place editor builder). Where a display's configuration lives is abstracted by the **PanelsStorage** plugin type (managed by `panels.storage_manager`); the bundled `PageManagerPanelsStorage` stores displays inside Page Manager page variants, and a `_panels_storage_access` access check gates operations. Panels defines three plugin types — `PanelsStorage`, `PanelsPattern` (tempstore/context wiring, managed by `plugin.manager.panels.pattern`) and `DisplayBuilder` — plus services `panels.display_manager` (encode/decode displays to config) and `panels.storage_manager`. It depends on `ctools` and core `layout_discovery`, ships block add/edit/delete forms under `/admin/structure/panels/...`, a config schema for the `panels_variant`, permissions for panes/layouts/styles/caching/locks, and `hook_panels_build_alter()`. The `panels_ipe` submodule adds the JavaScript In-Place Editor. Panels is the classic alternative/complement to core Layout Builder for region-based page building.

---

- Lay out a page's content into regions using a selected layout (one column, two column, three column, etc.).
- Provide the `panels_variant` display variant to a Page Manager page so a route renders through Panels.
- Place blocks (panes) into named regions of a layout and reorder them.
- Choose and switch the layout of a display, remapping existing blocks into the new regions.
- Apply per-block visibility conditions (context/condition plugins from ctools) to show blocks selectively.
- Add CSS classes, an HTML id, or inline CSS styles to a display or individual pane.
- Configure caching on a Panels display or on individual panes.
- Store a Panels display inside a Page Manager page variant via the `PageManagerPanelsStorage` plugin.
- Implement a custom `PanelsStorage` plugin to persist displays somewhere other than Page Manager.
- Swap the rendering pipeline by implementing a custom `DisplayBuilder` plugin.
- Enable the In-Place Editor (panels_ipe) to edit layouts and blocks directly on the front end.
- Drag blocks between regions in the browser with the IPE Backbone/jQuery UI app.
- Add new custom block content inline while editing a display with the IPE.
- Alter the final rendered output of a Panels display via `hook_panels_build_alter()`.
- Restrict who can configure pane access, advanced settings, styles, caching or locks via permissions.
- Lock and unlock panes in a display so concurrent editors do not clobber each other.
- Serve Panels displays with automatic layout icons for the core layouts (via `hook_layout_alter`).
- Encode a Panels display to/from configuration arrays with the `panels.display_manager` service.
- Gate IPE access with `IPEAccess` plugins (panels_ipe plugin type) beyond the base permission.
- Build page layouts as an alternative to core Layout Builder when you need Page Manager routing.
- Reuse ctools contexts (relationships, entity contexts) inside a Panels display's blocks.
- Extend the block config schema with `css_classes`, `html_id` and `css_styles` on any ctools block plugin.
- Present a title chosen from a specific pane rather than a fixed page title.
- Provide administrative links on panes for editors who can view them.
- Programmatically add, edit or delete blocks in a display through the block CRUD forms.
