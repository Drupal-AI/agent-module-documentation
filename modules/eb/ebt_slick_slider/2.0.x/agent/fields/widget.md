# The `ebt_settings_slick_slider` widget and its option keys

Slider behaviour is configured entirely through one field widget on the block's `field_ebt_settings`
field — there is no module settings page. All values are stored inside the `ebt_settings` field value
(field type owned by `ebt_core`) and later handed to Slick by the JS behavior.

| | |
|---|---|
| Widget id | `ebt_settings_slick_slider` |
| Class | `Drupal\ebt_slick_slider\Plugin\Field\FieldWidget\EbtSettingsSlickSliderWidget` (`src/Plugin/Field/FieldWidget/EbtSettingsSlickSliderWidget.php`) |
| Extends | `Drupal\ebt_core\Plugin\Field\FieldWidget\EbtSettingsDefaultWidget` |
| Field type | `ebt_settings` (single field type, `field_ebt_settings`) |
| Config schema | none shipped by this module (the `ebt_settings` type is schema'd in `ebt_core`) |

`formElement()` first calls `parent::formElement()` (the base design/background options below), then
sets the hidden `pass_options_to_javascript` to **TRUE** (the base default is FALSE) so `ebt_core`
emits these options into `drupalSettings.ebtSlickSlider`, and appends the Slick fields.
`massageFormValues()` just ensures every delta has an `ebt_settings` key.

## Top-level Slick option keys (added by this widget)

Stored under `ebt_settings[...]`; the JS forwards each to Slick under the same name.

| Key | Element | Default | Slick meaning |
|---|---|---|---|
| `styles` | radios `basic`/`without_styles` | `basic` | Which CSS to attach — "Basic" attaches `ebt_slick_slider/basic` (arrows/dots styling); "Without styles" attaches none. |
| `autoWidth` | checkbox | off | Each slide's width is its natural inline-block width. |
| `autoplay` | checkbox | off | Auto-advance. |
| `autoplaySpeed` | number | `3000` | Auto-advance interval (ms). Disabled in the form unless `autoplay` is checked. |
| `arrows` | checkbox | on (`1`) | Prev/next arrows. |
| `centerMode` | checkbox | off | Centered view with partial prev/next slides (use with odd `slidesToShow`). |
| `centerPadding` | textfield | `50px` | Side padding in center mode (px or %). |
| `dots` | checkbox | off | Dot indicators. |
| `infinite` | checkbox | on (`1`) | Infinite looping. |
| `initialSlide` | number | `0` | Zero-based start slide. |
| `lazyLoad` | radios `ondemand`/`progressive` | `ondemand` | Lazy-load technique. |
| `mobileFirst` | checkbox | off | Responsive settings use mobile-first calculation. |
| `slidesToShow` | number | `1` | Number of slides shown. |
| `slidesToScroll` | number | `1` | Number of slides scrolled per advance. |
| `speed` | number | `300` | Slide/fade animation speed (ms). |
| `variableWidth` | checkbox | off | Variable-width slides. |

## `responsive` group (details "Responsive settings")

Three per-breakpoint sub-groups (`mobile`, `tablet`, `desktop`), each a details element. The JS
assembles them into Slick's `responsive: [{breakpoint, settings}]` array (only breakpoints whose
`breakpoint` value is set are emitted).

| Key (`responsive.<bp>.*`) | Element | Default (`mobile` / `tablet` / `desktop`) | Meaning |
|---|---|---|---|
| `breakpoint` | textfield | `576` / `992` / `1200` | Slick breakpoint (behaves like `min-width`). |
| `slidesToShow` | number | empty | Slides shown at/below this breakpoint. |
| `slidesToScroll` | number | empty | Slides scrolled per advance. |
| `centerMode` | checkbox | empty | Centered view (note: form `#title` is mislabeled "centerPadding"). |
| `centerPadding` | textfield | empty | Side padding in center mode. See runtime bug below. |

## `additional` group (details "Additional settings")

| Key (`additional.*`) | Element | Default | Meaning |
|---|---|---|---|
| `accessibility` | checkbox | on (`1`) | Tabbing + arrow-key navigation. |
| `adaptiveHeight` | checkbox | off | Adaptive height for single-slide horizontal carousels. |
| `draggable` | checkbox | on (`1`) | Mouse dragging. |
| `cssEase` | textfield | `ease` | CSS3 animation easing. (JS coerces `1/0` → bool — see bug note.) |
| `fade` | checkbox | off | Fade instead of slide. |
| `focusOnSelect` | checkbox | off | Focus the clicked slide (**never forwarded** — JS typo). |
| `easing` | textfield | `linear` | jQuery-animate easing. |
| `edgeFriction` | textfield | `0.15` | Resistance at edges of non-infinite carousels. |
| `pauseOnFocus` | checkbox | on (`1`) | Pause autoplay on focus. |
| `pauseOnHover` | checkbox | on (`1`) | Pause autoplay on hover. |
| `pauseOnDotsHover` | checkbox | on (`1`) | Pause autoplay when a dot is hovered. |
| `respondTo` | radios `window`/`slider`/`min` | `window` | Width the responsive object responds to. |
| `rows` | number | `1` | >1 initializes grid mode. |
| `slidesPerRow` | number | `1` | Slides per row in grid mode. |
| `swipe` | checkbox | on (`1`) | Swiping. |
| `swipeToSlide` | checkbox | off | Drag/swipe directly to a slide. |
| `touchMove` | checkbox | on (`1`) | Slide motion with touch. |
| `touchThreshold` | textfield | `5` | Swipe fraction (`1/touchThreshold` of width) needed to advance. |
| `useCSS` | checkbox | on (`1`) | CSS transitions. |
| `useTransform` | checkbox | on (`1`) | CSS transforms. |
| `vertical` | checkbox | off | Vertical slide mode. |
| `verticalSwiping` | checkbox | off | Vertical swipe mode. |
| `rtl` | checkbox | off | Right-to-left direction. |
| `waitForAnimate` | checkbox | on (`1`) | Ignore advance requests while animating. |
| `zIndex` | textfield | `1000` | z-index for slides. |

## JS handling and known bugs (2.0.0)

In `js/slick-slider.js`, string values (`centerPadding`, `lazyLoad`, `easing`, `edgeFriction`,
`respondTo`, `zIndex`, and the per-breakpoint center paddings) pass through `Drupal.checkPlain()`;
numeric values through `parseInt()`; checkboxes map `1 → true` else `false`.

- **`focusOnSelect` never applied:** the branch checks `drupalBlockSettings.additional.additional`
  (typo) and assigns to `options['additional']`, so the intended `focusOnSelect` option is dropped.
- **`cssEase` mishandled:** it is treated as a boolean (`== 1 / == 0`) rather than forwarded as the
  easing string, so the `ease`/custom value never reaches Slick as-is.
- **Responsive `centerPadding` never applied:** read into `…EdgePadding` but forwarded only when a
  differently-named `…CenterPadding` variable is set.
- `touchThreshold` is forwarded as a raw string (no `parseInt`).

These are functional quirks, not security issues (all values are entered by privileged block editors
and either `checkPlain`-escaped or used only as Slick config values).

## Base options inherited from `ebt_core` (`EbtSettingsDefaultWidget`)

The parent adds a "Design options" details group under `ebt_settings[design_options]` — CSS box
(margins/borders/paddings, numeric-validated), hex-validated colors, border style/radius, container
width, background media (image incl. parallax/cover, or YouTube/file video), edge-to-edge, and the
overlay options. Those emit the inline `{{ styles|raw }}` CSS (values `Html::escape`-d in `ebt_core`)
and, where relevant, extra JS libraries — all handled by `ebt_core`, not this module.

## Set the widget / options from code

The widget is already assigned on the shipped form display. To (re)assign it programmatically:

```php
\Drupal::service('entity_display.repository')
  ->getFormDisplay('block_content', 'ebt_slick_slider', 'default')
  ->setComponent('field_ebt_settings', [
    'type' => 'ebt_settings_slick_slider',
    'settings' => [],
    'third_party_settings' => [],
  ])->save();
```

Per-block option values are entered on the block's **Settings** tab and saved into the block's
`field_ebt_settings` value, e.g. a 3-up autoplaying carousel with dots:
`slidesToShow = 3`, `slidesToScroll = 1`, `autoplay = 1`, `dots = 1`, `arrows = 1`.
