<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field Group Layout — agent index

Adds a `layouts` Field Group formatter that wraps a field group in a Layout Discovery layout (onecol/twocol/
threecol/…) and places its fields into the layout regions. Works in both `form` and `view` contexts. Depends on
`field_group` + core `layout_discovery`. No global config page (`configure` null), no permissions, no Drush.

- **Using the Layouts formatter in the Field UI, region mapping, config storage** →
  [configure/layout.md](configure/layout.md)
- **Theme hooks, templates, and theme suggestions the module registers** →
  [theming/templates.md](theming/templates.md)

Key facts:
- `field_group` formatter plugin id `layouts` (`LayoutFormatter`); also an overridden `default` formatter.
- Layout options come from `plugin.manager.core.layout`; the chosen layout id is stored as `field_layout` in the
  group's `third_party.field_group` settings (schema `field_group.field_group_formatter_plugin.layouts`).
- Render: `hook_field_group_pre_render_alter()` sets `#theme_wrappers` to
  `field_group__<layout_id>` + `field_group_layouts`.
