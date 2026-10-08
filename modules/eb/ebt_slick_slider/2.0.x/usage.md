<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
EBT Slick Slider ships a ready-made "EBT Slick Slider" block type whose slides are paragraphs, rendered as a Slick (kenwheeler) jQuery carousel with the full set of Slick options exposed in the block's settings tab.

---

Like the rest of the Extra Block Types family, this module contributes one component as a **block content type** (placeable in regions and in Layout Builder) rather than a paragraph type, with `ebt_core` supplying the shared `ebt_settings` field, the design/background options, and the `{{ styles|raw }}` CSS machinery. Installing it imports, from `config/install`, a `block_content` bundle `ebt_slick_slider` and a `paragraph` bundle `ebt_slick_slider` ("EBT Slick Slide"): each slide paragraph carries a **required** media-image (`field_ebt_slick_slider_image`, media bundle `image`), optional text (`field_ebt_slick_slider_text`) and an optional link (`field_ebt_slick_slider_link`) that wraps the whole slide; the block holds an unlimited reference to those slides (`field_ebt_slick_slider`) plus the shared `field_ebt_settings`. The only PHP is one field widget, `ebt_settings_slick_slider` (`EbtSettingsSlickSliderWidget` extending `ebt_core`'s `EbtSettingsDefaultWidget`), which adds ~60 Slick knobs — slidesToShow/Scroll, autoplay, arrows, dots, centerMode, fade, lazyLoad, per-breakpoint mobile/tablet/desktop responsive settings, and an "Additional settings" group. At render time four Twig templates wrap the slides in `.slides > .slide` markup and attach the `ebt_slick_slider/slick_slider` library; `Drupal.behaviors.ebtSlickSlider` reads per-block options out of `drupalSettings.ebtSlickSlider` and calls `.slick(options)`. There are **no routes, services, permissions, drush commands or own config schema** — the whole surface is the shipped block/paragraph types, the settings widget, the templates, and the client-side Slick glue. The deciding factor for choosing it: the Slick library (`levmyshkin/slick`, a maintained fork installed to `/libraries/slick`) is jQuery-based, so it fits sites that already load Slick; on sites that have moved past jQuery, `ebt_slideshow` (FlexSlider) is the sibling. Core requirement `^10.1 || ^11 || ^12` declares Drupal 12. The standard carousel-accessibility caveat applies: auto-advance should be pausable and controls need accessible names and keyboard operation — test rather than assume.

---

- Add a Slick slider as a placeable block.
- Reuse a theme's already-loaded Slick library.
- Place a carousel in Layout Builder in a few clicks.
- Build a testimonial or quote slider from paragraph slides.
- Rotate partner or client logos.
- Show a product-image carousel.
- Add a homepage hero slider.
- Configure slidesToShow / slidesToScroll for a multi-item carousel.
- Enable autoplay with a configurable interval.
- Show prev/next arrows and dot indicators.
- Turn on centerMode with partial peeking slides.
- Set distinct slidesToShow per mobile / tablet / desktop breakpoint.
- Enable fade instead of slide animation.
- Lazy-load slide images (ondemand or progressive).
- Wrap each slide image in a link.
- Resize slide images by editing the `slick_slider_card` image style or the field display.
- Share background / spacing / container-width settings with other EBT blocks via `ebt_core`.
- Export the configured slider block with site configuration.
- Adopt this one component without the rest of the EBT family.
- Theme the slider by overriding its four Twig templates.
- Add vertical or RTL sliding.
- Prepare a slider component for Drupal 12.
