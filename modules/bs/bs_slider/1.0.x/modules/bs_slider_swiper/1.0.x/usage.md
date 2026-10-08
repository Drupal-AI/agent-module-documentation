Adds Swiper.js slider plugins to BS Slider, including a synchronized thumbnails gallery.

---

`bs_slider_swiper` is a library submodule of BS Slider. It registers the `swiper` `BsSlider`
plugin — exposing a large subset of the Swiper.js API through the UI plus a YAML "advanced
configuration" override — and the `swiper_thumbs_gallery` plugin, which links a main Swiper to a
synchronized thumbnail Swiper. Options are serialized to a `data-bs-slider-options` attribute and
read by `js/swiper.js`, which instantiates `new Swiper(el, options)`. The Swiper library itself is
expected to be self-hosted under `/libraries/swiper/`. Enable it, create an optionset of type
"Swiper" (or "Swiper Thumbs Gallery"), and reference it from a formatter, Views style or Paragraph.

---

- Build a Swiper carousel from a media/image or text field.
- Show pagination bullets, fraction, progress bar or custom pagination.
- Add navigation arrows and/or a draggable scrollbar.
- Autoplay with a configurable delay, pause-on-hover and stop-on-last-slide.
- Loop or rewind at the ends of the slider.
- Show multiple slides per view and per group with configurable spacing.
- Apply fade, cube, coverflow, flip or cards transition effects.
- Enable keyboard control, free mode, centered slides or vertical direction.
- Lazy-load slide images (native browser lazy loading).
- Enable click-to-fullscreen for slides.
- Set any Swiper parameter not exposed in the UI via the YAML advanced-configuration field.
- Build a thumbnails gallery where clicking a thumbnail drives the main Swiper.
- Render gallery items and thumbnail items in different view modes.
- Provide responsive breakpoints via advanced YAML configuration.
- Theme the Swiper markup per optionset via template suggestions.
- Reuse existing Swiper optionsets as the gallery/thumbs parts of a thumbs gallery.
