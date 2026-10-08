<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Layout Builder Styles Conditions — agent index

Attaches Conditions-API rules to individual **Layout Builder Styles** so a style only appears in the LB dropdowns when its conditions pass. Depends on `layout_builder_styles` + `conditions_helper`. Config UI at `/admin/config/user-interface/lb-styles-conditions` (`configure` = `lb_styles_conditions.settings`, permission `administer lb_styles_conditions`, restricted). Provides config schema. Authoring-UI convenience, **not** an access/security boundary on rendered pages.

- **Adding conditions to a style, how availability is enforced in the LB UI, and the admin allow-list** → [configure/conditions.md](configure/conditions.md)
- **`hook_lb_styles_conditions_available_conditions_alter` to add/remove available conditions** → [hooks/alter.md](hooks/alter.md)

Key facts:
- Conditions stored in `layout_builder_styles.style.*.third_party.lb_styles_conditions` (style entity third-party settings).
- Enforced in block/section forms: failing styles have their `layout_builder_style_<group>` element removed (`FormAlters::evaluateConditions`).
- Settings key `lb_styles_conditions.settings.enabled_conditions` limits which condition plugins are offered.
