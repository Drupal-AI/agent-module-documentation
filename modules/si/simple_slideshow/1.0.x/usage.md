<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Simple Slideshow adds a "Simple Slideshow" field formatter for core image fields. When applied to a multi-value image field, the images render as a Splide.js carousel/slideshow instead of a stacked list.

Use it for image galleries, hero rotators or product-photo carousels without writing custom theme code.

---

Install the module and place the Splide library at `/libraries/splide/dist/...` (the module's library definition references `/libraries/splide/dist/js/splide.min.js` and the skyblue theme CSS). Then edit the "Manage display" of any entity with an image field and choose the "Simple Slideshow" formatter.

Configure the formatter settings: image style, type/effect (slide/loop/fade), autoplay, rewind, speed, start index, slides per page, gap, padding, arrows, pagination, custom arrow SVG path, pause-on-hover, lazy load, direction (ltr/rtl/ttb) and an optional "link image to" mode. No routes or permissions are added.

---

- Render a multi-value image field as a slideshow.
- Choose slide, loop or fade transition effects.
- Enable or disable autoplay per display.
- Set slideshow speed in milliseconds.
- Set the starting slide index.
- Show multiple slides per page.
- Control the gap and padding between slides using CSS units.
- Toggle navigation arrows on or off.
- Toggle pagination dots on or off.
- Supply a custom SVG path for arrow icons.
- Pause the slideshow on hover.
- Enable lazy loading of slide images.
- Set carousel direction: left-to-right, right-to-left or top-to-bottom.
- Apply an image style to each slide.
- Link each slide via the image ALT field or to the file.
- Reuse the formatter on any image field and view mode.
- Depend only on core image plus the Splide library.
