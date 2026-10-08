Owl Carousel integrates the OwlCarousel2 jQuery plugin with Drupal, providing an image-field formatter and a Views style that render content as a responsive, touch-enabled carousel/slider.

---

The module ships two rendering integrations that share one set of options (defined in `OwlCarouselGlobal`): a field formatter `owlcarousel_field_formatter` for **image** fields, and a Views **style plugin** `owlcarousel` that turns any view's rows into a carousel. Both expose the same carousel settings — number of `items`, `margin` between items, `nav` arrows, `dots` pagination, `autoplay` (+ `autoplayHoverPause`), `loop`, `rtl`, and a simple two-breakpoint responsive setup (`itemsMobile`/`dimensionMobile` and `itemsDesktop`/`dimensionDesktop`); the field formatter additionally offers an `image_style` and an `image_link`. At render time the settings are JSON-encoded into a `data-settings` attribute on an `.owl-carousel.owl-theme` wrapper (templates `owlcarousel.html.twig` / `owlcarousel-views.html.twig`), and the module's JS reads that to initialise OwlCarousel2. It has **no admin settings page, no config schema, no permissions** — configuration lives entirely in each field-display or view. The carousel depends on the third-party **owlcarousel2** JavaScript library, which is not shipped: it must be placed at `/libraries/owlcarousel2/dist/owl.carousel.js`; a `hook_requirements` check reports whether it is installed, and a Drush command (`owlcarousel:download`, alias `oc:dl`; plus a legacy `owlcarousel-plugin` command) downloads and extracts it. Depends on core `field` and `image`.

---

- Display a multi-value image field as a responsive image carousel.
- Build a homepage hero slider from a View of promoted nodes.
- Turn a View of teasers/cards into a horizontal, swipeable carousel.
- Show a product gallery as an Owl Carousel with navigation arrows.
- Create an auto-playing slideshow that pauses on hover.
- Loop a carousel endlessly so it never hits a start/end.
- Show multiple items per slide (e.g. 3 on desktop, 1 on mobile).
- Add pagination dots and/or previous/next nav arrows to a slider.
- Set the gap between carousel items with the margin option.
- Support right-to-left languages with the `rtl` option.
- Apply an image style to each slide via the field formatter.
- Link each carousel image to its content or the image file.
- Configure different item counts for a mobile vs desktop breakpoint.
- Install the OwlCarousel2 library quickly with `drush owlcarousel:download`.
- Verify the library is present via the module's status-report requirement check.
- Render a logo/partner strip as a continuously scrolling carousel.
- Present testimonials as a rotating single-item carousel.
- Build an image slider block by placing a carousel View in a block.
- Reuse OwlCarouselGlobal default settings when theming custom carousels.
- Override the carousel markup via the owlcarousel / owlcarousel-views templates.
- Pass carousel options to OwlCarousel2 through the generated data-settings attribute.
- Create a testimonial/quote rotator from a content type using the Views style.
