<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# JS plugin internals — `videoImce.js`

Source: `js/ckeditor5_plugins/videoImce/videoImce.js`. IIFE `(function (Drupal, CKEditor5) { … })`
exposing `CKEditor5.videoImce = { VideoImce }`. Class `VideoImce extends CKEditor5.core.Plugin`,
`pluginName = 'VideoImce'` (referenced from `.ckeditor5.yml` as `videoImce.VideoImce`).

## init()

- Calls `_defineSchema()` and `_defineConverters()`.
- Registers UI component `videoImce`: a `ButtonView` (label `Drupal.t('Insert video')`, inline SVG
  camera icon, `withText:false`). On `execute` it calls `_openImce()`.

## Model schema — `_defineSchema()`

Registers model element **`videoBlock`**, `inheritAllFrom: '$blockObject'`, with allowed
attributes: `src, poster, controls, autoplay, loop, muted, preload, width, height, crossorigin,
htmlStyle`.

## Converters — `_defineConverters()`

- **upcast** `<video>` → `videoBlock`: source URL resolved by `_getSourceUrl()` (first child
  `<source src>`, else `video[src]`); copies `poster, width, height, preload, crossorigin` if
  present; sets boolean flags `controls, autoplay, loop, muted` from `hasAttribute`; maps the
  `style` attribute to `htmlStyle`.
- **dataDowncast** and **editingDowncast** both build the view via `_createVideoView()`
  (`elementToStructure`); editing downcast additionally wraps it with `CKEditor5.widget.toWidget`
  (label `"video widget"`).

## Rendered markup — `_createVideoView()`

Creates a container `<video>` with attributes copied back from the model (`poster/width/height/
preload/crossorigin`, boolean flags rendered as `attr="attr"`, and `htmlStyle` → `style`), then a
single empty child `<source src type>` where `type` is guessed by `_guessMime()`:
`.webm` → `video/webm`, `.ogg`/`.ogv` → `video/ogg`, otherwise `video/mp4`.

## IMCE open + insert flow

- `_openImce()`: reads `window.imceInput`. If missing/no `openImce`, falls back to
  `prompt(Drupal.t('Enter video URL:'))` and inserts that URL. Otherwise it creates a unique
  sendto handler `imceInput['sendtoVideoImce' + Date.now()]` that takes `(File, win)`, reads
  `File.getUrl()`, closes the IMCE window, inserts the video, then deletes the handler. Opens IMCE
  with `imceInput.openImce('imceInput.' + handlerName, 'link')`.
- `_insertVideo(url)`: `editor.model.change` creates a `videoBlock` with `src:url, controls:true,
  preload:'auto', crossorigin:'anonymous', htmlStyle:'max-width:100%; height:auto;'` and
  `insertContent`s it, then refocuses.

## Where filtering happens

The plugin only declares which elements/attributes CKEditor 5 may emit (`.ckeditor5.yml`
`elements`). Stored output is still subject to the text format's own filters (e.g.
`filter_html`). The `src` for `<source>` comes from IMCE (a server file URL) or, in the fallback,
from the editor's `prompt()` input; either way the value is placed as a `src`/`style` attribute
value, not executable markup.
