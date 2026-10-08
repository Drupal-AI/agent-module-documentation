<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Simple Slideshow - agent index

Field formatter for image fields rendering a Splide.js slideshow. Version **1.0.5** (1.0.x), core `^8 || ^9 || ^10`. Depends on core `image`.

- Formatter plugin `simple_slideshow_field_formatter` (`SimpleSlideshowFieldFormatter`, extends `ImageFormatterBase`), field type `image`.
- Requires the Splide library at `/libraries/splide/dist/...` (see `simple_slideshow.libraries.yml`).
- ~16 display settings (type, autoplay, speed, arrows, pagination, image style, direction, etc.); theme hook `simple_slideshow`; JS in `js/simple_slideshow.js`.
- No routes, permissions, services or config entities. Formatter output sets `#cache max-age = 0`.

No security-sensitive surface (display-only formatter). Image values come from managed files; output uses the core image render pipeline.
