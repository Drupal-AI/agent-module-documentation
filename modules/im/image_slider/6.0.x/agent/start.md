<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Image slider — agent index

An `image_slider` content entity (base table `slider`) + a per-slider **derived block**
(`slider_block`) that renders one of 11 jssor slideshow layouts client-side. Manage at
`admin/structure/image_slider/list` (`configure` = `entity.image_slider.collection`). Depends on
core `options` + `user`.

- **Entity fields, slide types, permissions, the derived block, rendering & templates** →
  [configure/sliders.md](configure/sliders.md)

Key facts:
- Entity `image_slider`, base table `slider`; images stored in `image_slider__image` (alt + target_id).
- Fields: `name`, `description` (text_long), `image` (unlimited), `slide_type` (list_string, 11 values),
  `user_id`, `role`, `langcode`, `created`, `changed`.
- Block plugin `slider_block` is derived per saved slider (`Plugin/Derivative/SliderBlock`); block
  access = core `access content`.
- Permissions: `view` / `add` / `edit` / `delete slider entity` (none `restrict access: true`).
- Ships image styles `image_slider_gallery`, `image_slider_vertical_thumb_gallery` (config/install).
- No config schema, no plugin types, no Drush. jssor JS is bundled (library `image_slider/image_slider_data`).
