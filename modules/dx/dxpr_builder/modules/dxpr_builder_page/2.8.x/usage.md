<!-- SPDX-License-Identifier: LicenseRef-DXPR-Commercial -->
DXPR Builder Drag and Drop Page is a config-only submodule that ships a ready-made "Drag and drop Page" (`drag_and_drop_page`) content type whose body field renders with the DXPR Builder visual editor.

---

Enabling `dxpr_builder_page` installs a node type `drag_and_drop_page` (label "Drag and drop Page") pre-wired for DXPR Builder: its `body` field's default view display uses the `dxpr_builder_text` formatter, and it adds three DXPR theme-helper fields — `field_dth_page_layout`, `field_dth_main_content_width`, and `field_dth_hide_regions` — that control the page's layout, content width, and which theme regions are hidden. The content type is set to create a new revision by default, is available in the `main` menu (via `menu_ui` third-party settings), and its config is `enforced` to the module. The submodule carries no code beyond a `ModuleUninstallValidator` (`DXPRBuilderPageUninstallValidator`) that blocks uninstalling the module while `drag_and_drop_page` nodes still exist, protecting content. It has no settings, permissions, schema, routes, or Drush of its own — it is pure configuration that depends on the parent `dxpr_builder` plus `field_group`, `text`, and `node`. Use it as an instant starting point for building landing pages without hand-configuring a content type and display.

---

- Spin up a landing-page content type ready for DXPR Builder without configuring it by hand.
- Give marketers a "Drag and drop Page" option under Content → Add content.
- Build full-width marketing pages whose body is the DXPR visual editor.
- Control per-page layout with the `field_dth_page_layout` field.
- Set a page's main content width via `field_dth_main_content_width`.
- Hide specific theme regions (header/sidebar/footer) per page via `field_dth_hide_regions`.
- Provide an out-of-the-box demo of DXPR Builder on a fresh content type.
- Keep page-builder content in its own node type separate from articles/basic pages.
- Ensure new page-builder pages create revisions by default for safe editing.
- Place page-builder pages into the main menu automatically (menu_ui settings).
- Protect content: the module refuses to uninstall while drag_and_drop_page nodes exist.
- Standardize a page-building content model across a site or platform.
- Ship the page-builder content type as enforced, exportable configuration.
- Let editors focus on design instead of field configuration.
- Prototype campaign/landing pages quickly with the DXPR editor.
- Combine DXPR theme-helper layout fields with the visual body editor on one form.
- Serve as a reference config for wiring the dxpr_builder_text formatter onto a node type.
- Offer a consistent authoring experience for all page-builder pages.
- Roll out DXPR page building to editors with zero site-builder setup.
- Pair with dxpr_builder_block to reuse DXPR-built components inside these pages.
