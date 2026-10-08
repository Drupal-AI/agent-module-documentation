# Theme — libraries, asset attachment & cookie rendering

The module ships the **Infusion library v4.8.0 precompiled and bundled** under the module's
`infusion/` directory and loads it **locally — there is no CDN or remote fetch**. Two asset
libraries are defined in `fluidui.libraries.yml`.

## Libraries

| Library | Contents | Deps |
|---------|----------|------|
| `fluidui/fluidui.infusion` | Infusion CSS (`infusion/src/lib/normalize/css/normalize.css`, `.../framework/core/css/fluid.css`, `Enactors.css`, `PrefsEditor.css`, `SeparatedPanelPrefsEditor.css`) + `infusion/infusion-all.js` (weight -1) | `core/drupal`, `core/jquery` |
| `fluidui/fluidui.theme` | module `css/fluid.css` (positions the panel) + `js/fluidui_load.js` (weight -3) | `core/drupal`, `core/jquery`, `core/once` |

`js/fluidui_load.js` boots the widget once via `Drupal.behaviors.fluid`, calling
`fluid.uiOptions('.flc-prefsEditor-separatedPanel', { auxiliarySchema: { terms: {…} }, prefsEditorLoader: { lazyLoad: true } })`.
It reads `drupalSettings.modulePath` and `drupalSettings.translationsDirectory` to build the
template/message URLs it hands Infusion.

## How assets get attached

`fluidui_preprocess_page()` (`fluidui.module`) attaches **both** libraries to the page and sets:

- `drupalSettings.modulePath` — `base_path().'libraries'` when `/libraries/infusion` exists on
  disk, otherwise the module's own path. The JS resolves Infusion HTML templates / message JSON
  under this.
- `drupalSettings.translationsDirectory` — `/sites/default/files/fluidui-translations/` when that
  public directory exists, else `""`.

Attachment is gated by `admin_display` and `url_blacklist` (see
[configure/settings.md](../configure/settings.md)); it happens whether the toolbox markup comes
from `page_top` or from the block.

## Optional site-level library copy

`fluidui_library_info_alter()` (`hook_library_info_alter`) checks for `DRUPAL_ROOT/libraries/infusion`.
If present, it **rewrites the `fluidui.infusion` CSS/JS paths to load from `/libraries/infusion`
instead of the bundled copy** — letting a site drop in its own compiled Infusion build without
patching the module. No config controls this; presence of the directory is the switch.

## Server-side preference rendering (cookie → body classes)

`fluidui_preprocess_html()` reads the visitor's **`fluid-ui-settings` cookie**
(`json_decode($_COOKIE['fluid-ui-settings'])`) and, from its `preferences` object, adds classes so
the chosen preferences apply on the very first render (no flash before JS runs):

- `fl-theme-<fluid_prefs_contrast>` on `<body>` (contrast theme)
- `fl-font-<fluid_prefs_textFont>` on `<body>` (font family)
- `fl-input-enhanced` (input enhancement flag)
- `line-height: 3` inline style when `fluid_prefs_lineSpace` is set

Malformed JSON decodes to null and the `isset()` guards simply skip; class values render through
Drupal's `Attribute` object (HTML-escaped). Adds cache contexts `url.path`, `user`.

## Toolbox markup / template

`fluidui_theme()` registers theme hook **`fluid_ui_block`** (render element `content`), template
`templates/fluid-ui-block.html.twig`. The template is static markup: the
`.flc-prefsEditor-separatedPanel` container Infusion binds to, Reset / Show-Hide buttons, and a
`.flc-toc-tocContainer` nav for the generated table of contents. It is rendered either
automatically by `hook_page_top` or via the `fluidui_block` block.

## Install-time behavior

`fluidui_install()` sets the module weight to 400 (so its `page_top`/preprocess run late) and calls
`_prepare_language_directory()`, which creates `public://fluidui-translations/` and copies the
module's `messages/{en,fr,es}` JSON files there (i18n is done through those JSON files, not the
Drupal translation UI). `hook_update_10301` re-runs the same directory preparation.
