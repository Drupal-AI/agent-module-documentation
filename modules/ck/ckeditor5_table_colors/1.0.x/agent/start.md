<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor 5 Table Colors (ckeditor5_table_colors) — agent index

A pure-PHP CKEditor 5 configuration plugin that populates the **color palettes** of Drupal
core's built-in table plugins. It does not ship any JavaScript, filter, route, service, or
permission — it only feeds `backgroundColors` / `borderColors` / `colorPicker` options into
the core `TableCellProperties` and `TableProperties` CKEditor 5 plugins, per text format.
The actual color-to-markup styling is performed by those core plugins, not by this module.
Package `CKEditor 5 Plugin Pack`. Core `^11`. License GPL-2.0+. Installed version **1.0.3**
(version dir `1.0.x`).

## Dependencies

- Drupal modules (`.info.yml`): **`editor`**, **`ckeditor5`** (both core, both required).
- `composer.json` requires only `drupal/core: ^11`. No third-party PHP libraries.
- No `key`, no external services.

## What it provides (from source)

- **One CKEditor 5 plugin** `ckeditor5_table_colors_table_colors` (`ckeditor5_table_colors.ckeditor5.yml`):
  - Wraps/requires core CKEditor 5 plugins `table.Table`, `table.TableCellProperties`,
    `table.TableProperties`; condition: the `ckeditor5_table` Drupal plugin must be enabled.
  - `elements: <table> <td> <th>` — tag names only, **no attributes and no `style`** are
    added to the allowed-HTML set by this plugin (see Security note below).
  - Class `src/Plugin/CKEditor5Plugin/TableColors.php`
    (`CKEditor5PluginDefault` + `CKEditor5PluginConfigurableInterface`/`…Trait`).
- **Config schema** `config/schema/ckeditor5_table_colors.schema.yml`
  (`ckeditor5.plugin.ckeditor5_table_colors_table_colors`): `colors` (sequence of
  `{label, color, type:{background, border}}`), `use_default_colors` (bool),
  `use_colorpicker` (bool), `table_color_columns` (int, min 1),
  `table_color_document_colors` (int, min 0). `data.json` `provides_config_schema: true`.
- **No** `*.routing.yml`, `*.services.yml`, `*.permissions.yml`, `*.libraries.yml`,
  `*.module`, `js/`, `templates/`, install/update hooks, or submodules. `find` over the
  source confirms only: README, LICENSE, info.yml, ckeditor5.yml, composer.json, the schema,
  the one PHP class, plus CI/cspell dev files.

## The plugin class (TableColors.php)

- `defaultConfiguration()`: `colors: []`, `use_default_colors: TRUE`, `use_colorpicker: TRUE`,
  `table_color_columns: 5`, `table_color_document_colors: 10`.
- `buildConfigurationForm()`: renders the four scalar settings plus a dynamic repeating
  fieldset of custom colors. Each color row = `label` (textfield, maxlength 255),
  `color` (`#type => color`, i.e. a browser hex color input), `type` checkboxes
  (`background` / `border`), and a per-row **Remove** button. An **Add Table Color** button
  appends an empty row. Add/remove use AJAX (`refreshColorsCallback`) and rebuild from
  `$form_state->getUserInput()` under the key
  `editor.settings.plugins.ckeditor5_table_colors_table_colors.table_colors_wrapper`.
- `validateConfigurationForm()`: skips validation when the trigger is an add/remove button;
  otherwise requires each custom color to have at least one `type` selected, and errors if
  there are no custom colors AND default colors are disabled (that combination would leave
  the picker as the only source).
- `submitConfigurationForm()`: persists the five config keys from `cleanValues()`.
- `getDynamicPluginConfig($static, $editor)`: the core of the module. Splits `colors` into
  background vs border lists by their `type` flags; if custom colors exist and
  `use_default_colors` is on, merges in a fixed 16-entry `getDefaultColors()` list (CKEditor's
  standard `hsl(...)` swatches). Writes the results into
  `table.tableCellProperties.{backgroundColors,borderColors}` and
  `table.tableProperties.{backgroundColors,borderColors}`. Sets `colorPicker.format = 'hex'`
  when `use_colorpicker`, else disables `colorPicker`/`borderColorPicker` on both. Always sets
  `columns` (= `table_color_columns`) and `documentColors` (= `table_color_document_colors`)
  on both cell and table properties.

## How to configure (agent quick path)

Table Colors has **no admin route** (`data.json.configure: null`). It is configured per text
format at `/admin/config/content/formats` → *Configure* a CKEditor 5 format → the Table Colors
plugin settings (requires the `administer filters` permission). Colors then appear in the
table and table-cell "Properties" dropdowns while editing. Because the color values are
emitted only through core's table plugins, the rendered `style`/color markup on saved content
is produced and allowed by core's table cell properties support — ensure that support is
enabled in the format for the colors to survive filtering.

## Security note (public, non-sensitive)

This module has no PHP-facing attack surface of its own: no routes, controllers, uploads,
HTTP clients, database queries, or permissions. All configuration is a privileged
`administer filters` operation. Its `elements` list adds only bare `<table>/<td>/<th>` tags
and does not widen `style` or set `attributes: true`, so it does not itself broaden allowed
HTML beyond what core's table plugins already govern.
