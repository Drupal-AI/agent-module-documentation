<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
EPT Slideshow adds a ready-made Slideshow/carousel paragraph type built on the FlexSlider library, with slides chosen from the media library.

---

Part of the Extra Paragraph Types family, it installs two Paragraphs bundles: **`ept_slideshow`** (the wrapper, holding an optional title/text and an unlimited list of slides) and **`ept_slideshow_item`** (one slide: a required-style media image plus optional title, text and link). An editor adds the Slideshow paragraph to content, adds slide items, and picks each image through the **media library**; a **Settings** tab exposes the FlexSlider options — animation type (`fade` for a slideshow, `slide` for a carousel), direction, auto-advance and speed, loop, navigation dots/arrows, pause-on-hover, and carousel item sizing — which are stored on the paragraph and handed to `js/flexslider/flexslider.js` at render time to initialise the slider. The shared EPT **Design options** (margins, padding, border, background color/image/video, edge-to-edge, container width) come from `ept_core`, which also emits the per-paragraph `<style>` block. It depends on core `media` and `media_library` plus `ept_core` and `paragraphs`, and Composer additionally pulls `levmyshkin/flexslider` into `/libraries/flexslider/`. Core requirement is `^10.1 || ^11 || ^12`. **Installation note:** the module requires an **`image`** media type to exist before it will install — on a minimal profile with no image media type the install is blocked with an unmet configuration dependency, so create the media type at `/admin/structure/media` first. There is no module settings page, no permissions and no Drush; all configuration is per-paragraph.

---

- Add a slideshow to a page as a paragraph.
- Build an image carousel with the `animation:slide` option.
- Show a rotating set of featured items.
- Pick each slide image from the media library.
- Add a title and caption text to individual slides.
- Link a slide to another page or an external URL.
- Auto-advance slides on a timer.
- Set the transition type (fade or slide) and speed.
- Turn navigation dots and previous/next arrows on or off.
- Pause the slideshow when a visitor hovers over it.
- Add a pause/play control to the slider.
- Loop the animation or stop at the last slide.
- Randomise the slide order.
- Show multiple items at once in carousel mode (min/max items).
- Build a partner-logo or product-photo carousel.
- Present a photo essay or project gallery as a slider.
- Apply shared EPT design options (background, spacing, container width) to the slideshow.
- Give editors a ready-made slider without custom JavaScript.
- Reuse the slideshow paragraph on any content type that has a Paragraphs field.
- Install just this EPT paragraph type without the rest of the family.
