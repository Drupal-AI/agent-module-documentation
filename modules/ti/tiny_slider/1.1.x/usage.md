Tiny Slider integrates the vanilla-JS Tiny Slider 2 carousel library into Drupal, providing a **field formatter** and a **Views style** that render images/entities/rows as a configurable slider (autoplay, navigation, controls, thumbnails, responsive breakpoints).

---

The module ships two display plugins. The field formatter `tiny_slider_field_formatter`
("Tiny Slider Carousel") applies to `image` and `entity_reference` fields and turns their items
into a slider on *Manage display*; it also offers image-style and image-link options. The Views
style `tiny_slider` ("TinySlider") renders each view row as a slide. Both share the same large set
of slider options (from `TinySliderGlobal::defaultSettings()` / `_tiny_slider_default_settings()`):
`items`, `gutter`, `mode` (carousel/gallery), `nav`, `navPosition`, `navAsThumbnails`, `autoplay`
+ `autoplayHoverPause`/`autoplayButtonOutput`/`autoplayPosition`/`autoplayTextStart`/`autoplayTextStop`,
`controls` + positions/labels, `slideBy`, `arrowKeys`, `mouseDrag`, `loop`, `center`, `speed`, plus
mobile/desktop responsive item counts. An **advanced mode** (`advancedMode` + `configJson`) lets you
paste a raw Tiny Slider JSON options object that overrides the individual settings. Settings are
serialized into a `data-settings` attribute and initialized by `js/tiny_slider.js`. The actual
Tiny Slider JS/CSS library is **not bundled** — it must be downloaded to `/libraries/tiny-slider`
(there is a Drush command `tiny_slider:download` / `ts:dl`, or download it manually); a runtime
requirement warns if it is missing. Formatter settings persist in the `entity_view_display` config;
Views style options in the view config entity.

---

- Turn a multi-value image field into an autoplaying homepage hero carousel.
- Display a photo gallery field as a swipeable slider with thumbnail navigation.
- Render an entity-reference field (e.g. referenced products) as a carousel of cards.
- Build a "featured articles" slider from a View using the TinySlider style.
- Show client logos in a continuously looping, auto-advancing strip.
- Create a testimonials slider with prev/next controls and custom button labels.
- Configure different slide counts for mobile vs desktop via the responsive options.
- Enable mouse-drag / touch swiping on an image carousel.
- Use gallery mode (fade) instead of carousel mode for a hero banner.
- Add dot navigation positioned above or below the slider.
- Use images as thumbnail navigation (`navAsThumbnails`) for a product gallery.
- Set autoplay speed and pause-on-hover for a rotating promo banner.
- Center the active slide for a focus-style carousel.
- Paste a raw Tiny Slider JSON config (advanced mode) for options the form does not expose.
- Apply an image style to slider images and link each image to its content or file.
- Slide by page vs by single item using the `slideBy` option.
- Enable keyboard arrow-key navigation for accessibility.
- Loop a small set of slides infinitely.
- Build a related-content carousel at the bottom of article pages via Views.
- Install the Tiny Slider JS library with `drush tiny_slider:download` (alias `ts:dl`).
- Provide start/stop autoplay buttons with custom text.
- Control transition speed (ms) for smoother or snappier sliding.
- Reuse one configured slider style across several content types' image fields.
