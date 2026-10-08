# Configure Bootstrap Styles

## Settings form

- Route: `bootstrap_styles.settings` → `/admin/config/bootstrap-styles/settings`
  (menu: Admin → Configuration → Content authoring → Bootstrap Styles).
- Permission: `configure bootstrap styles` (`restrict access: true`).
- Form: `\Drupal\bootstrap_styles\Form\SettingsForm`. It renders every group's and style's
  `buildConfigurationForm()` — so the form is assembled from the plugins themselves.

The style controls applied to Layout Builder are **not** turned on here — this form only edits
the option classes and global settings. The controls appear on sections/blocks via a consumer
module (bootstrap_layout_builder) calling `StylesGroupManager`.

## Config object — `bootstrap_styles.settings`

One `config_object` (schema: `config/schema/bootstrap_styles.schema.yml`). Edit via the form or
`drush cset bootstrap_styles.settings <key> <value>`. Key groups (defaults in
`config/install/bootstrap_styles.settings.yml`):

| Key(s) | Meaning / default |
|---|---|
| `layout_builder_theme` | Off-canvas builder UI theme: `dark` (default) or `light` |
| `background_colors`, `text_colors`, `text_colors_{desktop,laptop,tablet,mobile}`, `text_alignment` | Option lists for color/alignment styles |
| `padding*`, `margin*` (all sides, `_{desktop,laptop,tablet,mobile}` breakpoints) | Spacing option lists, e.g. `bs-p-3\|Padding 3` |
| `border_style*`, `border_width*`, `border_color*`, `rounded_corner*` | Border option lists |
| `box_shadow` | Shadow option list (`bs-shadow-sm\|Small` …) |
| `scroll_effects` | Animation option list (AOS effect keys → labels) |
| `background_image`, `background_local_video` | `{bundle, field}` of the media type used for bg image / local video |
| `attribute_type`, `data_key`, `scroll_effects_attr_type`, `scroll_effects_data_key`, `scroll_effects_library_type` | AOS scroll-effects wiring (default library type `external`) |

Option-list format: one `key|label` per line, where `key` is the CSS class (no leading dot)
and `label` is the human name (helper `getStyleOptions()` parses this and adds a `_none` / N/A
option). Because it is a config object it exports/deploys with `drush config:export`.

## Filtering which styles are offered

`StylesGroupManager::getAllowedPlugins($filter)` + `Form\StylesFilterConfigForm`
(`bootstrap_styles_filter`) let a consumer store a per-context whitelist of enabled
groups/plugins (config key `plugins` → `[group][plugin]['enabled']`). Passed as the `$filter`
arg to `buildStylesFormElements()` / `submitStylesFormElements()`.
