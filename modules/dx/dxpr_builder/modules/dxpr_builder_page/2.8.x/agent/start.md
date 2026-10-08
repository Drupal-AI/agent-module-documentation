<!-- SPDX-License-Identifier: LicenseRef-DXPR-Commercial -->
# DXPR Builder Drag and Drop Page — agent index

Config-only submodule of **dxpr_builder**. Installs a node type **`drag_and_drop_page`**
("Drag and drop Page") whose `body` renders with the DXPR Builder formatter, plus three DXPR
theme-helper layout fields. No settings, permissions, schema, routes, or Drush.

- **The content type, its fields, view display, and the uninstall guard** →
  [configure/content-type.md](configure/content-type.md)

Key facts:
- Node type id: `drag_and_drop_page`. Its `body` view-display component uses formatter
  `dxpr_builder_text` (in `core.entity_view_display.node.drag_and_drop_page.default`).
- Extra fields: `field_dth_page_layout`, `field_dth_main_content_width`, `field_dth_hide_regions`.
- `DXPRBuilderPageUninstallValidator` blocks uninstall while `drag_and_drop_page` nodes exist.
- Depends on `dxpr_builder`, `field_group`, `text`, `node`. Parent docs:
  [../../../../2.8.x/agent/start.md](../../../../2.8.x/agent/start.md).
