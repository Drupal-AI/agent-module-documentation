<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Product Gallery (product_gallery) — agent index

**Field formatters that render image/media fields as an interactive product gallery: thumbnails, mouse-wheel zoom, hover magnifier.**

- **Version:** 1.1.x  •  core: `^10 || ^11`  •  depends on `image`, `field`.
- **Formatters:** `product_gallery_field_formatter` (image fields) and `product_gallery_mfield_formatter` "Media Product Gallery" (entity_reference → media; only image MIME types rendered).
- **Theme + library:** `product_gallery` theme hook (`product-gallery` template), `product_gallery` library (core/jquery, core/drupal, core/drupalSettings, core/once) with an xzoom-based zoom layer.
- **Settings:** responsive image styles (large/medium/small/thumbnail), thumbnail shape/width/colour, overlap + threshold, mouse-zoom toggle, zoom scale, magnifier, custom classes, container width/unit. Image-style selects gated by `administer image styles`.
- **Security:** display-only; no routes, permissions, services, or config entities. No user-supplied URL is fetched server-side (paths come from field files / image-style buildUrl) — no SSRF surface. No security findings.

See [configure/formatter.md](configure/formatter.md) for the settings reference.
