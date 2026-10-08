<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor 5 Bootstrap Carousel (ckeditor5_bootstrap_carousel) — agent index

Insert and edit a **Bootstrap 5 carousel** inside CKEditor 5. Version **1.0.0-alpha1** (`1.0.x`).
Core `^10.6 || ^11.3`. License GPL-2.0-or-later.

## What it provides

- **CKEditor 5 plugin** `bootstrapCarousel` (built TS → `js/build/bootstrapCarousel.js`), exporting
  three CKEditor plugins: `BootstrapCarousel`, `BootstrapCarouselClipboardPipeline`,
  `BootstrapCarouselGeneralHtmlSupport` (see `ckeditor5_plugins/bootstrapCarousel/src/index.ts`).
  Declared to Drupal in `ckeditor5_bootstrap_carousel.ckeditor5.yml`; adds a "Carousel" toolbar
  button and per-item toolbar items (`bootstrapCarouselItemOptions`, `bootstrapCarouselItemLabel`).
- **Text-format filter** `filter_bootstrap_carousel` ("Carousel enabler") —
  `src/Plugin/Filter/BootstrapCarousel.php`, a `TYPE_TRANSFORM_IRREVERSIBLE` filter that at render
  time injects Bootstrap `data-bs-*` attributes and generates indicator/control buttons.
- **Libraries** (`*.libraries.yml`): `bootstrapCarousel.editor` (CKEditor JS + editor CSS, depends
  on `core/ckeditor5`) and `bootstrapCarousel.admin` (admin CSS).

## Dependencies

- Drupal module: `ckeditor5` (core). Composer: only `drupal/core`.
- **No** Bootstrap library is bundled or loaded — the front-end **theme must already ship Bootstrap 5
  CSS + JS** for carousels to animate. Nothing is fetched from a CDN by this module.

## Not provided

No permissions file, no config schema/config-install, no routing, no services, no `.module`/`.install`,
no submodules, no Drush commands, no settings route (`configure: null`). Configuration is per text
format at `/admin/config/content/formats`.

## Solution docs

- CKEditor 5 plugin + toolbar/model — [`agent/plugins/bootstrap-carousel.md`](plugins/bootstrap-carousel.md)
- Render filter (Carousel enabler) — [`agent/filters/carousel-enabler.md`](filters/carousel-enabler.md)
- Install & enable on a text format — [`agent/config/setup.md`](config/setup.md)
