<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Canvas Palette (canvas_palette) — agent index

A kit of ~39 **Single Directory Components (SDC)** for the **Canvas / Experience Builder**
page builder (`drupal/canvas`), inspired by the EPT paragraph suite. Components are placed and
edited in the Canvas editor and render on the published page. Package `Custom`. License
GPL-2.0-or-later. Core `^10.3 || ^11`. Version 1.0.3.

- **Dependencies (info.yml):** `canvas:canvas`, `drupal:image`, `drupal:views`, `webform:webform`.
  Composer also pulls ~10 front-end libraries (Coloris, GLightbox, countUp.js, Accordion, vidbg,
  jquery.mb.YTPlayer, parallax.js, tiny-slider, sticky-js, Splide) into `web/libraries/*`.
- **No** permissions file, **no** config settings form/route, **no** config schema, **no** Drush,
  **no** custom entity/field/plugin *type*. It defines SDC components + editor/rendering hooks.

## Solution docs

- **Component catalogue, the Section design wrapper, conventions, adding styles** →
  [components/catalogue.md](components/catalogue.md)
- **PHP integration: editor form alters, plugin-manager swap, slot defaults, Canvas-page base
  fields, page templates, Twig extensions, the one route** →
  [integration/php-api.md](integration/php-api.md)

## What it actually provides (from source)

- **~39 SDC components** under `components/<id>/` (e.g. `section`, `columns`, `text`,
  `basic_button`, `cta`, `hero`, `modal`, `webform_popup`, `image`, `images`, `image_gallery`,
  `video`, `video_gallery`, `accordion`, `tabs`, `carousel`, `slider`, `sticky_menu`, `quote`,
  `stats`, `counter`, `countdown`, `tiles`, `timeline`, `webform`, `views`, plus their `*_item`
  children). Each is `<id>.component.yml` + `<id>.twig` + optional co-located `<id>.css`/`<id>.js`.
- **1 route** — `canvas_palette.media_dimensions` (`GET /canvas-palette/media/{media}/dimensions`,
  `_format: json`), gated by permission `edit canvas_page`; controller
  `Controller\ImageDimensionsController::dimensions()` returns `{width,height}` for the Image
  component's editor JS.
- **3 Twig extensions** (`canvas_palette.services.yml` → `src/Twig/`): `canvas_palette_image_style_url()`,
  `canvas_palette_view()`, `canvas_palette_webform()` / `canvas_palette_webform_url()`.
- **1 service provider** `CanvasPaletteServiceProvider` swaps `plugin.manager.sdc` to
  `Plugin\CanvasPaletteComponentPluginManager` (injects 36 grid `cell_N` slots into `section`).
- **1 pre-render** `Render\SlotImageDefaults` (TrustedCallback) propagating container image
  defaults to slotted item children.
- **2 base fields** added to the `canvas_page` entity: `canvas_palette_page_template` and
  `canvas_palette_background_color` (installed in `canvas_palette.install`).
- **10 asset libraries** (`canvas_palette.libraries.yml`) — editor helpers (design_box,
  color_picker, range_slider, image_dimensions, container_width, editor_layers…) plus the
  third-party front-end libs, most attached on demand.
- **1 alter hook** it *provides*: `hook_canvas_palette_page_templates_alter()`
  (`canvas_palette.api.php`). **1 config/optional** entity: `canvas.pattern.accordion.yml`.

The bulk of the PHP is in `canvas_palette.module` (editor + rendering integration); see
[integration/php-api.md](integration/php-api.md). Component authoring conventions live in
[components/catalogue.md](components/catalogue.md).
