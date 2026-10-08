# Owl Carousel — agent index

Integrates the **OwlCarousel2** jQuery slider. Two integrations sharing one option set: a field
formatter for image fields and a Views style. **No settings page, no `configure` route, no config
schema, no permissions.** Configuration lives in each field-display / view. Requires the
third-party owlcarousel2 JS library in `/libraries`.

- **The field formatter & Views style, and every carousel option** →
  [configure/carousel.md](configure/carousel.md)
- **Install the JS library (Drush commands, requirement check)** → [drush/library.md](drush/library.md)
- **Templates, wrapper classes, and the `data-settings` attribute** → [theming/templates.md](theming/templates.md)

Key facts:
- Field formatter id **`owlcarousel_field_formatter`** (image fields). Views style id
  **`owlcarousel`** (theme `owlcarousel_views`).
- Shared options (`Drupal\owlcarousel\OwlCarouselGlobal::defaultSettings()`): `items`, `margin`,
  `nav`, `autoplay`, `autoplayHoverPause`, `loop`, `dots`, `rtl`, `dimensionMobile`/`itemsMobile`,
  `dimensionDesktop`/`itemsDesktop`. Field formatter also has `image_style`, `image_link`.
- Settings are JSON-encoded into a `data-settings` attribute on an `.owl-carousel.owl-theme`
  wrapper; `js/owlcarousel.js` initialises the plugin from it.
- Library: `/libraries/owlcarousel2/dist/owl.carousel.js`. `hook_requirements` warns if missing;
  Drush `owlcarousel:download` (alias `oc:dl`) installs it.
- Depends on core `field` + `image`.
