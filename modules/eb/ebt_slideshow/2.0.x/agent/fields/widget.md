# The `ebt_settings_slideshow` widget and its option keys

Slideshow behaviour is configured entirely through one field widget on the block's `field_ebt_settings`
field — there is no module settings page. All values are stored inside the `ebt_settings` field value
(field type owned by `ebt_core`) and later handed to FlexSlider by the JS behavior.

| | |
|---|---|
| Widget id | `ebt_settings_slideshow` |
| Class | `Drupal\ebt_slideshow\Plugin\Field\FieldWidget\EbtSettingsSlideshowWidget` (`src/Plugin/Field/FieldWidget/EbtSettingsSlideshowWidget.php`) |
| Extends | `Drupal\ebt_core\Plugin\Field\FieldWidget\EbtSettingsDefaultWidget` |
| Field type | `ebt_settings` (single field type, `field_ebt_settings`) |
| Config schema | none shipped by this module (the `ebt_settings` type is schema'd in `ebt_core`) |

`formElement()` first calls `parent::formElement()` (the base design/background options below), then
sets the hidden `pass_options_to_javascript` to **TRUE** (the base default is FALSE) so `ebt_core`
emits these options into `drupalSettings.ebtSlideshow`, and appends the FlexSlider fields.
`massageFormValues()` just ensures every delta has an `ebt_settings` key.

## FlexSlider option keys (added by this widget)

Stored under `ebt_settings[...]`; the JS forwards each to FlexSlider under the same name (`selector`
is hard-coded to `.slides > .slide`).

| Key | Element | Default | FlexSlider meaning |
|---|---|---|---|
| `animation` | radios `fade`/`slide` | `fade` | Animation type. **Carousel needs `slide`.** |
| `direction` | radios `horizontal`/`vertical` | `horizontal` | Slide direction. |
| `reverse` | checkbox | off | Reverse animation direction. |
| `animationLoop` | checkbox | on (`1`) | Loop the animation. |
| `smoothHeight` | checkbox | off | Animate slider height in horizontal mode. |
| `startAt` | number | `0` | Zero-based start slide. |
| `slideshow` | checkbox | off | Auto-advance. |
| `animationSpeed` | number | `600` | Animation duration (ms). |
| `slideshowSpeed` | number | `7000` | Cycle interval (ms). |
| `initDelay` | number | `0` | Initialization delay (ms). |
| `randomize` | checkbox | off | Randomize slide order. |
| `fadeFirstSlide` | checkbox | on (`1`) | Fade in first slide when `animation=fade`. |
| `thumbCaptions` | checkbox | off | Captions on thumbnails (thumbnails controlNav). |

### `usability` group (details "Navigation settings")

| Key (`usability.*`) | Element | Default | Meaning |
|---|---|---|---|
| `pauseOnHover` | checkbox | off | Pause auto-play on hover. |
| `controlNav` | checkbox | on (`1`) | Paging control dots. |
| `directionNav` | checkbox | on (`1`) | Prev/next arrows. |
| `prevText` | textfield | `Previous` | Prev arrow text. |
| `nextText` | textfield | `Next` | Next arrow text. |
| `pausePlay` | checkbox | off | Add pause/play control. |
| `pauseText` | textfield | `Pause` | Pause control text. |
| `playText` | textfield | `Play` | Play control text. |

### `carousel` group (details "Carousel settings")

| Key (`carousel.*`) | Element | Default | Meaning |
|---|---|---|---|
| `itemWidth` | number | `0` | Box-model width of each carousel item. |
| `itemMargin` | number | `0` | Margin between items. |
| `minItems` | number | `1` | Minimum visible items. |
| `maxItems` | number | `0` | Maximum visible items. |
| `move` | number | `0` | Items moved per animation (`0` = all visible). |
| `allowOneSlide` | checkbox | on (`1`) | Allow a single-slide slider. |

In the JS (`js/flexslider/flexslider.js`), text values (`animation`, `direction`, `prevText`,
`nextText`, `pauseText`, `playText`) are passed through `Drupal.checkPlain()`; numeric values through
`parseInt()`; checkboxes map `1 → true` else `false`.

## Base options inherited from `ebt_core` (`EbtSettingsDefaultWidget`)

The parent adds a "Design options" details group under `ebt_settings[design_options]`:

- `design_options.box1.{margin_top,margin_right,margin_bottom,margin_left}` — numeric-only
  (`validateBoxElement`).
- `design_options.box1.box2.{border_top,border_right,border_bottom,border_left}` — numeric-only.
- `design_options.box1.box2.box3.{padding_top,padding_right,padding_bottom,padding_left}` —
  numeric-only.
- `design_options.other_settings.{border_color,background_color,overlayColor,...}` — validated as hex
  via `Color::validateHex` (`validateColorElement`).
- `design_options.other_settings.border_style` / `border_radius` / `background_image_style` /
  `container_width` — fixed-option selects; `background_position` select (+ `background_position_custom`).
- `design_options.other_settings.background_media` — `media_library` (image / oembed video / video file).
- `design_options.other_settings.background_video_settings.*` and `background_image_settings.*` — video
  autoplay/mute/overlay and image position/overlay options.

`container_width`'s description links to the `ebt_core.settings` form for site-wide defaults (that form
lives in `ebt_core`, not here).

## Set the widget / options from code

The widget is already assigned on the shipped form display. To assign it (or on another
`ebt_settings` field) programmatically:

```php
\Drupal::service('entity_display.repository')
  ->getFormDisplay('block_content', 'ebt_slideshow', 'default')
  ->setComponent('field_ebt_settings', [
    'type' => 'ebt_settings_slideshow',
    'settings' => [],
    'third_party_settings' => [],
  ])->save();
```

Per-block option values are entered on the block's **Settings** tab and saved into the block's
`field_ebt_settings` value, e.g. to build a carousel: `animation = slide`, `carousel.minItems = 2`,
`carousel.maxItems = 4`, `slideshow = 1`.
