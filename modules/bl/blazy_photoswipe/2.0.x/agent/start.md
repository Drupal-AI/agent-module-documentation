# Blazy PhotoSwipe — agent index

Registers **PhotoSwipe** as a Blazy lightbox. No formatter, no field type, no configure
route (`configure: null`), no permissions, no Drush, no plugins. It only alters Blazy via
hooks. Requires the **blazy** module (>= 3.x) and the PhotoSwipe JS library under
`/libraries/photoswipe`.

- **Turn PhotoSwipe on for a display / where the setting lives (Media switch, PS4 vs PS5)** →
  [configure/media-switch.md](configure/media-switch.md)
- **Customise the options passed to the PhotoSwipe JS library** →
  [hooks/js-options.md](hooks/js-options.md)

Key facts:
- A formatter opens the lightbox when its component `settings.media_switch` is `photoswipe`
  (the **"Image to PhotoSwipe"** option). The `photoswipe` option is injected into every
  Blazy-based formatter's Media switch by `hook_blazy_lightboxes_alter()`.
- PhotoSwipe major is chosen in **Blazy's own** settings form (`/admin/config/media/blazy`,
  route `blazy.settings`) and stored as an integer at `blazy.settings` → `extras.photoswipe`
  (value `5` = PhotoSwipe 5; absent/empty = PhotoSwipe 4).
- Runtime options reach the browser via `drupalSettings.photoswipe.options`, alterable with
  `hook_blazy_photoswipe_js_options_alter()`.
