# Configure Bootstrap Layout Builder

## Enable BLB layouts on an entity

BLB layouts are core Layout Builder layouts, so they appear automatically once Layout Builder
is enabled for an entity view mode:

1. Enable Layout Builder for a bundle's view mode at
   `/admin/structure/types/manage/{type}/display` → *Layout options* → **Manage layout**.
2. In Layout Builder, **Add section** → pick a **Bootstrap** category layout
   (e.g. "Bootstrap 2 Cols", "Bootstrap 3 Cols", up to 12). No per-bundle toggle is needed;
   all `blb_layout` entities are exposed as layouts.

## The per-section configuration UI

Choosing/configuring a Bootstrap section opens a tabbed form (`BootstrapLayout` plugin):

- **Layout tab**
  - **Container type** — radios: `container` (Boxed), `container-fluid` (Full), `w-100` (Edge to Edge). Default `container`.
  - **Gutters** — radios: `0` With Gutters / `1` No Gutters (stored as `remove_gutters`).
  - **Breakpoints** — one radio set per `blb_breakpoint` (Mobile, Tablet, Desktop), each offering the
    column-split options (`blb_layout_option`) allowed for that layout+breakpoint. This is what makes
    the row responsive: each breakpoint picks a structure like `6 6` or `3 9`.
- **Style tab** — embeds `bootstrap_styles` style groups (background color/image/video, spacing, etc.),
  applied to the container **wrapper**. Provided by `StylesGroupManager::buildStylesFormElements()`.
- **Settings tab** ("Advanced Settings", hidden if `hide_section_settings` is on) — free-text
  **classes** and **YAML attributes** for the Container wrapper, Row, and each Column region.

Stored per-section keys (schema `layout_plugin.settings.bootstrap_layout_builder:*`): `container`,
`remove_gutters`, `breakpoints`, `container_wrapper_classes`, `container_wrapper_attributes`,
`container_wrapper` (bootstrap_styles storage), `section_classes`, `section_attributes`,
`regions_classes`, `regions_attributes`, `layout_regions_classes`.

## Global settings — `bootstrap_layout_builder.settings`

Form route `bootstrap_layout_builder.settings` at `/admin/config/bootstrap-layout-builder/settings`
(also `drush cset`). Keys shown with defaults from `config/install`:

| Key | Default | Meaning |
|---|---|---|
| `live_preview` | `true` | AJAX-refresh the Layout Builder canvas as you change section options |
| `hide_section_settings` | `false` | Hide the advanced Settings tab (classes/attributes) from editors |
| `one_col_layout_class` | `col-12` | CSS class applied to a single-column section's region |
| `background_colors` | `""` | Newline `key|label` list of background color options |
| `background_image` | `{bundle: image, field: field_media_image}` | Media bundle/field used for background image |
| `background_local_video` | `{bundle: video, field: field_media_video_file}` | Media bundle/field for background video |

Only `live_preview`, `hide_section_settings`, and `one_col_layout_class` are editable through the
settings form (`SettingsForm`); the others are set via config. There is also a
`bootstrap_layout_builder.styles` config object (route `bootstrap_layout_builder.styles`) that
enables/disables which bootstrap_styles plugins show on the Style tab.

## Managing breakpoints, layouts & layout options (config entities)

Menu: **Admin → Config → Content → Bootstrap Layout Builder** (parent `system.admin_config_content`),
landing on the breakpoints collection. All require permission `configure bootstrap layout builder`.

| Entity | Config prefix | Collection path | Purpose |
|---|---|---|---|
| `blb_breakpoint` | `breakpoint` | `/admin/config/bootstrap-layout-builder/breakpoints` | A responsive tier; has `base_class` (`col`, `col-md`, `col-lg`) + `weight` |
| `blb_layout` | `layout` | `/admin/config/bootstrap-layout-builder/layouts` | A column count (`number_of_columns`); becomes one Layout plugin derivative |
| `blb_layout_option` | `layout_option` | `.../layouts/{blb_layout}/options` (route `entity.blb_layout.options_form`) | A column split (`structure`, e.g. `6 6`) for a layout, with allowed/default `breakpoints` |

Default breakpoints: `mobile` (`col`, weight -8), `tablet` (`col-md`), `desktop` (`col-lg`).
Layout options ship for 2–6 column layouts (equal splits, full-width, and asymmetric splits like
`blb_col_2_25_75` = `3 9`). Everything is configuration and exports with `drush config:export`.

## Permission

`configure bootstrap layout builder` (`restrict access: true`) gates all three routing forms
(settings, styles, layout options) and the config-entity collections/add/edit/delete forms.
