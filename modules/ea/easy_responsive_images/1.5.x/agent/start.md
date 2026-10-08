<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Easy Responsive Images — agent index

Auto-generates `responsive_*` image styles from a width range + aspect ratios, then outputs them
via a field formatter or a Twig filter, with JS that loads the best derivative per container.

- **Generate/delete the image styles, settings keys, and the `responsive_*` naming** →
  [configure/generate.md](configure/generate.md)
- **The `easy_responsive_images` field formatter and its options** →
  [configure/formatter.md](configure/formatter.md)
- **The `image_url` Twig filter, the resizer library, and the template** →
  [theming/twig.md](theming/twig.md)
- **The manager service and `hook_easy_responsive_images_image_style_alter()`** →
  [api/extend.md](api/extend.md)

Key facts:
- Settings form: `/admin/config/media/image-styles/generate` (route `easy_responsive_images.generate`,
  permission `administer image styles`). Config object `easy_responsive_images.settings`.
- Generated style names: `responsive_<width>w` (scale), `responsive_<w>_<h>_<width>w` (aspect crop),
  `responsive_<height>h` (fixed height). All prefixed `responsive_`; obsolete ones pruned on save.
- Field formatter id: `easy_responsive_images` (image fields). Twig filter: `image_url`.
- Depends on core `image`. No Drush, no permissions of its own.
