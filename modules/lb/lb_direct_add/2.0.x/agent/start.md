<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Layout Builder Direct Add — agent index

Replaces the Layout Builder "Add block" link with a **dropbutton** (or labelled **popover**) of
inline/custom block types, so a block can be added in one click. A permission-gated **"More…"**
link falls back to the core off-canvas chooser.

- **Settings (`use_label`, `label`), the settings form + route** →
  [configure/settings.md](configure/settings.md)
- **How the widget is built (pre_render, restrictions, dropbutton vs popover)** →
  [api/mechanism.md](api/mechanism.md)
- **The two permissions it defines** → [permissions/permissions.md](permissions/permissions.md)

Key facts: config object `lb_direct_add.settings` with `use_label` (0 = dropbutton, 1 = popover
menu) and `label` (popover trigger text, default "Add block"). Enabled purely via
`hook_element_info_alter()` adding `LayoutBuilder::preRender` to the `layout_builder` element —
there is nothing to switch on per entity. Note: the info.yml `configure` route is
`lb_direct_add.settings`, but the route actually defined in routing.yml is
`lb_direct_add.settings_form` at `/admin/config/content/layout-builder-direct-add`.
