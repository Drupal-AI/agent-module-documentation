# The SVG thumbnail plugin

This module **implements** a plugin of the Media Thumbnails framework's plugin type; it does
not define a new plugin type. Class:
`Drupal\media_thumbnails_svg\Plugin\MediaThumbnail\MediaThumbnailSVG`.

Plugin definition (annotation `@MediaThumbnail`):

```
id  = media_thumbnail_svg
label = "Media Thumbnail SVG"
mime = { "image/svg", "image/svg+xml" }
```

Media Thumbnails matches a source file's MIME type to a plugin's `mime` list, then calls
`createThumbnail($sourceUri)`. This plugin:

1. Resolves the SVG to an absolute path (`file_system->realpath()`) — rasterizers do not all
   support stream wrappers.
2. Reads output settings from `$this->configuration` (populated by the framework from
   `media_thumbnails.settings`): `width` (default constant `DEFAULT_WIDTH = 500`),
   `bgcolor_active` + `bgcolor_value` (else background `transparent`).
3. Picks a rasterizer, **in priority order**:
   - `_media_thumbnails_svg_has_graphics_magick()` → `gm convert -background <bg> -size <w> -quality 100 -strip <src> <src>.png`
   - else `_media_thumbnails_svg_has_image_magick()` → `convert -background <bg> -density <w> -thumbnail <w> -quality 100 -strip <src> <src>.png`
   - else GD via `SVG\SVG::fromFile()` + `toRasterImage()` + `imagepng()` (basic SVG only; no CSS).
4. Writes the PNG as a managed file (`file.repository->writeData(..., $uri.'.png', EXISTS_REPLACE)`)
   and returns it as the media entity's `thumbnail`.

Binary detection (`*.module`): GraphicsMagick requires the `gm` binary and `gm version` output
containing `GraphicsMagick`; ImageMagick requires `convert` and `convert --version` containing
`ImageMagick`. `hook_requirements()` (in `.install`) surfaces the detected rasterizer on the
status report as an INFO item.

To add support for a different vector/other MIME type you would write your **own**
`MediaThumbnail` plugin (see the Media Thumbnails module) — this module is SVG-specific.
