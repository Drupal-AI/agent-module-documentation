<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Per-block settings: Tiny Slider options + shared EBT design options

There is **no global configuration form for ebt_carousel**. All slider settings are per block, stored
in the block's `field_ebt_settings` (`ebt_settings` field type). The widget is
`EbtSettingsCarouselWidget` (`ebt_settings_carousel`), which extends ebt_core's
`EbtSettingsDefaultWidget` — so a carousel block's settings form = the shared EBT design options
**plus** the Tiny Slider options below. Global colour/breakpoint defaults live on ebt_core's own form
at `Administration » Configuration » Content authoring » Extra Block Types (EBT) settings`
(`ebt_core.settings`).

## Tiny Slider options added by this module
Source: `src/Plugin/Field/FieldWidget/EbtSettingsCarouselWidget.php`. These map 1:1 to Tiny Slider's
own options and are read by `js/tiny-slider/tiny-slider.js`.

- **styles** — radios, only `basic` (disabled placeholder for future style sets).
- **image_size** — radios of available image styles; applied to every slide image via
  `preprocess_paragraph`.
- **mode** — `carousel` (slide) or `gallery` (fade, changes all slides at once).
- **axis** — `horizontal` / `vertical`.
- **items** — slides shown in the viewport (default 3).
- **gutter**, **edgePadding** — spacing in px.
- **autoWidth** (checkbox) / **fixedWidth** (px; disabled when autoWidth is on).
- **slideBy** — slides moved per click (default 1).
- **center**, **arrowKeys**, **speed** (ms), **loop** (default on), **autoHeight**.
- **Additional settings** (details): viewportMax, rewind, touch (default on), mouseDrag, swipeAngle,
  preventActionWhenRunning, preventScrollOnTouch (none/auto/force), nested (none/inner/outer),
  freezable, disable, startIndex, useLocalStorage, **nonce** (CSP nonce for the slider's inline style).
- **Responsive settings** (details): per-breakpoint **mobile / tablet / desktop** overrides for
  breakpoint, items, slideBy, gutter, edgePadding. Defaults 576 / 992 / 1200. The JS assembles these
  into Tiny Slider's `responsive` map.
- **Controls settings**: controls (on/off), controlsPosition (top/bottom), **controlsTextPrev** /
  **controlsTextNext** (button labels, default "prev"/"next"), nav (dots, on), navPosition
  (top/bottom), navAsThumbnails.
- **Autoplay settings**: autoplay, autoplayPosition, autoplayTimeout (ms, default 5000),
  autoplayDirection (forward/backward), autoplayTextStart/Stop, autoplayHoverPause, autoplayButton,
  autoplayButtonOutput, autoplayResetOnVisibility.
- **Animate settings**: animateIn (`tns-fadeIn`), animateOut (`tns-fadeOut`), animateNormal,
  animateDelay (ms).

### How they reach the slider
`pass_options_to_javascript` is forced TRUE by the carousel widget. ebt_core's `blockContentView`
publishes the entire settings array to `drupalSettings.ebtCarousel[<blockClass>].options`. The module
JS converts each value: numeric options via `parseInt`, boolean checkboxes to `true/false`, and
free-text/enumerated options via **`Drupal.checkPlain()`** (HTML-escaped) — including `controlsText`,
`autoplayText`, `nonce`, `mode`, `axis`, positions, and animation class names — before calling
`tns(options)`. (Note: `animateIn/Out/Normal` are only forwarded when the stored value is empty, a
quirk in the source condition, so the library's own defaults normally apply.)

## Shared EBT design options (inherited from ebt_core)
Rendered into an inline `<style>` block by ebt_core's `GenerateCSS` and printed as `{{ styles|raw }}`:

- **Margin / Border / Padding box** — numeric px values (validated numeric), border colour (hex-validated),
  border style (select), border radius (select).
- **Background colour** (hex-validated).
- **Background media** — a media-library image or video (image / oembed:video / video_file), with
  background image style (No repeat / Parallax / Cover / Contain / Repeat), optional colour overlay,
  and background position/size (preset selects plus free **custom position / custom size** text fields).
- **Edge to Edge** — stretches the block full-viewport-width (adds `.ebt-edge-to-edge`).
- **Container Max Width** — auto / xxSmall … xxLarge (widths configurable on ebt_core.settings).

Background parallax/video also emit data into `drupalSettings.ebtCore` and attach ebt_core JS
libraries (parallax / vidbg / jQuery mb.YTPlayer) as needed.
