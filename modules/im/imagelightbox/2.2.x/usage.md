ImageLightbox provides two field formatters that display Image and Media (image) fields as clickable thumbnails which open the full image in a responsive, touch-friendly [imageLightbox.js](https://osvaldas.info/image-lightbox-responsive-touch-friendly) overlay, grouping all images in a field into one swipeable gallery.

---

The module ships the bundled imageLightbox jQuery library (`libraries/imagelightbox.js` + `.css` + `.config.js`) inside the module, so it works out of the box with no external download. It defines two field formatters: `imagelightbox` for core **Image** fields (`ImageLightboxFormatter`, extends `ImageFormatterBase`) and `mediaimagelightbox` for **entity_reference** fields pointing at image Media (`MediaImageLightboxFormatter`, reads the media's `field_media_image`). You choose the formatter on an entity's *Manage display* tab; there is no global settings page (`configure` is null) and no permissions. Per-formatter settings pick a thumbnail image style, a larger "lightbox" image style shown in the overlay, a caption source (image title, alt, or none), and toggles for inline display, light theme, navigation bar and loading animation. Each rendered link carries `class="lightbox" data-imagelightbox="g" data-ilb2-caption="…"`; all links in the field share the `g` group so the lightbox pages through them. The formatter attaches the `imagelightbox/formatter` library and passes its settings to `drupalSettings.imagelightbox`, where `libraries/imagelightbox.config.js` initialises the plugin on every `a[data-imagelightbox="g"]`. Captions are emitted through a Drupal `Attribute` object (auto-escaped). Output is themed by `imagelightbox-formatter.html.twig` (a single `<a href>` wrapping the `<img>`), overridable per theme; the JS config itself can be overridden with a `libraries-override` in a custom theme.

---

- Turn a multi-value Image field into a clickable thumbnail gallery that opens in a lightbox.
- Display a single Image field so the thumbnail opens the full-size image in an overlay.
- Show image Media reference fields in a lightbox via the `mediaimagelightbox` formatter.
- Use a small `thumbnail` image style for the trigger and a `large` style inside the lightbox.
- Serve the original (unstyled) image in the lightbox by choosing "None (original image)".
- Add captions to lightbox images sourced from the image **title** attribute.
- Add captions sourced from the image **alt** attribute instead.
- Suppress captions entirely by setting the caption source to "None".
- Page through all images of a field with the lightbox's left/right arrows and keyboard.
- Provide swipe navigation on touch devices without extra configuration.
- Present thumbnails as inline elements (adds `container-inline`) so they sit side by side.
- Switch the lightbox chrome to a light theme instead of the default dark overlay.
- Show a navigation bar (thumbnail strip) under the lightbox image.
- Display a loading/activity spinner while the next image loads.
- Provide a lightweight, dependency-light gallery without needing Colorbox or a CDN.
- Reuse the bundled library so no `drush`/manual library download is required.
- Override the imageLightbox init options (animation speed, arrows, fullscreen) from a custom theme via `libraries-override`.
- Override `imagelightbox-formatter.html.twig` to wrap the trigger in extra markup.
- Use the formatter inside a View by enabling "Use field template" (or adding the `imagelightbox` class) so links are grouped.
- Give editors a consistent full-image viewing experience across content types by selecting one formatter.
- Combine with responsive image styles to keep thumbnails small while serving high-resolution lightbox images.
