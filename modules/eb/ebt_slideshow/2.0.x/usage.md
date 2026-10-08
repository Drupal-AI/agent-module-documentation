<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
EBT Slideshow ships a ready-made Slideshow block type built on FlexSlider — the slider component of the Extra Block Types family, which builds page components as **block types** rather than paragraph types.

---

Extra Block Types is the block-oriented sibling of Extra Paragraph Types: the same one-module-per-component design over a shared `ebt_core`, but producing block content types you can place in regions and in Layout Builder. This module contributes the slideshow, and it is almost entirely configuration plus templates. Installing it imports a `block_content` type `ebt_slideshow` ("EBT Slideshow") and a `paragraph` type `ebt_slideshow` ("EBT Slide"): a block holds an unlimited list of slides (`field_ebt_slideshow`), and each slide is a paragraph with a required media image, plus an optional title, text and link. Four Twig templates render the slides into the FlexSlider structure and attach the `ebt_slideshow/flexslider` library, whose behavior reads the per-block options and initializes the slider. To install, first create an **Image media type** at `admin/structure/media` (installation fails without one), require the module with Composer — which also pulls `levmyshkin/flexslider ^2.7` into `/libraries/flexslider` — enable it (dependencies `ebt_core`, `paragraphs`, `media`, `media_library` come along), then add a block of type "EBT Slideshow" from the custom block library or Layout Builder. Add slides on the **Content** tab and tune the slider on the **Settings** tab (animation fade/slide, auto-play and timing, prev/next and paging navigation, and carousel min/max items — a carousel is just `animation: slide` plus the carousel options). Shared spacing, background and container-width options come from `ebt_core` and are edited on the same settings tab; site-wide defaults live on the EBT Core settings form. The module has no settings page of its own, no permissions and no routes — it is the block type, its settings widget, the templates and the FlexSlider glue.

---

- Add an image slideshow as a placeable block.
- Put a carousel in a Layout Builder section (set animation to Slide).
- Give editors a slideshow without a content type.
- Pick slides from the media library (Image media type required).
- Reuse one slideshow block across pages.
- Build a homepage hero from a block.
- Share styling settings with other EBT components via ebt_core.
- Add a testimonial carousel.
- Show a product image slider.
- Theme the slideshow with a Twig override (four theme suggestions).
- Place a slideshow in a sidebar region.
- Use FlexSlider without wiring it up manually.
- Auto-advance slides and pause on hover from the Settings tab.
- Add a slideshow to a landing page.
- Add per-slide title, text and a link.
- Export a configured slideshow with site config.
- Prepare a slider component for Drupal 12.
- Adopt one EBT component without the whole set.
