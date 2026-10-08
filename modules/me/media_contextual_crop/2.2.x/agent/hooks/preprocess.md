# Preprocess & entity hooks (formatter interception)

The "magic" that makes an ordinary image display honour a contextual crop lives in preprocess
hooks (in `media_contextual_crop.module` + the required includes
`media_contextual_crop.alter_image_formatter.inc` and
`media_contextual_crop.alter_responsive.common.inc`). Integrators do not call these directly —
they explain how the module rewrites derivative URLs behind core's own formatters.

## Plain image formatter

- `hook_preprocess_image_formatter(&$vars)` — finds a competent use-case plugin for
  `$vars['item']`; if one exists, switches `$vars['image']['#theme']` to **`image_contextual`**
  and stashes the crop settings in `#attributes['contextual']`.
- `template_preprocess_image_contextual(&$vars)` — runs core's image-style preprocessing, then
  asks the use-case plugin for the contextual derivative URI and swaps `$vars['image']['#uri']`
  to it (only when `ImageStyle::supportsUri()`). Template `image-contextual.html.twig` just
  prints `{{ image }}`.
  **(2.2.x)** the core preprocessing call now uses the Drupal 11.4 OOP hook
  `\Drupal::service(ImageThemeHooks::class)->preprocessImageStyle($variables)` instead of the
  removed procedural `template_preprocess_image_style()`.

## Responsive images

- `hook_preprocess_responsive_image_formatter` / `hook_preprocess_cqri_formatter` →
  `_media_contextual_crop_responsive_formatters()` — stashes crop settings under
  `#attributes['#mcc']`.
- `hook_preprocess_responsive_image` / `hook_preprocess_cqri_item` →
  `_media_contextual_crop_preprocess_responsive_item()` — for every image style in the responsive
  style's mappings **and** the fallback that `styleUseMultiCrop()` reports, generates a contextual
  derivative and rewrites the matching `srcset` entries and the fallback `<img>` URI.
  (`cqri` = the Client-side/Quality Responsive Images contrib formatter, supported alongside core
  `responsive_image`.)

## Entity lifecycle / cache cleanup

- `hook_crop_delete(Crop $crop)` → `MediaContextualCropService::deleteDerivative($crop)` — removes
  every derivative generated from a deleted crop.
- `hook_image_style_flush($style, $path)` → `MediaContextualCropService::flushStyle($style, $path)`
  — clears contextual derivatives when a style is flushed.

## `hook_theme`

Defines two theme hooks:

| Theme | Template | Variables |
|---|---|---|
| `image_contextual` | `image-contextual.html.twig` | `style_name, uri, width, height, alt, title, attributes` |
| `image_contextual_formatter` | `image-contextual-formatter.html.twig` | `item, item_attributes, url, image_style` |

`hook_help` adds a help blurb on `help.page.media_contextual_crop`. No other public hooks.
