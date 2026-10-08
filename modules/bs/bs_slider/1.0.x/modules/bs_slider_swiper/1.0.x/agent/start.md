<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# BS Slider Swiper (bs_slider_swiper) — agent index

Library submodule of **BS Slider**. Provides Swiper.js-backed `BsSlider` plugins. Package `Media`.
Depends on **`bs_slider`**. Core `^9.2 || ^10 | ^11`. No permissions. Version 1.0.0-alpha8.

- **The two plugins, option handling, the JS init and thumbs linking** →
  [plugins/swiper.md](plugins/swiper.md)

## What it provides (from source)

- Plugin **`swiper`** (`src/Plugin/BsSlider/BsSliderSwiper.php`) — a large subset of Swiper
  parameters (touch, direction, loop, effects, and the `navigation`/`pagination`/`scrollbar`/
  `autoplay`/`freeMode`/`keyboard` module fieldsets) plus custom flags `_lazyLoading`,
  `_fullscreen`, `_show_advanced_options` and a YAML `_advanced_configuration` override. Serializes
  cleaned options to `data-bs-slider-options` and attaches `bs_slider_swiper/swiper`.
- Plugin **`swiper_thumbs_gallery`** (`…/BsSliderSwiperThumbsGallery.php`) — links a main Swiper
  (`gallery_id`) to a synchronized thumbnails Swiper (`thumbs_id`), both existing `swiper`
  optionsets.
- `js/swiper.js` — `Drupal.behaviors.bsSliderSwiper`: parses the data attribute, resolves
  navigation/pagination/scrollbar CSS selectors to elements, wires thumbs, optional fullscreen,
  then `new Swiper(slider, options)`.
- Templates `templates/bs-slider--swiper.html.twig`, `bs-slider--swiper-thumbs-gallery.html.twig`
  (`base hook => bs_slider`). Library `bs_slider_swiper/swiper` (self-hosted `/libraries/swiper/`).
- Config schema `bs_slider.options.swiper`. Shipped optionsets in `config/install/`:
  `swiper_carousel`, `swiper_gallery`, `swiper_thumbs`.
- No routes, permissions or services of its own.

Parent framework → [../../../../agent/start.md](../../../../agent/start.md).
