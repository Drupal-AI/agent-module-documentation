<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Splide X — agent index

Example/extras submodule for **Splide**: ships demo optionsets, image styles, a sample View, and an
extra skin plugin to learn from and clone. No admin UI, permissions, config, or Drush of its own.

Key facts:
- Depends on `splide`. `configure: null`. Package `Splide`.
- **Install requirement:** the image fields `field_image` (single) and `field_images` (multi-value)
  must exist **before** enabling, or install can fail (see the module's README).
- Ships **example optionsets** (config `splide.optionset.*`): `x_main`, `x_carousel`, `x_grid`,
  `x_fullscreen`, `x_overlay`, `x_split`, `x_vtabs`, `x_splide_for`, `x_splide_nav`.
- Ships **image styles**: `splide`, `splide_fullscreen`, `splide_lighbox`, `splide_rectangle`,
  `splide_square`, `splide_thumbnail`.
- Ships a demo **View**: `views.view.splide_x`.
- Ships a `@SplideSkin` plugin `SplideXSkin` (id `splide_x_skin`) with skins `d3-back`, `boxed`,
  `rounded`, `vtabs`, `x-testimonial`, … (skin plugin type documented with the parent:
  [../../../../2.0.x/agent/plugins/skin.md](../../../../2.0.x/agent/plugins/skin.md)).
- Maintainers recommend cloning these examples into your own module rather than depending on
  splide_x in production.
- Optionset structure & renderers are documented with the parent:
  [../../../../2.0.x/agent/configure/optionsets.md](../../../../2.0.x/agent/configure/optionsets.md).
