<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Image slider provides an `image_slider` content entity for building image sliders/galleries and exposes each saved slider as a placeable block, rendered client-side with the bundled jssor JavaScript library in one of eleven preset layouts.

---

The module defines a fieldable `image_slider` content entity (base table `slider`) with fields for `name`, a rich-text `description`, an unlimited-cardinality `image` field (with alt text), a `slide_type` from eleven preset layouts, plus `user_id`, `role`, `langcode` and created/changed timestamps. Sliders are managed at `admin/structure/image_slider/list` (`configure` = `entity.image_slider.collection`) with add/edit/delete forms; access is governed by a `SliderAccessControlHandler` and four permissions (`view`/`add`/`edit`/`delete slider entity`). A block plugin `slider_block` is **derived per saved slider** (`Plugin/Derivative/SliderBlock`), so every slider you create shows up as its own placeable block; the block reads the slider row and its images straight from the database, resolves file URLs, and renders the `image_slider` Twig template (the `slide_type` selects one of the `{% if %}` layout branches). Block visibility is gated by core `access content`. The chosen slide type is passed to the browser via `drupalSettings.image_slider` and the bundled jssor library (`image_slider/image_slider_data`) initializes the slideshow. Two image styles ship in `config/install` (`image_slider_gallery`, `image_slider_vertical_thumb_gallery`). Note: the description is run through the `full_html` text format at render time (then Twig-escaped), and layout dimensions are largely hardcoded in the template. No config schema, plugin types, or Drush commands are provided.

---

- Build a homepage hero image slider from a set of uploaded images.
- Create a photo gallery with clickable thumbnails.
- Add a full-width banner slider across the top of a landing page.
- Show a rotating banner/announcement carousel.
- Place a scrolling logo strip (partner/sponsor logos) via the logo-thumbnail layout.
- Display an image gallery with a vertical thumbnail column.
- Add a compact carousel slider of product shots.
- Present differently-sized photos in a single slider.
- Show a "nearby image partially visible" peek-style slider.
- Create a full-window slideshow for desktop/PC displays.
- Turn each saved slider into its own block and place it in any region.
- Place different sliders in different regions/pages via block layout + visibility conditions.
- Attach captions/alt text per image for accessibility and overlay text.
- Reuse the same slider block across multiple pages by placing it in a shared region.
- Manage all sliders from one admin collection under Structure.
- Grant editors a limited "add/edit slider entity" role to manage sliders without full admin.
- Switch a slider's look by changing its `slide_type` without re-uploading images.
- Apply the shipped image styles for consistent gallery thumbnail sizing.
- Restrict who can view slider entity pages via the `view slider entity` permission.
- Render a slideshow without writing any JavaScript (jssor is bundled and auto-initialized).
