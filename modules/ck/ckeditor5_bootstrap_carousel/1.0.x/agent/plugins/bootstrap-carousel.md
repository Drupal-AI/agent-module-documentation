<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor 5 plugin: bootstrapCarousel

Source: `ckeditor5_plugins/bootstrapCarousel/src/` (TypeScript), built to `js/build/bootstrapCarousel.js`.
Declared to Drupal by `ckeditor5_bootstrap_carousel.ckeditor5.yml` under the id
`ckeditor5_bootstrap_carousel_bootstrapCarousel`.

## Registration (ckeditor5.yml)

- `ckeditor5.plugins`: `bootstrapCarousel.BootstrapCarousel`,
  `bootstrapCarousel.BootstrapCarouselClipboardPipeline`,
  `bootstrapCarousel.BootstrapCarouselGeneralHtmlSupport`.
- `ckeditor5.config.bootstrapCarousel.toolbarItems`: `bootstrapCarouselItemOptions`,
  `bootstrapCarouselItemLabel` (the per-item toolbar; overridable — see below).
- `drupal.toolbar_items.bootstrapCarousel.label`: **Carousel** (the main toolbar button).
- `drupal.library`: `ckeditor5_bootstrap_carousel/bootstrapCarousel.editor`;
  `drupal.admin_library`: `.../bootstrapCarousel.admin`.
- `drupal.conditions.filter`: `filter_bootstrap_carousel` — the plugin only appears when that filter
  is enabled on the text format.
- `drupal.elements`: the HTML this plugin adds to the format's allowed tags:
  `<bootstrap-carousel-controls>`, `<bootstrap-carousel-indicators>`, `<div>`, and one
  `<div class="active carousel carousel-caption carousel-indicators carousel-inner carousel-item carousel-fade slide" data-carousel-id data-carousel-item-label data-bs-ride data-bs-keyboard data-bs-interval data-bs-pause data-bs-wrap>`.

## Source layout (src/)

- `index.ts` — exports the three plugins listed above.
- `bootstrapcarousel.ts` — the top-level plugin wiring editing + UI + keyboard.
- `bootstrapcarouselediting.ts` — model/schema + upcast/downcast converters.
- `bootstrapcarouselui.ts` — toolbar buttons and the item toolbar.
- `bootstrapcarouselconfig.ts` — config types + option maps (see attributes below).
- `bootstrapcarouselkeyboard.ts`, `bootstrapcarouselevents.ts`, `bootstrapcarouselutils.ts`,
  `bootstrapcarouseltypes.ts`, `augmentation.ts`, `global.d.ts` — support code/types.
- `commands/` — `insertbootstrapcarouselcommand`, `insertbootstrapcarouselitemcommand`,
  `modifybootstrapcarouselitemcommand`, `removebootstrapcarouselitemcommand`.
- `integration/bootstrapcarouselclipboardpipeline.ts` — copy/paste handling.
- `integration/bootstrapcarouselgeneralhtmlsupport.ts` — optional integration with core GHS; only
  preserves attributes GHS/`DataFilter` already permit (no-op if GHS is absent).
- `ui/itemlabelformview.ts` — the slide-label input view.

## Model attributes (bootstrapcarouselconfig.ts)

- Carousel: `bootstrapCarouselId`, `bootstrapCarouselStyle`.
  - `bootstrapCarouselStyle` values `regular` (default) | `fade`; `fade` maps to CSS class
    `carousel-fade` (`styleOptions`).
- Item: `bootstrapCarouselItemLabel` (string), `bootstrapCarouselItemActive`.
  - `bootstrapCarouselItemActive` values `true`→class `active` | `false` (`itemActiveOptions`).

## Saved markup

The editor emits a `<div class="carousel ...">` with `data-carousel-id` (and per-item
`data-carousel-item-label`, `active`), plus empty `<bootstrap-carousel-indicators>` /
`<bootstrap-carousel-controls>` placeholders. The `data-bs-*` runtime attributes and the actual
indicator/control buttons are added later by the render filter, not stored — see
[`../filters/carousel-enabler.md`](../filters/carousel-enabler.md).

## Extending the item toolbar

Add a custom CKEditor 5 plugin and append its button name to
`editor.config.bootstrapCarousel.toolbarItems` (the `ckeditor5.config` block above), e.g. via a
`hook_editor_js_settings_alter()` or your own text-editor config. No PHP API is exposed by this
module beyond the filter.
