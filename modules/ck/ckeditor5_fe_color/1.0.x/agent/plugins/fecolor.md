<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# FeColor CKEditor 5 plugin — config, allowed HTML, customization

Plugin id **`ckeditor5_fe_color_fecolor`**. Toolbar item **`fecolor`** ("Fe Font Color").

## Install / enable

1. `drush en ckeditor5_fe_color` (requires core `ckeditor5`; core `>=10.1`). `drush cr`.
2. *Admin → Configuration → Content authoring → Text formats and editors* → edit a CKEditor 5
   format → drag **Fe Font Color** from *Available buttons* into the *Active toolbar*.
3. Ship CSS in your theme/module that colors the palette classes, otherwise the markup is applied
   but nothing looks colored. Example: `span.color-black { color: var(--color-black); }`.

## Plugin definition (`ckeditor5_fe_color.ckeditor5.yml`)

- `ckeditor5.plugins: [ fecolor.FeColor ]` — the JS plugin export.
- `ckeditor5.config.fecolor.colors` — the **palette** (the default two, Black + White).
- `drupal.class: Drupal\ckeditor5_fe_color\Plugin\CKEditor5Plugin\FeColor`.
- `drupal.library: ckeditor5_fe_color/ckeditor5.fecolor` (loads `js/build/fecolor.js`, minified,
  depends on `core/ckeditor5`); `drupal.admin_library: …/admin.fecolor` (loads `css/fecolor.css`).
- `drupal.toolbar_items.fecolor` — the button.
- `drupal.elements: ['<span>', '<span class="color-black color-white">']` — the HTML this plugin
  contributes to the format's allowed-tags. **Only the `class` attribute on `span`**, and only the
  listed classes; no `style` attribute is ever added. If you add palette classes you must extend
  this list too (see below), or the filter strips your new classes.

## Palette entry shape (config schema `ckeditor5.plugin.ckeditor5_fe_color`)

`config/schema/ckeditor5_fe_color.schema.yml` types `colors` as a sequence of mappings:

- `label` (string) — dropdown label.
- `color` (string) — swatch color shown in the dropdown; any CSS color form (hex, `var(--x)`, …).
- `class` (string) — the CSS class written into the content markup.
- `options.hasBorder` (bool, default false) — draw a border around the swatch (for light colors).

## PHP class (`src/Plugin/CKEditor5Plugin/FeColor.php`)

Extends `CKEditor5PluginDefault`. `getDynamicPluginConfig($static_plugin_config, $editor)` is a
**no-op** — it returns `$static_plugin_config` unchanged (docblock + `@ToDo` only). So per-format
dynamic palettes are **not** produced here; use the hooks below.

## JS mechanism (`js/ckeditor5_plugins/fecolor/src/`)

- `fecolor.ts` — `FeColor` plugin `requires [FeColorEditing, FeColorUI]`.
- `fecolorui.ts` — `FeColorUI` maps `config.fecolor.colors` to `ColorDefinition[]` and builds a
  `ColorSelectorView` dropdown (5 columns, `colorPickerViewConfig: false` → **no free color
  picker**, only the defined swatches; 4 document colors). On execute it runs `editor.execute
  ('fecolor', {value})`.
- `fecolorediting.ts` — extends `$text` schema with attribute `fecolor`; for **each** configured
  class registers an **upcast** `span.<class>` → model value (the color), and a single **downcast**
  `fecolor` → `writer.createAttributeElement('span', { class: map.getForward(value) ?? value })`.
  Attribute values are set through the CKEditor writer (attribute-escaped); the `?? value` fallback
  emits the raw model value as the class only when it is not in the palette map.
- `lib/Colors.ts` — `getFeColorClasses()` / `getFeColorMap()` (a `TwoWayMap`, `lib/TwoWayMap.ts`).
- `fecolorcommand.ts` — `FeColorCommand`: `execute({value})` sets/removes the `fecolor` attribute
  on the selection (or on valid ranges); `refresh()` reflects the current selection's value.

## Customizing the palette (recommended: a custom module, per README)

Do **not** edit this module. From `mymodule`:

- `hook_editor_js_settings_alter(&$settings)` — set
  `$settings['editor']['formats']['<format>']['editorSettings']['config']['fecolor']['colors']`
  to your array of `{label, class, color, options}` entries (this feeds `FeColorUI`).
- `hook_ckeditor5_plugin_info_alter(&$plugin_definitions)` — append
  `'<span class="<class1> <class2> …">'` to
  `$plugin_definitions['ckeditor5_fe_color_fecolor']` `drupal.elements` so your classes survive
  HTML filtering. (Rebuild the `CKEditor5PluginDefinition` via `->toArray()` → `new
  CKEditor5PluginDefinition(...)`.)
- `hook_library_info_alter()` + a `ckeditor5-stylesheets:` list in your `.info.yml` — load your
  content CSS into the editing view.

The submodule **`ckeditor5_fe_color_config_example`** is a complete, working copy of exactly this
recipe (see its docs).

## Notes

- No config UI yet — palette lives in code/config only; changes need a cache rebuild (`drush cr`).
- Coloring is **class-based, not inline-style**: define the `color` CSS for each class or nothing
  renders colored on the front end.
