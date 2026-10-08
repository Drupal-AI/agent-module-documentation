<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Ephoto DAM — CKEditor 5 plugin, chooser flow, and render filter

Two cooperating pieces: a **client-side CKEditor 5 plugin** that inserts placeholder markup, and a
**server-side text-format filter** that rewrites that placeholder into the final embed at render.

## CKEditor 5 plugin (JS)

Compiled bundle: `js/build/plugin.js` (built by `webpack.config.js` from
`js/ckeditor5_plugins/plugin/src/`). Sources:

- `index.js` → exports `ephoto_dam` = `{ EphotoDam, EphotoDamUI }`.
- `ephotodamadd.js` — `EphotoDamAdd` plugin: defines the `simpleBox` model schema and registers the
  `insertEphotoDam` command (`InsertEphotoDamCommand`).
- `ephotoDamUI.js` — `EphotoDamUI`: registers the toolbar button `simpleBox` (icon
  `icons/ephotoDamIcon.svg`); on button click runs `insertEphotoDam`. Also wires the
  `change:data` handler that fills captions, and the right-click zoom toggle.
- `ephotodampress.js` — `InsertEphotoDamCommand`, the chooser + Ephoto API calls.

### Chooser flow (`ephotodampress.js`)

1. On load it injects `<script src="<server_url>api/apiJS.js">` — the Ephoto server's own SDK.
2. `execute()` GETs `<server_url>api/auth/getNewAuthID`; the returned auth id is stored in cookie
   `ephoto_dam_authid` and in `drupalSettings.ephoto_dam.auth_id`, then `connectEphoto()` runs.
3. `connectEphoto()` instantiates `new EphotoDam({ server, authID, version: 5018, client: 'bD3ui8br' })`,
   sets embed mode and per-type button sizes (from the plugin config `images_size` / `videos_size`
   / `documents_size` / `zoom`), and opens the Ephoto chooser popup.
4. On selection, `insertFile()` → `getlink()` GETs
   `<server_url>api/<authId>/link/getToShare?files[]=<id>&deadline=-1` to obtain a share URL.
5. `preparemedia()` builds an `<img class="ckeditor_ephoto_dam …" data="{…}">` placeholder whose
   `data` attribute is a JSON blob (`ephoto_dam` type = `image` or the DC type, `src`/`embed`,
   `width`, `id_image`, `zoom`, `captions`, `captions_format`, `align`, `title`…) and inserts it
   into the editor.
6. If captions are on, `ephotoDamUI.js` `replaceCaptionMedia()` GETs
   `<server_url>api/<authId>/file/getInfo?id=<id>` and replaces `[fieldName]` tokens in the caption
   format with the matching Ephoto metadata field values.

All Ephoto API traffic in this module is issued by the **browser** (`fetch` / `XMLHttpRequest` /
injected `<script>`) against the configured `server_url`; the PHP side performs no outbound HTTP.

Front-end library `ephoto_dam/display` (`js/ephoto_dam.js`) implements the lightbox zoom: elements
with class `ephoto-dam-zoom` open an overlay with the full-size image on click.

## Render filter (PHP)

Class `Plugin\Filter\EphotoDam`:

```
@Filter(id = "ephoto_dam_2", title = "Ephoto Dam",
        type = TYPE_TRANSFORM_IRREVERSIBLE)
```

- `process($text, $langcode)` parses the stored text with `DOMDocument`/`DOMXPath`, finds nodes with
  class `ckeditor_ephoto_dam` (`getValidMatches()`), decodes each node's `data` JSON, and reads the
  editor-applied `align`, `width` and `data-caption`.
- For each match it swaps the placeholder `<img id="…">` for final markup:
  - `renderImage()` — `<figure>`/`<article>` wrapper + `<img src alt>` sized to `width`, class
    `ephoto-dam-zoom` when zoom is on, and an optional `<figcaption>`.
  - `renderEmbed()` — a responsive `<iframe src=embed>` (videos/documents), recomputing height from
    the requested width vs the embed URL's original `width`/`height` query params, plus optional
    `<figcaption>`.
- The replacement is done with `preg_replace('/<img …id="<id_div>"…>/', $html, $text)`; the result
  attaches library `ephoto_dam/display`.
- `isValidSettings()` whitelists which `data` keys are carried over
  (`ephoto_dam, align, src, embed, width, height, alt, captions, captions_format, zoom`).

The filter only rewrites markup that the plugin produced; it makes no HTTP calls and touches no
credentials. `hook_help('help.page.ephoto_dam')` in `ephoto_dam.module` documents the full
editor-setup walkthrough.

## Routes & permissions

- Only route: `ephoto_dam.admin_settings` (settings form), permission
  `administer site configuration`. No other routes, controllers or permissions are declared.
