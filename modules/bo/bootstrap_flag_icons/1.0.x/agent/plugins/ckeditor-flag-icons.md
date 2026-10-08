<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor 5 flag-icon plugin

Lets editors search a bundled flag list and insert a flag icon into rich text. Defined in `bootstrap_flag_icons.ckeditor5.yml` (plugin id `bootstrap_flag_icons_plugin`, CKEditor plugin `flagIcons.FlagIcons`), PHP class `Drupal\bootstrap_flag_icons\Plugin\CKEditor5Plugin\FlagIcons`.

## Enable on a text format

1. Enable core **ckeditor5** and this module.
2. At `admin/config/content/formats/manage/<format>`, drag the **"Flag icons"** toolbar button (label from `toolbar_items.flagIcons`) into the active toolbar.
3. The plugin's config form then appears (see settings below).

`elements` in the YAML whitelists `<i>` and `<i class="fi">`, so those flag tags survive the text-format's HTML filtering. `admin_library` / `library` load `bootstrap_flag_icons/flag_icons.plugin` (JS `js/build/flagIcons.js`, depends on `core/ckeditor5`, `flag-icons`, `admin.flag_icons`).

## Settings (schema `ckeditor5.plugin.bootstrap_flag_icons_plugin`)

Form built by `FlagIcons::buildConfigurationForm()`; keys default in `defaultConfiguration()`:
- `cdn_flag` (boolean, default FALSE) — "Icon flag CDN". When TRUE the plugin serves flags from the CDN base URL derived from the `flag-icons` library instead of the module's local `flags/` path. Enable if the admin theme lacks flag CSS.
- `img` (boolean, default FALSE) — "Show image". Insert flags as images rather than CSS `<i>` glyphs.
- `ratio` (string, default `4x3`) — "Ratio". Options `1x1` or `4x3`; selects which `flags/<ratio>/` SVG directory to use.

`validateConfigurationForm()` is a no-op (returns FALSE); `submitConfigurationForm()` casts and stores the three values.

## Dynamic config passed to JS

`getDynamicPluginConfig()` builds the runtime config under key `flag_icons`:
- reads the bundled search list from `js/iconSearch.json` (local file, `file_get_contents` + `Json::decode`) — this is the searchable index (ISO code, English/French names, country code);
- computes `url` = base_path + module path + `/flags/<ratio>/`, or the CDN base when `cdn_flag` is set (via `LibraryDiscoveryInterface::getLibraryByName()`);
- passes `ratio`, `img`, `cdn`, `url`, and `search_list` to the JS plugin.

The JS uses this to render the search picker and insert the chosen flag markup into the editor.

## Operating notes

- The searchable icon set is fixed by the shipped `js/iconSearch.json`; there is no admin UI to extend it.
- Inserted markup is `<i class="fi …">` (or `<img>` when `img` is on); ensure the format's allowed-HTML permits these — the plugin already declares them in `elements`.
- No routes, permissions, or services are added by this plugin; all behavior is per-text-format editor configuration.
