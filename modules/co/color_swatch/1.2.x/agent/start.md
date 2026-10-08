<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Color Swatch (color_swatch) — agent index

Adds **color-swatch pickers to theme settings** and renders the chosen colors as **inline CSS**
(a `<style>` in `<head>`) via a Twig template. A modern, custom-properties-friendly alternative to
core's old Color module — no compiled `color.css`, no image slicing. Version **1.2.0**. Core
`^9 || ^10 || ^11`. License GPL-2.0-or-later. No dependencies. No routes, controllers, plugins,
permissions, or config schema.

## How it works (from source)

1. **Theme declares swatches** in its `.info.yml` under a `color-swatch:` key:
   ```yaml
   color-swatch:
     placeholders: [primary, secondary, tertiary]   # color roles used in the CSS template
     default: default                                # name of the default swatch
     swatches:
       default:
         primary: '#FFFFFF'
         secondary: '#FFFF00'
         tertiary: '#FF0000'
   ```
   `ColorSwatchManager` reads these via `extension.list.theme`
   (`getThemeColorSwatchPlaceholdersInfo`, `getThemeColorSwatchesInfo`, `getThemeDefaultColorSwatchName`).
   `hasColorSwatches()` requires all three (default + placeholders + swatches) to be non-empty.

2. **Theme-settings form** (`color_swatch_form_system_theme_settings_alter` in `color_swatch.module`):
   adds a `Color Swatch` details group with an `active` `select` (each defined swatch name plus a
   reserved `custom` option) and, per swatch, a `#type => 'color'` field per placeholder pre-filled
   with `getHex()`. The name `custom` is reserved; the alter emits validation messages when swatches,
   placeholders, or the default are missing/misdefined. Settings live in theme settings config under
   the `color_swatch` key (`active` + per-swatch `settings`), read via `theme_get_setting()`.

3. **Runtime CSS output** (`color_swatch_page_attachments`, `hook_page_attachments`): for the
   active theme with swatches, gets the active swatch (`getActiveColorSwatch` → applies the
   `hook_active_color_swatch_alter` alter), calls `ColorSwatch::renderCss()`, and attaches the result
   as an `html_head` `<style>` element keyed `color_swatch-css`. `getActiveColorSwatchName()` returns
   the theme default unless theme settings set `active` (may be `custom`).

## Key classes / files

- `src/ColorSwatchManager.php` — service `color_swatch.manager` (args: `@theme.manager`,
  `@extension.list.theme`, `@module_handler`). Reads theme info + settings, builds `ColorSwatch`
  objects, `validateHex()` (accepts `#ffffff`/`#fff`/`ffffff`/`fff`, expands shorthand, else returns
  `000000`), `hexToHsl()`.
- `src/ColorSwatch.php` — value object for one swatch. `getHex($placeholder)` (raw stored value, or
  `#000000` if unset), `getRgb`, `getHsl`, `getHue`, `getSaturation`, `getLightness`,
  `getContrastRatio` (0–10; >5 ≈ light), `getName/setName`, `getTheme/setTheme`, `isDefault`,
  `renderCss()` (renders the `color_swatch_css` theme via the renderer).
- `templates/color-swatch-css.html.twig` — default output; emits `:root { --color-<ph>: <hex>;
  --color-<ph>-hue/-lightness/-saturation/-contrast-ratio: … }` per placeholder. Theme-overridable
  (`hook_theme` `color_swatch_css`, variable `color_swatch`).
- `color_swatch.api.php` — `hook_active_color_swatch_alter(ColorSwatch $colorSwatch)`: mutate the
  active swatch on the fly (e.g. `setName('custom')`, `setTheme(...)`).

## Notes / gotchas

- **Custom swatch** values come from the theme-settings `#type => 'color'` fields (edited by users
  with *administer themes*). `getHex()` returns the stored value verbatim into the CSS template;
  numeric/HSL helpers route through `validateHex()`, but the raw `--color-*: <hex>` line does not.
- Latent bug (non-security): `getActiveColorSwatchName()` calls `->alter('active_color_swatch_name',
  $colorSwatch)` on an uninitialized `$colorSwatch` — harmless unless a module implements that hook.
- `composer.json` declares `license: proprietary` (packaging artifact); the project is GPL-2.0-or-later.
