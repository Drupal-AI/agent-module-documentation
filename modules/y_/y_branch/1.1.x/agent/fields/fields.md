<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Install-time bundle scaffolding (fields, groups, displays, LB layout) — y_branch

Everything the module changes on the Branch content type is done imperatively in `y_branch.install`
at install/uninstall and by `hook_update_N`. There is no config YAML shipped, so these are the only
places the machine names appear.

## Node fields created (bundle node/branch)

`_y_branch_create_fields()` (`y_branch.install:46`) creates field storage + config:

- `field_use_layout_builder` — `boolean`, cardinality 1, label "Use Layout Builder". The per-node LB
  toggle read by `YBranchLayoutBuilderEntityViewDisplay::buildSections()` (see hooks/hooks.md).
- `field_branch_menu_links` — `link`, cardinality -1 (unlimited), label "Menu links",
  settings `link_type: 17`, `title: 2`.
- `field_more_hours_link` — `link`, cardinality 1, label "More Hours Link", settings `link_type: 17`,
  `title: 1`.

`y_branch_update_91004()` (`y_branch.install:832`) additionally creates:

- `field_show_all_holidays` — `boolean`, cardinality 1, label "Show All Holidays", default 0. Read by
  the hours helper to bypass the holiday date window (see api/hours-helper.md).

`_y_branch_remove_fields()` deletes `field_use_layout_builder`, `field_branch_menu_links`,
`field_more_hours_link` on uninstall (it does **not** remove `field_show_all_holidays`).

## Field groups (form display, node/branch, default mode)

`_y_branch_create_field_groups()` (`:106`) requires the `field_group` module and:

- creates `group_branch_menu` (format `tab`, label "Menu", contains `field_branch_menu_links`);
- appends `field_more_hours_link` to the existing `group_branch_hours` group;
- `y_branch_update_91004` prepends `field_show_all_holidays` to `group_branch_hours`.

`_y_branch_update_field_groups_on_install()` (`:144`) renames three existing groups —
`group_header_area`, `group_content_area`, `group_bottom_area` — appending
"(deprecated, not displayed in Layout Builder)" to their labels and re-weighting them, and moves
`group_branch_menu` / `group_branch_amenities` to the top. Uninstall (`_y_branch_update_field_groups_on_uninstall`)
strips the "(deprecated…)" suffix back off and `_y_branch_remove_field_groups()` deletes
`group_branch_menu` and removes `field_more_hours_link` from `group_branch_hours`.

## Form & view display components

`_y_branch_update_displays_on_install()` (`:204`) sets, on the Branch **form** display:

- `field_use_layout_builder` → widget `boolean_checkbox` (weight 51);
- `field_branch_menu_links` → widget `link_attributes`;
- `field_more_hours_link` → widget `link_attributes` (weight 100).

On **every** Branch view display it removes those three fields as normal components; on the `full`
view display it removes `layout_builder__layout` and enables Layout Builder.

## Default Layout Builder layout on the Branch `full` view display

`_y_branch_create_sections_layout_builder()` (`:277`) builds and stores a full pre-composed layout as
the `layout_builder` `sections` third-party setting. Sections, in order:

1. `ws_header` — components `ws_site_name`, `openy_gtranslate_block`, `system_menu_block:utility`,
   `ws_site_logo`, `system_menu_block:main`, `ws_search_bar`, `system_menu_block:account`.
2. Branch header — `bootstrap_layout_builder:blb_col_1`, wrapper class `location-header`.
3. Menu — `bootstrap_layout_builder:blb_col_1` with block `y_branch_menu` (`home_link: 1`).
4. Social links — `bootstrap_layout_builder:blb_col_1`.
5. Body — `bootstrap_layout_builder:blb_col_1`.
6. Amenities — creates a non-reusable `block_content` of type `lb_branch_amenities_blocks`
   ("Branch Amenities") and places it as `inline_block:lb_branch_amenities_blocks`.
7. `ws_footer` — `ws_site_logo` (white), `ws_social`, `system_menu_block:footer`,
   `ws_copyright`, `system_menu_block:footer-menu-left|-center|-right`.

It also stamps `y_lb` `styles` defaults (`colorway: ws_colorway_blue`,
`border_radius: ws_border_radius_none`, `border_style_global: ws_border_style_global_drop_shadow`,
`text_alignment_global: ws_text_alignment_global_left`,
`button_position_global: ws_button_position_global_inside`,
`button_fill_global: ws_button_fill_global_filled`) and `layout_builder_restrictions`
`entity_view_mode_restriction.allowed_layouts` =
`bootstrap_layout_builder:blb_col_1..4`, `ws_header`, `ws_footer`.

## Layout Builder block restrictions

`y_branch_update_9002()` (`:593`) and `y_branch_update_9009()` (`:714`) add
`layout_builder_restrictions` `denylisted_blocks['Inline blocks']` entries on the `full` view display:
`inline_block:branch_amenities`, `inline_block:testimonial_item` (9002) and `inline_block:accordion_item`,
`card_item`, `carousel_item`, `donate_item`, `grid_item`, `icon_grid_item`, `statistics_item`,
`tab_item`, `menu_cta` (9009). Both are also called from the install path.

## Update hooks (all reshape the Branch bundle)

`y_branch_update_9001`–`9011`, `91001`, `91004`, `91005`. Notables: `9004` re-adds WS header/footer
sections; `9005`/`9006`/`9008`/`91001` re-stamp sections; `9010` back-fills default `y_lb` styles;
`9011` adds the Utility Menu to the header section; `9003`/`91005` re-run the field-group reshuffle;
`91004` adds `field_show_all_holidays`. `9001` and `9007` are intentionally no-ops.
