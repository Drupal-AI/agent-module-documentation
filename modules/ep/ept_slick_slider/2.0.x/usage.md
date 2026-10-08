Adds an "EPT Slick Slider" Paragraphs bundle that turns a set of image/text/link slide items into a configurable Slick.js carousel, with every Slick option exposed in the paragraph's Settings tab.

---

Extra Paragraph Types (EPT): Slick Slider ships two Paragraphs types — `ept_slick_slider` (the carousel container) and `ept_slick_slider_item` (one slide, with a required Slide Image media reference plus optional Slide Text and Slide Link). Editors add the container paragraph to any entity that has a Paragraphs field, then add unlimited slide items inside it. A custom `ept_settings_slick_slider` field widget (extending `ept_core`'s shared design/settings widget) surfaces the full Slick.js option set — autoplay, arrows, dots, slidesToShow/slidesToScroll, centerMode, infinite loop, fade, lazy load, RTL, adaptive height, grid rows, plus per-breakpoint responsive overrides for mobile/tablet/desktop. Those options are passed to the browser through `drupalSettings` and applied by `js/slick-slider.js`, which initializes Slick on the `.slides` wrapper. The Slick JS/CSS library is loaded locally from `/libraries/slick` (the `levmyshkin/slick` fork, installed via Composer), so no CDN is used. Because it inherits `ept_core`'s design tab, every slider also gets box spacing, borders, background color/image, container-width and edge-to-edge options rendered as scoped inline CSS. The module has no routes, permissions, services (beyond a hook wrapper), or admin form of its own; all configuration is per-paragraph.

---

- Build a homepage hero carousel of full-width promotional images that auto-advance every few seconds.
- Create a testimonial/quote slider where each slide holds a photo, a text blurb, and a link.
- Display a logo/partner strip showing several small slides at once with `slidesToShow` > 1 and `autoWidth`.
- Make a product/feature carousel with prev/next arrows and dot pagination.
- Show a responsive gallery that displays 1 slide on mobile, 2 on tablet, and 4 on desktop via the responsive breakpoint settings.
- Add a center-mode "coverflow" carousel that peeks the adjacent slides using `centerMode` + `centerPadding`.
- Build a fade-transition slideshow (single slide, `fade` on) instead of a sliding carousel.
- Create a vertical carousel using the `vertical` / `verticalSwiping` options.
- Assemble a card row that scrolls multiple cards per click (`slidesToScroll`) with infinite looping.
- Provide a touch/swipe-friendly mobile image slider with draggable and swipeToSlide enabled.
- Use lazy loading (`ondemand` or `progressive`) so off-screen slide images load only when needed.
- Add an accessible carousel with keyboard/tab navigation (`accessibility` on) and pause-on-hover for autoplay.
- Combine with the Fields UI to swap the slide image style (e.g. the shipped `ept_slick_slider_card` 400x300 crop) or attach Colorbox to slide images.
- Nest a slider inside other EPT layout paragraphs (e.g. EPT Columns) to place carousels in multi-column page sections.
- Turn each slide into a clickable banner by filling the per-slide Slide Link field.
- Set a custom initial slide, animation speed, and easing for a branded transition feel.
- Give the container a background image, padding, and edge-to-edge width using the shared EPT design tab.
- Add an optional heading above the carousel via the shared `field_ept_title` with a configurable wrapper tag.
- Create a grid-mode carousel (multiple `rows` / `slidesPerRow`) for dense thumbnail galleries.
- Adjust `edgeFriction` and `touchThreshold` to tune swipe behavior on non-infinite carousels.
- Restyle the whole slider by choosing the "Basic" style (loads `slick-basic.css`) or "Without styles" to fully theme it yourself.
- Reuse the same slider markup across content types by adding the Paragraphs field to nodes, blocks, or other fieldable entities.
