<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# layout_builder_blocks — agent index

Adds a **Style** tab (Bootstrap Styles: background/text color, padding, margin, border,
shadow, animation) to the Layout Builder *add/update block* forms, stores the chosen styles
on each `SectionComponent`, and re-applies them to the block's render array on the front end.
Requires the **bootstrap_styles** module (declared dep) and core **layout_builder** (functional
requirement). No config schema, no permissions, no Drush of its own.

- **Admin config: enable style plugins, restrict styling to certain blocks** (route `layout_builder_blocks.styles`, config `layout_builder_blocks.styles`, `block_restrictions`, permission `configure bootstrap layout builder`): [configure/styles.md](configure/styles.md)
- **How per-block styles are stored & rendered; apply/read them in code** (`bootstrap_styles.block_style` on a component, the render-array event subscriber): [api/block-styles.md](api/block-styles.md)
- **Skip (or force) the Style tab on custom routes** (`hook_layout_builder_blocks__is_dashboard_type_route_alter`): [hooks/dashboard-route-alter.md](hooks/dashboard-route-alter.md)
