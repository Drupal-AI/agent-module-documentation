<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings & style configuration

All admin pages live under `/admin/config/uswds-layout-builder` and require the permission
`configure uswds layout builder` (restrict access). The menu entry
`uswds_blb_configuration.admin_config` points at the breakpoints collection.

## Config forms (routes → form class → config edited)

- `uswds_blb_configuration.settings` — `/admin/config/uswds-layout-builder/settings` —
  `Form\SettingsForm` (form id `uswds_blb_configuration_admin_settings`). This is the module's
  `configure:` route (info.yml). Edits config object **`uswds_blb_configuration.settings`**:
  - `hide_section_settings` (bool), `live_preview` (bool), `responsive` (bool),
    `one_col_layout_class` (string). (`SettingsForm.php:43-64`.)
  - Schema (`config/schema/…schema.yml`) also carries `background_colors`, `background_image`
    (`bundle`/`field`), `background_local_video` (`bundle`/`field`) — the image/video media
    mappings used by the background-media style.
- `uswds_blb_configuration.style_settings` — `/admin/config/uswds-layout-builder/styles-settings` —
  `Form\StylesSettingsForm`. Edits config object **`uswds_blb_configuration.style_settings`**
  (const `SETTINGS`). Holds `layout_builder_theme` (`light`/`dark`), background/text colours,
  padding/margin/border/shadow/scroll-effect option strings, and the `background_image` /
  `background_local_video` media bundle+field mappings. `layout_builder_theme` decides whether
  `theme.light` or `theme.dark` library is attached on layout routes (`.module:163-169`).
- `uswds_blb_configuration.section_styles` — `/admin/config/uswds-layout-builder/styles` —
  `Form\SectionStylesForm` (const `CONFIG = 'uswds_blb_configuration.section_styles'`). Toggles which
  style-group plugins are enabled for **sections**. Stored as
  `plugins.<group_id>.<style_id>.enabled` (bool).
- `uswds_blb_configuration.block_styles` — `/admin/config/uswds-layout-builder/styles-blocks` —
  `Form\BlockStylesForm` (const `CONFIG = 'uswds_blb_configuration.block_styles'`). Same
  `plugins.…enabled` structure for **blocks**, plus `block_restrictions` (list of block plugin ids /
  `inline_block:<bundle>` the block Style tab is allowed on — see `.module:218-236`).
- `Form\StylesFilterConfigForm` — a helper form (const `CONFIG = 'uswds_blb_configuration.settings'`)
  used to filter allowed style plugins.

## How enabled plugins are resolved

`StylesGroupManager::getAllowedPlugins($filter)` reads the `plugins` map from a filter config name
(`uswds_blb_configuration.section_styles` or `…block_styles`) and returns only groups/styles whose
`enabled` flag is TRUE (`StylesGroup/StylesGroupManager.php:129-146`). `buildStylesFormElements()`
and `submitStylesFormElements()` then build/save only those.

## Config objects (agent-editable keys)

| Config object | Purpose | Key keys |
| --- | --- | --- |
| `uswds_blb_configuration.settings` | Global toggles | `hide_section_settings`, `live_preview`, `responsive`, `one_col_layout_class`, `background_image.{bundle,field}`, `background_local_video.{bundle,field}` |
| `uswds_blb_configuration.style_settings` | Style option sources + LB theme | `layout_builder_theme`, `background_colors`, `text_colors`, `padding*`, `margin*`, `border_*`, `box_shadow`, `scroll_effects`, media mappings |
| `uswds_blb_configuration.section_styles` | Enabled section styles | `plugins.<group>.<style>.enabled` |
| `uswds_blb_configuration.block_styles` | Enabled block styles + restrictions | `plugins.<group>.<style>.enabled`, `block_restrictions` |
| `uswds_blb_configuration.layout_defaults` | Container/gutter/breakpoint defaults for the Layout plugin | `container_type`, `remove_gutters`, `breakpoints` |

Live drush check: `ddev drush config:get uswds_blb_configuration.settings`.
