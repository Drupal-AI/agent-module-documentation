<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring the Product Gallery formatters

## Choose a formatter
- **Product Gallery** (`product_gallery_field_formatter`) — for core `image` fields.
- **Media Product Gallery** (`product_gallery_mfield_formatter`) — for `entity_reference`
  fields targeting media; it loads each media's source file and renders only files whose
  MIME type starts with `image/`.

## Steps
1. On the content type's **Manage display**, set the image/media field's formatter to the
   relevant Product Gallery option.
2. Open the formatter settings and configure the options below.

## Settings reference
| Setting | Purpose |
|---|---|
| `image_style_large` / `_medium` / `_small` | Responsive image styles per breakpoint (selects require `administer image styles`) |
| `thumbnail_image_style` | Image style for the thumbnail strip |
| `thumbnail_border_style` | `round` or `square` |
| `thumb_width` | Thumbnail width 20–140px |
| `thumb_border_color` | Any CSS colour (hex/rgb/hsl/named), default `#007bff` |
| `allow_thumbnail_overlap` + `thumbnail_overlap_threshold` | Overlap thumbnails once count exceeds threshold |
| `enable_mouse_zoom` | Mouse-wheel zoom on the main image |
| `default_zoom_scale` | Initial zoom factor (1 = original) |
| `show_magnifier` | Hover magnifier lens |
| `image_class` / `image_wrapper_class` | Custom CSS classes |
| `container_width` + `container_width_unit` | Max container width with px/em/rem/% |

## Rendering
The formatter builds a `product_gallery` theme element, attaches the `product_gallery`
library, and passes the options plus per-image styled URLs through
`drupalSettings.imageFieldZoom` for the client-side (xzoom) gallery/zoom behaviour.
