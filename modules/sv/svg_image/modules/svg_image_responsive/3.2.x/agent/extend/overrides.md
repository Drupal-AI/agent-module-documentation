# Overridden responsive formatter

Like the parent module, this submodule swaps classes behind core plugin IDs via
`hook_field_formatter_info_alter()` (`svg_image_responsive.module`) — no new plugins.

| Core plugin ID | Replacement class | Notes |
|---|---|---|
| `responsive_image` | `SvgResponsiveImageFormatter` (extends core `ResponsiveImageFormatter`) | SVG-aware |
| `image` | `SvgImageFormatter` (from parent module) | re-asserted |

`SvgResponsiveImageFormatter` uses `SvgImageFormatterTrait`, so it exposes the same display
settings as the main formatter:

| Setting key | Type | Meaning |
|---|---|---|
| `svg_render_as_image` | bool (default TRUE) | `<img>` vs inline `<svg>`. |
| `svg_attributes.width` / `.height` | int / null | Forced dimensions. |

Render logic (`viewElements()`):
- Non-SVG items → untouched parent `<picture>`/`srcset` output.
- SVG items → `renderAsImg()` (dimensions derived from the responsive style's **fallback**
  image style) or `renderAsSvg()` (sanitized inline markup), honoring the `image_link`
  setting to optionally wrap in a link to the file or entity.

Config schema for the added settings (`responsive_image_style`, `image_link`,
`svg_attributes`, `svg_render_as_image`) is registered through
`hook_config_schema_info_alter()`. Requires core `responsive_image` and the parent
`svg_image` module to be enabled.
