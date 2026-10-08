<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# BS Slider Bootstrap (bs_slider_bootstrap) — agent index

Library submodule of **BS Slider**. Provides two `BsSlider` plugins backed by Bootstrap's
carousel. Package `Media`. Depends on **`bs_lib`** (Bootstrap carousel assets) and **`bs_slider`**.
Core `^9.2 || ^10 | ^11`. No permissions. Version 1.0.0-alpha8.

- **The two plugins, their options, templates, assets and shipped optionsets** →
  [plugins/carousel-and-gallery.md](plugins/carousel-and-gallery.md)

## What it provides (from source)

- Plugin **`bootstrap_carousel`** (`src/Plugin/BsSlider/BsSliderBootstrapCarousel.php`) — a
  Bootstrap Carousel with options controls/indicators/captions/crossfade/interval/keyboard/pause/
  ride/wrap. Emits `data-*` attributes on the wrapper; attaches `bs_lib/carousel`.
- Plugin **`bootstrap_gallery_grid`** (`…/BsSliderBootstrapGalleryGrid.php`) — thumbnail grid or
  column layout that opens a Bootstrap Carousel full view; options layout/column_count/gutter/
  `bs_slider_id` (an existing `bootstrap_carousel` optionset for the full view).
- Templates `templates/bs-slider--bootstrap-carousel.html.twig`,
  `bs-slider--bootstrap-gallery-grid.html.twig` (both `extends "bs-slider.html.twig"`,
  `base hook => bs_slider` via `bs_slider_bootstrap_theme()`).
- Libraries (`bs_slider_bootstrap.libraries.yml`): `gallery` (css/js + body_scroll_lock),
  `layout` (css), `body_scroll_lock` (bundled body-scroll-lock 2.6.1, MIT).
- Config schema `bs_slider.options.bootstrap_carousel`, `bs_slider.options.bootstrap_gallery`.
- Shipped optionsets in `config/install/`: `default_bootstrap_carousel`,
  `default_bootstrap_gallery_carousel`, `default_bootstrap_gallery_column`,
  `default_bootstrap_gallery_grid`.
- No routes, no permissions, no services of its own.

Parent framework → [../../../../agent/start.md](../../../../agent/start.md).
