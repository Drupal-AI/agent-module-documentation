<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Swiper formatter integrates the [Swiper](https://swiperjs.com/) touch-slider library into Drupal as a reusable "Swiper template" configuration entity, plus a set of field formatters and a Views style that render field values or Views rows as a Swiper slider.

---

The module centres on the `swiper_formatter` config entity (a "Swiper template"): each template stores a large `swiper_options` map — direction, effect, loop, speed, slidesPerView, spaceBetween, and nested option groups for grid, keyboard, autoplay, navigation, pagination, scrollbar, zoom, lazy loading and responsive breakpoints. Templates are managed at `admin/config/content/swiper-formatter` and a shipped `default` template seeds new ones (via `SwiperFormatter::preCreate()` deep-merging the default's options). Any content is turned into slides by choosing one of eight field formatters — `swiper_formatter_image` (image), `swiper_formatter_entity` (entity_reference), `swiper_formatter_paragraphs` (entity_reference_revisions), `swiper_formatter_text` (text/text_long/text_with_summary) and a `*_dialog` variant of each that opens slides in a modal — or the `swiper_formatter` Views style. A formatter/style picks a template and delegates rendering to the `swiper_formatter.base` service (`Swiper::renderSwiper()`), which attaches the Swiper JS library (Package/remote/local source), applies token-based captions and links, and themes the slides with the `swiper-formatter` / `swiper-formatter-slide` templates. The Swiper library is loaded from one of four library sources (a self-hosted Package build is the default; `remote` uses unpkg CDN; `local`/`local_minified` use `/libraries/swiper`). It depends on `token`, defines one permission (`administer swiper_formatter`), invites `hook_swiper_formatter_settings_alter()` to tweak per-instance options, and ships a `swiper_formatter_ckeditor` submodule (a placeholder for a CKEditor 5 button).

---

- Turn a multi-value image field into a touch/swipe image carousel with the **Swiper images** formatter.
- Build a slider of referenced content (nodes, media, users) with the **Swiper entity** formatter.
- Render a Paragraphs field as slides with the **Swiper paragraphs** formatter.
- Slide through long-text or formatted-text field deltas with the **Swiper text** formatter.
- Open each slide in a modal/lightbox dialog using any of the `*_dialog` formatter variants.
- Present Views results (nodes, media, teasers) as a slider with the **Swiper formatter** Views style.
- Create several named Swiper templates (e.g. "Hero", "Thumbnails", "Gallery") and reuse them across fields and views.
- Configure autoplay with a delay and pause-on-hover for a rotating hero banner.
- Enable looping/rewind so a promo slider cycles endlessly.
- Add clickable pagination bullets (with dynamic bullets) and prev/next navigation arrows.
- Show a draggable scrollbar that auto-hides after interaction.
- Switch a slider to vertical direction for a testimonial ticker.
- Set slidesPerView (including fractional like 1.5) and spaceBetween for a peeking multi-item carousel.
- Define responsive breakpoints so a slider shows 1 slide on mobile and 3 on desktop.
- Lay slides out in a grid (rows + fill mode) for a paged thumbnail wall.
- Enable image zoom (double-tap / pinch) with min/max ratio on a photo gallery.
- Turn on lazy loading so off-screen slide images load only when approaching the viewport.
- Add keyboard control so arrow keys move the slider.
- Enable mouse-wheel navigation through slides.
- Serve the Swiper library from a self-hosted build (Package), a CDN (remote), or `/libraries` (local) to satisfy CSP or offline needs.
- Use a token-based caption drawn from another field on each slide.
- Link each slide to its entity or a custom token-built URL.
- Mark a template as a "breakpoint" template so it is only used inside another template's responsive breakpoints.
- Duplicate an existing Swiper template as a starting point for a new one.
- Alter a specific Swiper instance's options in code with `hook_swiper_formatter_settings_alter()` (e.g. compute grid rows from slide count).
- Restrict who can manage Swiper templates with the `administer swiper_formatter` permission.
