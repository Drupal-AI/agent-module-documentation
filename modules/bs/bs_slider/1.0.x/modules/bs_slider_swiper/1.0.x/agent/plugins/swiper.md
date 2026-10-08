<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Swiper & Swiper Thumbs Gallery plugins

```bash
drush en bs_slider_swiper -y
# Then self-host Swiper at web/libraries/swiper/ (swiper-bundle.min.js + swiper-bundle.min.css)
```

Both plugins extend `BsSliderBase`.

## `swiper` (BsSliderSwiper)

`defaultConfiguration()` mirrors Swiper's own defaults (so unchanged values can be stripped before
sending to JS). It covers scalar parameters (`allowTouchMove`, `direction`, `loop`, `rewind`,
`slidesPerView`, `speed`, …), custom flags prefixed `_` (`_lazyLoading`, `_fullscreen`,
`_show_advanced_options`, `_advanced_configuration`), and module sub-arrays each with an `enabled`
flag: `navigation`, `pagination`, `scrollbar`, `autoplay`, `freeMode`, `keyboard`, plus effect
option groups `fadeEffect`/`coverflowEffect`/`flipEffect`/`cubeEffect`/`cardsEffect` and `effect`.

`buildConfigurationForm()` renders all of these as form widgets under `$form['options']`
(many gated behind the "Show advanced options" checkbox via `#states`). The last field,
`_advanced_configuration`, is a YAML textarea whose values override everything from the UI.

`buildPluginOptionsForm()` adds a required `view_mode` select for the consumer.

### `preprocess()` — how options reach the browser

1. Drops `_show_advanced_options`.
2. If `_advanced_configuration` is set, `Yaml::parse()`s it and `array_merge`s over the options,
   then drops the raw string.
3. Strips options equal to their default, disabled modules, and empty `breakpoints` (payload trim).
4. `convertToPrimitives()` casts numeric strings to int/float and back to bool where the default is
   bool (so Swiper JS receives correctly typed values).
5. Sets `attributes['id']`, `attributes['data-bs-slider'] = 'swiper'`, and
   `attributes['data-bs-slider-options'] = json_encode($options)`.
6. Marks `pagination`/`navigation`/`scrollbar`/`_lazyLoading` template flags for element rendering.

`view()` calls `parent::view()` then attaches `bs_slider_swiper/swiper`. The `data-*` attributes
are emitted through Drupal's `Attribute` object (escaped); config is authored only via the
`administer bs_slider` optionset form.

### JS (`js/swiper.js`)

`Drupal.behaviors.bsSliderSwiper` finds `[data-bs-slider="swiper"]`, guards re-init with
`dataset.bsSliderInit`, `JSON.parse`s the options, converts navigation/pagination/scrollbar CSS
selector strings to elements via `slider.querySelector(...)` (avoids collisions between multiple
sliders), wires the thumbs Swiper when `_thumbs_id` is present, optionally adds fullscreen
click handlers, then `new Swiper(slider, options)`.

### Template (`bs-slider--swiper.html.twig`)

Adds the `swiper` class, renders `swiper-wrapper` / `swiper-slide` items, and conditionally the
`swiper-pagination`, `swiper-button-prev/next` and `swiper-scrollbar` containers; optional
`swiper-lazy-preloader` per slide when `_lazyLoading`.

## `swiper_thumbs_gallery` (BsSliderSwiperThumbsGallery)

`defaultConfiguration()`: `gallery_id`(NULL), `thumbs_id`(NULL) — both required selects listing
existing `swiper` optionsets. `buildPluginOptionsForm()` adds required `gallery_view_mode` +
`thumbnail_view_mode`. `view()` builds two slider arrays (thumbs bound to `thumbs_id`, gallery
bound to `gallery_id`) and attaches `bs_slider_swiper/swiper`; `preprocess()` sets
`thumbs_items`/`gallery_items` and passes `#swiper_thumbs_id` (the thumbs wrapper id) into the
gallery so `BsSliderSwiper::preprocess()` emits `_thumbs_id`, which the JS uses to link them.
Template `bs-slider--swiper-thumbs-gallery.html.twig` renders `gallery_items` then `thumbs_items`.

## Config schema / optionsets

Schema `bs_slider.options.swiper` (a `configuration` mapping). Shipped optionsets:
`swiper_carousel`, `swiper_gallery`, `swiper_thumbs` (`config/install/`).

## Notes

- The Swiper library is **not bundled** — self-host it at `/libraries/swiper/` or the library
  fails to load and sliders won't initialize.
- `Yaml::parse()` here is scalar/array parsing (no PHP object instantiation); advanced config is
  admin-authored (`administer bs_slider`).
