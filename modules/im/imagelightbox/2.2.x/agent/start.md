# ImageLightbox — agent index

Two field formatters that render Image and Media(image) fields as thumbnails opening a
responsive [imageLightbox.js](https://osvaldas.info) overlay. The JS/CSS library is bundled
inside the module (`libraries/`), so it works with no download. No global config page
(`configure` null), no permissions, no Drush. Depends on core `image`. All images in a field
form one lightbox group (`data-imagelightbox="g"`).

- **The two formatters, every setting, image styles, captions, `drupalSettings`, JS/theme override** →
  [configure/formatters.md](configure/formatters.md)

Key facts:
- `imagelightbox` formatter → core **Image** fields (`ImageLightboxFormatter`).
- `mediaimagelightbox` formatter → **entity_reference** fields to image **Media** (reads `field_media_image`).
- Settings live in the `entity_view_display` component (`content.<field>.settings`); no config schema shipped.
- Formatter attaches `imagelightbox/formatter` and exposes settings at `drupalSettings.imagelightbox`;
  `libraries/imagelightbox.config.js` calls `.imageLightbox()` on `a[data-imagelightbox="g"]`.
- Template `imagelightbox-formatter.html.twig` = `<a {{ link_attributes }} href="{{ url }}">{{ image }}</a>`.
