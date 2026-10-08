<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bootstrap Carousel & Gallery Grid plugins

```bash
composer require drupal/bs_slider drupal/bs_lib
drush en bs_slider_bootstrap -y
```

Enabling installs four default optionsets (below). Both plugins extend `BsSliderBase`.

## `bootstrap_carousel` (BsSliderBootstrapCarousel)

`defaultConfiguration()`: `controls`(FALSE), `indicators`(FALSE), `captions`(FALSE),
`crossfade`(FALSE), `interval`(5000), `keyboard`(TRUE), `pause`('hover'), `ride`('carousel'),
`wrap`(TRUE). The config form exposes each as a checkbox/number/select under `$form['options']`
(schema `bs_slider.options.bootstrap_carousel`).

`buildPluginOptionsForm()` adds a required `view_mode` select for the consuming formatter/behavior
(only when the consumer exposes `target_field_view_modes`).

`preprocess()` sets `$variables['items']` and adds wrapper attributes:
`data-interval`, `data-keyboard`, `data-pause` (`hover`/`false`), `data-ride`, `data-wrap` — all
written through Drupal's `Attribute` object (escaped). Template
`bs-slider--bootstrap-carousel.html.twig` attaches `bs_lib/carousel`, builds `carousel-indicators`,
`carousel-inner` items (first is `active`), and optional prev/next controls with `sr-only` labels.
The Bootstrap JS itself lives in the `bs_lib` module.

## `bootstrap_gallery_grid` (BsSliderBootstrapGalleryGrid)

`defaultConfiguration()`: `layout`('grid'), `column_count`('2-3-4'), `gutter`('medium'),
`bs_slider_id`(NULL). Config form: `layout` (grid|column), `column_count`
(1-2-2 … 3-6-12, cols per small/medium/large screen), `gutter` (none/small/medium/large), and a
**required** `bs_slider_id` select listing existing `bootstrap_carousel` optionsets
(`manager->getAllOptionSetByProperties(['plugin_id' => 'bootstrap_carousel'])`) — that optionset
renders the full/overlay view. Schema `bs_slider.options.bootstrap_gallery`.

`buildPluginOptionsForm()` adds required `thumbnail_view_mode` + `item_view_mode` selects.

`view()` splits the built items into thumbnail items (rendered with `thumbnail_view_mode`) and
gallery items (rendered with `item_view_mode`), rebuilds `$build` as the thumbnail slider array,
and attaches `$build['gallery_items']` as a second slider array bound to the `bs_slider_id`
optionset. `preprocess()` exposes `items`, `gallery_items`, `options`. Template
`bs-slider--bootstrap-gallery-grid.html.twig` attaches `bs_lib/carousel`,
`bs_slider_bootstrap/gallery`, `bs_slider_bootstrap/layout`, renders the thumbnail grid
(`bs-slider--layout--{layout}`, `--columns--{column_count}`, `--gutter--{gutter}` classes) and a
gallery overlay with a close button.

## Assets (`bs_slider_bootstrap.libraries.yml`)

- `gallery` → `css/gallery.css`, `js/gallery.js`; depends on `body_scroll_lock`, `core/drupal`,
  `core/jquery`, `core/once`.
- `layout` → `css/layout.css`.
- `body_scroll_lock` → bundled `js/bodyScrollLock.min.js` (body-scroll-lock **2.6.1**, MIT;
  `remote: https://github.com/willmcpo/body-scroll-lock`) — locks page scroll while the gallery
  overlay is open.

## Shipped optionsets (`config/install/`)

`bs_slider.configuration.default_bootstrap_carousel`,
`…default_bootstrap_gallery_carousel`, `…default_bootstrap_gallery_column`,
`…default_bootstrap_gallery_grid` — ready-to-use starting points selectable in formatters.

## Notes

- All options are set through the parent optionset form, gated by `administer bs_slider`; the
  `data-*` attributes and CSS classes derive from that admin config.
- Requires `bs_lib` — without it the `bs_lib/carousel` attach fails and the carousel won't init.
