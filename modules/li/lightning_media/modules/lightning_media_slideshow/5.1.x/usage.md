<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Media Slideshow adds a **Slideshow** custom block type whose single multi-value field references any media items, rendered as a Slick carousel — so editors can build a slideshow from the media library and place it anywhere blocks can go.

---

The module contains no `.module` file at all: it is configuration plus one service. `config/install/` ships `block_content.type.media_slideshow` (label *Slideshow*, description "A slideshow or carousel of media items.", non-revisionable), an unlimited-cardinality `field_slideshow_items` entity-reference storage on `block_content` targeting `media`, its required field instance labelled *Media items* with no bundle restriction, a `media.slideshow` view mode, a default form display and a default view display that renders the field with the `slick_entityreference_vanilla` formatter (optionset `default`, skin `default`, label visually hidden). Because the block type and field carry `dependencies.enforced.module`, uninstalling the module removes them — which is why the module also registers a `module_install.uninstall_validator` service, `Drupal\lightning_media_slideshow\UninstallValidator`, that blocks uninstall while any `media_slideshow` block content still exists ("To uninstall Media Slideshow, you must delete all slideshow blocks first."). The only install hook, `lightning_media_slideshow_update_9001()`, downloads the Slick 1.8.0 library into `/libraries/slick-carousel` if neither `slick`, `slick-carousel` nor `accessible-slick` can be found. Editors create a slideshow at *Content → Blocks → Add content block → Slideshow*, pick media items, then place the block.

---

- Give editors a drag-and-drop carousel built entirely from media library items.
- Build a homepage hero carousel of images without writing any code.
- Create a photo gallery block for an event recap page.
- Mix images and videos in a single carousel.
- Place the same slideshow block in several regions or layouts.
- Add a slideshow to a Layout Builder section.
- Reorder slides simply by reordering the media reference field's values.
- Restrict a slideshow to specific media bundles by setting the field's `target_bundles`.
- Cap the number of slides by lowering the field storage cardinality.
- Change the Slick optionset (arrows, dots, autoplay) on the block type's view display.
- Apply a Slick skin to match the site's design.
- Use the dedicated `media.slideshow` view mode to render slides differently from elsewhere.
- Reuse an existing image already in the media library across several slideshows.
- Let a marketing team assemble campaign carousels without developer involvement.
- Localise slide captions by translating the referenced media entities.
- Track which media items are used in slideshows via Entity Usage.
- Prevent accidental uninstall while slideshow blocks are still in use.
- Keep the Slick JS library local rather than CDN-hosted for CSP-strict sites.
- Build a testimonial carousel from Tweet media items.
- Build an Instagram wall as a carousel of Instagram media items.
- Show a product image carousel on a commerce product page.
- Give the block a visible title or hide it via the usual block settings.
- Query all slideshow blocks with an entity query on `block_content` type `media_slideshow`.
- Export slideshow blocks as default content for a distribution.
