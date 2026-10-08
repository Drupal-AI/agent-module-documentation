<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# USWDS Layout Builder Configuration (uswds_blb_configuration) — agent index

Bridges the U.S. Web Design System (USWDS) grid and component styling into core **Layout Builder**.
It ships three config entity types — `uswds_breakpoint`, `uswds_layout`, `uswds_layout_option` — that
define a responsive grid; `Plugin/Deriver/UswdsLayoutDeriver` turns each `uswds_layout` entity into a
selectable Layout Builder layout (`uswds_blb_configuration:<layout_id>`, category `USWDS`, regions
`uswds_region_col_1..N`, theme hook `uswds_section`). On top of the grid it adds two annotation-based
plugin types — **`@Style`** (background, border, spacing, shadow, typography, scroll-effects classes)
and **`@StylesGroup`** — orchestrated by `StylesGroupManager`, applied to sections via the layout
form and to blocks via `hook_form_alter` + a `SECTION_COMPONENT_BUILD_RENDER_ARRAY` event subscriber
that writes styles into the render array. Ships 9 breakpoints and 12 column layouts as default config.

Entry points: the admin section under `/admin/config/uswds-layout-builder` (settings, styles,
breakpoints, layouts, options), the derived layouts in the Layout Builder UI, and the block "Style"
tab. Values are persisted on section/component config under the `uswds_styles` key.

- Depends on: `drupal:layout_builder`, `drupal:media_library`,
  `media_library_form_element:media_library_form_element`.
- Core: `^10.3 || ^11`. Package: `Layout Builder`. Version 3.1.0.
- Composer: `drupal/media_library_form_element:^2.1`. No PHP lib deps. GPL-2.0-or-later.
- Configure route: `uswds_blb_configuration.settings`. Permission: `configure uswds layout builder`
  (config entities themselves use core `administer site configuration`).
- Plugin types: `Style` (`plugin.manager.uswds_styles`), `StylesGroup`
  (`plugin.manager.uswds_styles_group`). No Drush. Provides config schema.
- Submodule: `uswds_blb_configuration_media_library` (theming glue for the media-library widget on LB
  pages; its own info.yml is marked "WARNING DOESN'T WORK WELL" — enable with care).

## What you'd do → where
- Configure settings, styles, LB theme, enabled style plugins → `agent/configure/settings.md`
- Define/edit breakpoints, layouts, layout options (the grid) → `agent/configure/entities.md`
- Add or understand `@Style` / `@StylesGroup` plugins & the derived layout → `agent/plugins/styles.md`
- Services, event subscriber, render elements, theme hooks, hooks, routes → `agent/api/services.md`

## Key facts (real machine names)
- Config entities: `uswds_breakpoint` (prefix `breakpoint`), `uswds_layout` (prefix `layout`),
  `uswds_layout_option` (prefix `layout_option`).
- Layout plugin base id: `uswds_blb_configuration` (`#[Layout]`, deriver `UswdsLayoutDeriver`).
- Style plugin ids: `background_color`, `background_media`, `border`, `box_shadow`, `margin`,
  `padding`, `scroll_effects`, `text_alignment`, `text_color`.
- StylesGroup ids: `animation`, `background`, `border`, `shadow`, `spacing`, `typography`.
- Services: `plugin.manager.uswds_styles`, `plugin.manager.uswds_styles_group`,
  `uswds_layout_builder_blocks.render_block_component_subscriber`.
- Render elements: `uswds_container`, `uswds_container_wrapper`, `uswds_video_background`.
- Config objects: `uswds_blb_configuration.settings`, `…style_settings`, `…section_styles`,
  `…block_styles`, `…layout_defaults`.
- Routes: `entity.uswds_breakpoint.collection`, `entity.uswds_layout.collection`,
  `entity.uswds_layout.options_form`, `entity.uswds_layout_option.add_form`,
  `uswds_blb_configuration.settings`, `…section_styles`, `…block_styles`, `…style_settings`,
  `…ajax_temp_store_set`, `…ajax_temp_store_get`.
- Permission: `configure uswds layout builder`. Plugin alter hook: `uswds_blb_configuration_info`.
