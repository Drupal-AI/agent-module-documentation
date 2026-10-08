<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor5 FeColor Plugin (ckeditor5_fe_color) — agent index

A CKEditor 5 toolbar plugin that gives editors a **font-color dropdown** whose swatches come
from a **configurable, class-based palette**. Picking a color wraps the selection in
`<span class="…">`; the visible color is produced by **CSS your theme/module ships** for that
class. Package `CKEditor 5 Custom`. Depends only on core **`ckeditor5`**. Core requirement
`>=10.1`. License GPL-2.0-or-later. Version 1.0.2 (version-dir `1.0.x`).

- **The plugin, its palette config, the allowed HTML, and how to add/override colors** →
  [plugins/fecolor.md](plugins/fecolor.md)

## What it actually is

- One CKEditor 5 plugin definition, id **`ckeditor5_fe_color_fecolor`**, declared in
  `ckeditor5_fe_color.ckeditor5.yml` (not annotation-based). PHP class
  `Drupal\ckeditor5_fe_color\Plugin\CKEditor5Plugin\FeColor` (`src/Plugin/CKEditor5Plugin/FeColor.php`)
  extends `CKEditor5PluginDefault`; its `getDynamicPluginConfig()` currently **returns the static
  config unchanged** (a no-op with a `@ToDo`).
- The behavior is in the compiled JS plugin `FeColor` (`js/build/fecolor.js`, source in
  `js/ckeditor5_plugins/fecolor/src/`): `FeColorEditing` (model schema + upcast/downcast
  converters + `FeColorCommand`), `FeColorUI` (the color dropdown built from
  `ColorSelectorView`).
- **No routes, no permissions, no services, no forms, no config UI.** Palette is code/config-based.
- Provides config **schema** (`config/schema/ckeditor5_fe_color.schema.yml`, key
  `ckeditor5.plugin.ckeditor5_fe_color`). No `config/install`.

## Mechanism (from source)

- Toolbar item `fecolor` (label *"Fe Font Color"*). Default palette (in the `.ckeditor5.yml`
  `config.fecolor.colors`): Black `#000000` → class `color-black`; White `#FFFFFF` → class
  `color-white` (`hasBorder: true`).
- Each palette entry is `{ label, color, class, options?.hasBorder }`. `color` is only what the
  swatch shows in the dropdown; `class` is what actually lands in the markup.
- JS (`fecolorediting.ts`): extends `$text` with a `fecolor` attribute; registers **one upcast
  converter per configured class** (`span.<class>` → model value = that color) and a **downcast**
  that emits `<span class="<class>">` (falls back to the raw model value as the class if it is not
  in the map — see [plugins/fecolor.md](plugins/fecolor.md)). Uses a `TwoWayMap` (color↔class).
- Allowed elements (`.ckeditor5.yml` `drupal.elements`): `<span>` and
  `<span class="color-black color-white">` — i.e. only the **`class`** attribute on `span`,
  scoped to defined classes. It never permits a `style` attribute.

## Submodule

- **`ckeditor5_fe_color_config_example`** — an example/reference module showing how to register a
  palette + CKEditor stylesheets via hooks (adds red/green to the default two). Documented at
  [../modules/ckeditor5_fe_color_config_example/1.0.x/agent/start.md](../../modules/ckeditor5_fe_color_config_example/1.0.x/agent/start.md).

## Operating notes

- Enable, then in *Manage text formats and editors* for a CKEditor 5 format drag the **Fe Font
  Color** button onto the toolbar. Colors only render on the front end if your theme/module
  provides CSS for the palette classes (e.g. `span.color-black { color: … }`).
- There is **no admin form for the palette**; change it in code — either the plugin's
  `.ckeditor5.yml`, or (recommended) from a custom module via `hook_editor_js_settings_alter()` +
  `hook_ckeditor5_plugin_info_alter()`. Full recipe in [plugins/fecolor.md](plugins/fecolor.md).
