# Overridden widget & formatters

svg_image does not register new plugins; it **replaces the classes** behind core plugin IDs
via alter hooks (`svg_image.module`), keeping the original IDs and labels so existing config
keeps working.

| Core plugin ID | Type | Replacement class | What changes |
|---|---|---|---|
| `image_image` | widget | `SvgImageWidget` (extends core `ImageWidget`) | allows `.svg`, drops `FileIsImage` validator, SVG preview |
| `image` | formatter | `SvgImageFormatter` | render SVG as `<img>` or inline `<svg>`, forced dimensions |
| `image_url` | formatter | `SvgImageUrlFormatter` (extends `ImageUrlFormatter`) | returns raw SVG URL when an image style is set |

Wiring:
```php
function svg_image_field_widget_info_alter(array &$info) {
  $info['image_image']['class'] = SvgImageWidget::class;
}
function svg_image_field_formatter_info_alter(array &$info) {
  $info['image']['class'] = SvgImageFormatter::class;
  $info['image_url']['class'] = SvgImageUrlFormatter::class;
}
```

Formatter behavior lives in `SvgImageFormatterTrait` (shared with the responsive submodule):
- `svgDefaultSettings()` / `svgSettingsForm()` — adds the `svg_render_as_image` +
  `svg_attributes` settings.
- `renderAsImg()` — keeps the parent `image_formatter` render array, drops the image style,
  applies forced/derived width & height, merges cache tags.
- `renderAsSvg()` — sanitizes + inlines the SVG markup (optionally wrapped in a link).
- `fileGetContents()` — reads the file and runs `enshrined\svgSanitize\Sanitizer`.

To customize, subclass these formatters/widget and re-point the class in your own
`*_info_alter` hook (last hook wins).
