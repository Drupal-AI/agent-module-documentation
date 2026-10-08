<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `ept_settings_slideshow` widget — Flexslider options

`Drupal\ept_slideshow\Plugin\Field\FieldWidget\EptSettingsSlideshowWidget` (annotation id
`ept_settings_slideshow`, field type `ept_settings`). Extends ept_core's
`EptSettingsDefaultWidget`, so it inherits the whole EPT **Design options** panel (ID/anchor,
margin/border/padding boxes, border color/style/radius, background color, background media
image/video + overlay, edge-to-edge, container width, spacing) and adds the Flexslider controls on
top. There is **no module settings page** — all configuration is per-paragraph, on the paragraph
edit form's **Settings** tab (set as the `field_ept_settings` widget in the default form display).

The widget's `formElement()` (`src/Plugin/Field/FieldWidget/EptSettingsSlideshowWidget.php:25`)
first sets a hidden `pass_options_to_javascript = TRUE`, then adds the fields below. Values are
stored on the paragraph's `field_ept_settings` under `ept_settings`, and (because
`pass_options_to_javascript` is TRUE) ept_core copies the whole `ept_settings` array to
`drupalSettings.eptSlideshow['paragraph-id-<id>'].options` at view time — see
[../theme/rendering.md](../theme/rendering.md).

## Top-level options

| `ept_settings` key | `#type` | Default | Flexslider meaning |
|---|---|---|---|
| `animation` | radios (`fade`, `slide`) | `fade` | Animation type. **Carousel needs `slide`.** |
| `direction` | radios (`horizontal`, `vertical`) | `horizontal` | Slide direction. |
| `reverse` | checkbox | (unset) | Reverse the animation direction. |
| `animationLoop` | checkbox | `1` | Loop the animation; if off, directionNav gets "disable" classes at the ends. |
| `smoothHeight` | checkbox | (unset) | Animate slider height smoothly (horizontal mode). |
| `startAt` | number | `0` | Zero-based index of the first slide. |
| `slideshow` | checkbox | (unset) | Auto-advance the slider. |
| `animationSpeed` | number | `600` | Animation duration (ms). |
| `slideshowSpeed` | number | `7000` | Time each slide is shown (ms). |
| `initDelay` | number | `0` | Initialisation delay (ms). |
| `randomize` | checkbox | (unset) | Randomise slide order. |
| `fadeFirstSlide` | checkbox | `1` | Fade in the first slide when `animation:fade`. |
| `thumbCaptions` | checkbox | (unset) | Put captions on thumbnails for the "thumbnails" controlNav. |

## Navigation settings — under `usability` (details, collapsed)

| `ept_settings['usability']` key | `#type` | Default | Meaning |
|---|---|---|---|
| `pauseOnHover` | checkbox | (unset) | Pause the slideshow while hovering. |
| `controlNav` | checkbox | `1` | Paging control dots. |
| `directionNav` | checkbox | `1` | Previous/next arrows. |
| `prevText` | textfield | `Previous` | Text for the "previous" control. |
| `nextText` | textfield | `Next` | Text for the "next" control. |
| `pausePlay` | checkbox | (unset) | Show a pause/play control. |
| `pauseText` | textfield | `Pause` | Text for the "pause" control. |
| `playText` | textfield | `Play` | Text for the "play" control. |

## Carousel settings — under `carousel` (details, collapsed)

Effective only with `animation:slide`.

| `ept_settings['carousel']` key | `#type` | Default | Meaning |
|---|---|---|---|
| `itemWidth` | number | `0` | Box-model width of each carousel item (px). |
| `itemMargin` | number | `0` | Margin between carousel items. |
| `minItems` | number | `1` | Minimum visible items (resize fluidly below). |
| `maxItems` | number | `0` | Maximum visible items (resize fluidly above). |
| `move` | number | `0` | Items moved per animation; `0` = all visible items. |
| `allowOneSlide` | checkbox | `1` | Allow a slider of a single slide. |

## `massageFormValues()`

Only guarantees each delta has an `ept_settings` key: `$value += ['ept_settings' => []];`
(`EptSettingsSlideshowWidget.php:248`). No transformation or filtering happens here.

## Reading / writing in PHP

The value is a nested array under `field_ept_settings…ept_settings`. Example — an auto-advancing
horizontal slideshow:

```php
$paragraph->field_ept_settings->ept_settings = [
  'pass_options_to_javascript' => TRUE,
  'animation' => 'fade',
  'direction' => 'horizontal',
  'animationLoop' => 1,
  'slideshow' => 1,
  'slideshowSpeed' => 5000,
  'animationSpeed' => 600,
  'usability' => ['controlNav' => 1, 'directionNav' => 1, 'pauseOnHover' => 1],
  'carousel'  => ['minItems' => 1, 'maxItems' => 0, 'allowOneSlide' => 1],
  // 'design_options' => [...]  // inherited ept_core keys (margins/background/etc.)
];
$paragraph->save();
```

## Who can set these

Anyone with permission to edit the paragraph (i.e. edit the host content — a privileged authoring
task). The numeric/checkbox/radios/select controls are constrained input; the four `usability` text
fields (`prevText`, `nextText`, `pauseText`, `playText`) are free text but are passed through
`Drupal.checkPlain()` in `js/flexslider/flexslider.js` before Flexslider inserts them, and the
inherited ept_core design values are rendered as an inline `<style>` via ept_core's `GenerateCSS`,
which `Html::escape()`s each value.
