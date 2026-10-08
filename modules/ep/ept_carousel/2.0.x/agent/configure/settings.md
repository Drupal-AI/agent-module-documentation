<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `ept_settings_carousel` widget — Tiny Slider options

`Drupal\ept_carousel\Plugin\Field\FieldWidget\EptSettingsCarouselWidget` (annotation id
`ept_settings_carousel`, field type `ept_settings`). Extends ept_core's `EptSettingsDefaultWidget`,
so it inherits the whole EPT **Design options** panel (ID/anchor, margin/border/padding boxes,
border color/style/radius, background color, background media image/video + overlay, edge-to-edge,
container width, spacing) and adds the Tiny Slider controls on top. There is **no module settings
page** — all configuration is per-paragraph, on the paragraph edit form's **Settings** tab (set as
the `field_ept_settings` widget in the default form display).

The widget's `formElement()`
(`src/Plugin/Field/FieldWidget/EptSettingsCarouselWidget.php:26`) first sets a hidden
`pass_options_to_javascript = TRUE`, then adds the fields below. Values are stored on the paragraph's
`field_ept_settings` under `ept_settings`; because `pass_options_to_javascript` is TRUE, ept_core's
`hook_ENTITY_TYPE_view` copies the whole `ept_settings` array to
`drupalSettings.eptCarousel['paragraph-id-<id>'].options` at view time — see
[../theme/rendering.md](../theme/rendering.md).

## Top-level options (under `ept_settings`)

| `ept_settings` key | `#type` | Default | Tiny Slider meaning |
|---|---|---|---|
| `styles` | radios (`basic`) | `basic` | Predefined style set. **Disabled** — only one option exists; drives the `ept-carousel-basic` wrapper class + `ept_carousel/basic` CSS. |
| `image_size` | radios (image styles + "- Select image size -") | `''` | Image style applied to each slide image at render time (only shown if image styles exist). |
| `mode` | radios (`carousel`, `gallery`) | `carousel` | `carousel` slides sideways; `gallery` fades and changes all slides at once. |
| `axis` | radios (`horizontal`, `vertical`) | `horizontal` | Slider axis. |
| `items` | number | `3` | Slides visible in the viewport. If slides ≤ items the slider is not initialised. |
| `gutter` | number | `0` | Space between slides (px). |
| `edgePadding` | number | `0` | Space on the outside (px). |
| `autoWidth` | checkbox | (unset) | Each slide uses its natural inline-block width. Carries class `ept-autowidth-field`. |
| `fixedWidth` | textfield | `''` | Fixed slide width; disabled (via `#states`) when `autoWidth` is checked. |
| `slideBy` | number | `1` | Slides moved per "click". |
| `center` | checkbox | (unset) | Center the active slide in the viewport. |
| `arrowKeys` | checkbox | (unset) | Allow left/right arrow keys to switch slides. |
| `speed` | number | `300` | Slide animation speed (ms). |
| `loop` | checkbox | `1` | Move through all slides seamlessly. |
| `autoHeight` | checkbox | (unset) | Container height follows each slide's height. |

## Additional settings — under `additional` (details, collapsed)

| `ept_settings['additional']` key | `#type` | Default | Meaning |
|---|---|---|---|
| `viewportMax` | number | `''` | Max viewport width for Fixed/Auto width. |
| `rewind` | checkbox | (unset) | Jump to the opposite edge at the first/last slide. |
| `touch` | checkbox | `1` | Input detection for touch devices. |
| `mouseDrag` | checkbox | (unset) | Change slides by dragging. |
| `swipeAngle` | number | `15` | Swipe/drag ignored outside this angle range. |
| `preventActionWhenRunning` | checkbox | (unset) | Block the next transition while transforming. |
| `preventScrollOnTouch` | radios (`none`,`auto`,`force`) | `none` | Prevent page scroll on touchmove. |
| `nested` | radios (`none`,`inner`,`outer`) | `none` | Relationship between nested sliders. |
| `freezable` | checkbox | (unset) | Freeze the slider when all slides fit one page. |
| `disable` | checkbox | (unset) | Disable the slider. |
| `startIndex` | number | `0` | Initial slide index. |
| `useLocalStorage` | checkbox | (unset) | Cache browser-capability vars in `localStorage`. |
| `nonce` | textfield | `''` | Nonce for the inline style tag (CSP without `unsafe-inline`). |

## Responsive settings — under `responsive` (details → `mobile` / `tablet` / `desktop`)

Each of the three sub-groups has the same keys: `breakpoint`, `items`, `slideBy`, `gutter`,
`edgePadding`. Default breakpoints: **mobile 576**, **tablet 992**, **desktop 1200**; the other four
default to `''`. The JS assembles these into Tiny Slider's `responsive: { <breakpoint>: {...} }` map.

## Controls — under `controls` (details, collapsed)

| `ept_settings['controls']` key | `#type` | Default | Meaning |
|---|---|---|---|
| `controls` | checkbox | `1` | Show prev/next buttons. |
| `controlsPosition` | radios (`top`,`bottom`) | `top` | Controls position. |
| `controlsTextPrev` | textfield | `prev` | Prev button text/markup. |
| `controlsTextNext` | textfield | `next` | Next button text/markup. |
| `nav` | checkbox | `1` | Show nav dots. |
| `navPosition` | radios (`top`,`bottom`) | `bottom` | Nav position. |
| `navAsThumbnails` | checkbox | (unset) | Treat dots as thumbnails. |

## Autoplay — under `autoplay` (details, collapsed)

| `ept_settings['autoplay']` key | `#type` | Default | Meaning |
|---|---|---|---|
| `autoplay` | checkbox | (unset) | Auto-advance slides. |
| `autoplayPosition` | radios (`top`,`bottom`) | `top` | Autoplay control position. |
| `autoplayTimeout` | number | `5000` | Time between slides (ms). |
| `autoplayDirection` | radios (`forward`,`backward`) | `forward` | Direction of movement. |
| `autoplayTextStart` | number* | `start` | Autoplay "start" button text. |
| `autoplayTextStop` | number* | `stop` | Autoplay "stop" button text. |
| `autoplayHoverPause` | checkbox | (unset) | Pause on mouseover. |
| `autoplayButton` | number* | `''` | Custom autoplay button/selector. |
| `autoplayButtonOutput` | checkbox | `1` | Output default autoplay button markup. |
| `autoplayResetOnVisibility` | checkbox | `1` | Pause when the page is hidden. |

\* `autoplayTextStart` / `autoplayTextStop` / `autoplayButton` are declared `#type => number` in the
widget even though their defaults/uses are strings — a source quirk; the values still reach the JS as
`autoplayText` / `autoplayButton`.

## Animate — under `animate` (details, collapsed)

| `ept_settings['animate']` key | `#type` | Default | Meaning |
|---|---|---|---|
| `animateIn` | textfield | `tns-fadeIn` | Intro animation class (gallery mode). |
| `animateOut` | textfield | `tns-fadeOut` | Outro animation class. |
| `animateNormal` | textfield | `tns-fadeOut` | Default animation class (description says `tns-normal`). |
| `animateDelay` | number | `''` | Delay between gallery animations (ms). |

Note: `js/tiny-slider/tiny-slider.js` only forwards `animateIn`/`animateOut`/`animateNormal` when the
stored value is the empty string (`… != undefined && … == ''`), so in practice these three text
values never reach `tns()` — a JS quirk worth knowing if animate classes appear ignored.

## `massageFormValues()`

Only guarantees each delta has an `ept_settings` key: `$value += ['ept_settings' => []];`
(`EptSettingsCarouselWidget.php:602`). No transformation or filtering happens here.

## Reading / writing in PHP

The value is a nested array under `field_ept_settings…ept_settings`. Example — a 3-up horizontal
carousel with dots and autoplay:

```php
$paragraph->field_ept_settings->ept_settings = [
  'pass_options_to_javascript' => TRUE,
  'styles'    => 'basic',
  'image_size'=> 'medium',        // any image style machine name, or '' for original
  'mode'      => 'carousel',
  'axis'      => 'horizontal',
  'items'     => 3,
  'gutter'    => 10,
  'slideBy'   => 1,
  'speed'     => 300,
  'loop'      => 1,
  'controls'  => ['controls' => 1, 'nav' => 1, 'navPosition' => 'bottom',
                  'controlsTextPrev' => 'prev', 'controlsTextNext' => 'next'],
  'autoplay'  => ['autoplay' => 1, 'autoplayTimeout' => 5000, 'autoplayHoverPause' => 1],
  'responsive'=> ['mobile' => ['breakpoint' => 576, 'items' => 1]],
  // 'design_options' => [...]  // inherited ept_core keys (margins/background/etc.)
];
$paragraph->save();
```

## Who can set these

Anyone with permission to edit the paragraph (i.e. edit the host content — a privileged authoring
task). The numeric/checkbox/radios/select controls are constrained input; the free-text fields
(`fixedWidth`, `controlsTextPrev`, `controlsTextNext`, `nonce`, `animateIn/Out/Normal`,
`autoplayButton`) are passed through `Drupal.checkPlain()` in `js/tiny-slider/tiny-slider.js` before
Tiny Slider receives them, and the inherited ept_core design values are rendered as an inline
`<style>` via ept_core's `GenerateCSS`, which `Html::escape()`s each value.
