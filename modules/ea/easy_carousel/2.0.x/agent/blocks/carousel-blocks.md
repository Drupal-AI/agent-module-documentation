<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Carousel block plugins

Four block plugins render a selected `carousel` entity. All extend `CarouselBaseBlock`
(`src/Plugin/Block/CarouselBaseBlock.php`), category **"Easy Carousel Blocks"**, and are
placed via core Block Layout (`administer blocks`). `getCacheMaxAge()` returns `0` (never cached).

## Shared behavior (`CarouselBaseBlock`)

- `blockForm()` adds a required `selected_carousel` `entity_autocomplete` (`#target_type => carousel`, `#tags => TRUE`). Subclasses append their own options.
- `blockSubmit()` stores `selected_carousel` and a `last_updated` timestamp (used to build a per-render unique DOM id and cache-buster).
- `build()` loads the carousel; if none selected, renders "No carousel found."
- `getRenderArray()` sets `#theme = carousel_<type>`, attaches `easy_carousel/<type>` library, and pushes the block `$configuration` into `drupalSettings.easy_carousel[<uniqueId>].config` (Drupal JSON-encodes it — safe context).
- `getAllValues()` flattens every slide into a render array item, including resolved media URI/alt/mime, base64 image, external image, computed RGBA background (`opacityToHexValue()`), colors, alignment, title, link, and raw `description`.

## The four types

| Plugin id | `getType()` | Template | Extra block options |
|---|---|---|---|
| `simple_carousel_block` | `simple` | `carousel-simple.html.twig` | `show_controls`, `show_indicators`, `auto_start`, `speed` (ms) |
| `bootstrap_carousel_block` | `bootstrap` | `carousel-bootstrap.html.twig` | controls / indicators / autoplay / interval (Bootstrap 5 data-bs-* attrs) |
| `brands_carousel_block` | `brands` | `carousel-brands.html.twig` | `slide_width`, `margin_between_slides` (infinite marquee) |
| `gallery_carousel_block` | `gallery` | `carousel-gallery.html.twig` | `carousel_height`, `thumbnail_width` |

(See `SimpleCarouselBlock.php` etc. for the exact `defaultConfiguration()` / `blockForm()` of each.)

## Rendering / JS

Each library (`js/simple.js`, `js/bootstrap.custom.js`, `js/brands.js`, `js/gallery.js`) is a
vanilla-JS controller keyed by the DOM `data-id` + `data-last_updated`, reading its config from
`drupalSettings.easy_carousel[cid_lastUpdated].config`. All CSS/JS is bundled in the module — no CDN.
The Bootstrap block ships a customized local Bootstrap 5 build (`js/bootstrap.custom.js`,
`css/bootstrap.custom.min.css`); the full `bootstrap.bundle.min.js` / `bootstrap.min.css` are present
but commented out in `easy_carousel.libraries.yml`.
