# Field formatter & Views style

## Field formatter `tiny_slider_field_formatter`

Label "Tiny Slider Carousel". `field_types = {image, entity_reference}`. Class
`TinySliderFieldFormatter extends EntityReferenceFormatterBase`. Select it on *Manage display* for
an image or entity-reference field; settings persist in the `entity_view_display` component
`settings`.

## Views style `tiny_slider`

Title "TinySlider", theme `tiny_slider_views`, `usesRowPlugin = TRUE`. Select under a view display's
*Format*; options persist in the view config entity `display.<id>.display_options.style.options`.

## Option keys (shared; from `TinySliderGlobal::defaultSettings()` / `_tiny_slider_default_settings()`)

| Key | Default | Notes |
|---|---|---|
| `image_style` | '' | (formatter) image style id for slide images |
| `responsive_image_style` | '' | (formatter) responsive image style id |
| `image_link` | '' | (formatter) link each image to `content` or `file` |
| `items` | 1 | visible slides |
| `gutter` | '0' | px space between slides |
| `mode` | 'carousel' | `carousel` or `gallery` |
| `nav` | TRUE | dot navigation on/off |
| `navPosition` | 'top' | `top`/`bottom` |
| `navAsThumbnails` | FALSE | use slides as thumbnail nav |
| `autoplay` | FALSE | auto-advance |
| `autoplayHoverPause` | FALSE | pause on hover |
| `autoplayButtonOutput` | FALSE | show start/stop button |
| `autoplayPosition` | 'top' | |
| `autoplayTextStart` / `autoplayTextStop` | 'start' / 'stop' | button labels |
| `controls` | TRUE | prev/next arrows |
| `controlsPosition` | 'top' | |
| `controlsTextPrev` / `controlsTextNext` | 'prev' / 'next' | arrow labels |
| `slideBy` | '1' (formatter) / 'page' (global default) | slide by n or `page` |
| `arrowKeys` | FALSE | keyboard navigation |
| `mouseDrag` | FALSE | drag / touch swipe |
| `loop` | TRUE | infinite loop |
| `center` | FALSE | center active slide |
| `speed` | 300 | transition ms |
| `dimensionMobile`/`itemsMobile`, `dimensionDesktop`/`itemsDesktop` | 0 / NULL | responsive breakpoints → items |
| `advancedMode` | FALSE | when TRUE, use `configJson` |
| `configJson` | '[]' | raw Tiny Slider JSON options; if valid JSON it overrides the individual settings (see `template_preprocess_tiny_slider()` / `TinySliderGlobal::isValidJson()`) |

Settings are formatted by `_tiny_slider_format_settings()` / `TinySliderGlobal::formatSettings()`
and emitted as the slider element's `data-settings` attribute, then read by `js/tiny_slider.js`.

## Set the formatter with drush

```bash
drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_gallery", [
    "type" => "tiny_slider_field_formatter", "label" => "hidden", "region" => "content",
    "settings" => ["items" => 3, "autoplay" => TRUE, "nav" => TRUE, "controls" => TRUE],
  ])->save();
'
```

Read back: `$vd->getComponent("field_gallery")["settings"]`. On load, unset settings are merged from
the formatter's `defaultSettings()`.
