<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
EBT Carousel adds a reusable "EBT Carousel" custom block type whose slides are media-library images (with an optional caption and an optional link that wraps the slide), rendered as a Tiny Slider carousel with a large set of per-block slider and design options.

---

The Extra Block Types family is the block-shaped counterpart to EPT's paragraph types, and the distinction decides where a component can live. A paragraph belongs inside one content entity's field, so it is tied to a single page; a **block** can be placed in a region through block layout, dropped into a **Layout Builder** section, or referenced from a field — the right shape for a carousel meant to appear on many pages, in a sidebar, or as site furniture rather than one article's body. The block type stores its slides as repeatable **"EBT Carousel item" paragraphs**, each carrying a required `field_ebt_carousel_image` (an entity reference to a `media.type.image` media entity, so the site must already have an Image media type — the module's install requirement enforces this), an optional `field_ebt_carousel_caption` long-text field, and an optional `field_ebt_carousel_item_link` link field whose value wraps the whole slide in an anchor. The slider library is **Tiny Slider** (`levmyshkin/tiny-slider`), small vanilla JavaScript that needs no jQuery for the slider itself; it is shipped locally (served from `/libraries/tiny-slider`, with the module's `js/tiny-slider/tiny-slider.js` acting as the Drupal-behavior init wrapper) rather than from a CDN. Configuration is per block, not global: every EBT block carries the shared **EBT Settings** field from `ebt_core`, and this module swaps in an extended `ebt_settings_carousel` widget that adds the full Tiny Slider option set — mode (carousel slide vs gallery fade), axis, slides-to-show and slides-to-scroll, gutter and edge padding, auto/fixed width, speed, loop, auto height, per-breakpoint responsive overrides for mobile/tablet/desktop, controls (prev/next button text and position), navigation dots, autoplay (timeout, direction, hover-pause, start/stop text), and animation class names — on top of ebt_core's shared **design options** (margin/border/padding box, border colour/style/radius, background colour, a media background image or video with parallax/cover/overlay, edge-to-edge, and container max width). At render time ebt_core's `preprocess_block` turns the design options into an inline `<style>` block and passes the slider options into `drupalSettings`, where the module's JS reads them and calls `tns(options)`; free-text slider options are passed through `Drupal.checkPlain()` before reaching the library. An optional image style chosen in the block settings is applied to each slide image via the module's `preprocess_paragraph`. Version **2.0.0**, core requirement `^10.1 || ^11 || ^12`, depending on `ebt_core`, `paragraphs`, and core `link`, `media`, and `media_library`. And the carousel question applies as it always does: **engagement with slides after the first is consistently very low**, auto-advance moves content while it is being read, and on mobile a carousel pushes real content below the fold — so it is right for a logo strip, a curated gallery, or a rotation somebody genuinely owns, and it is the compromise nobody's metrics benefit from when several teams each want the same hero slot.

---

- Add a reusable carousel block to a sidebar via block layout.
- Drop a carousel into a Layout Builder section.
- Build a partner/client logo strip that shows several logos per view.
- Create a testimonial or quote rotation as a placeable block.
- Show a set of promotions or featured items in rotation.
- Reference the same carousel block across many pages.
- Build a homepage feature/hero rotation curated by an editor.
- Show product or case-study highlights in a swipeable block.
- Set slides-to-show to more than one for a multi-item "gallery" strip.
- Use responsive breakpoints to show fewer slides on mobile than desktop.
- Switch to "gallery" mode for a fade-between-slides effect instead of sliding.
- Turn on autoplay with a hover-pause for an unattended banner.
- Add prev/next controls and dot navigation with custom button labels.
- Wrap each slide in a link so the whole image is clickable.
- Apply an image style so all slide images render at a consistent size.
- Add a background colour, border, or edge-to-edge treatment to the whole block via the shared EBT design options.
- Put a media background image with a colour overlay behind a carousel.
- Add a vertical-axis carousel.
- Build a news or events highlight slider in a footer region.
- Provide a swipeable, touch/mouse-drag block component without pulling in jQuery for the slider.
- Center the active slide with edge padding for a "peek" preview of neighbours.
- Enable loop/rewind so the carousel cycles seamlessly.
- Add a CSP nonce to the slider's inline style for sites enforcing a strict Content-Security-Policy.
