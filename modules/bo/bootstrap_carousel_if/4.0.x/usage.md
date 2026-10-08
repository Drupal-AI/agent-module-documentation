Bootstrap Carousel Image Formatter renders a multi-value image field as a Bootstrap 5 carousel.

---

A multi-value image field on a product, a property listing or a gallery node is a set of images that a design usually wants as a carousel. Doing that as a field formatter is the right layer — it is a display decision, so it belongs in Manage display, per view mode, rather than in a template. The module ships a single formatter ("Bootstrap Carousel") for core image fields, plus the Twig template that emits the markup; it adds no field type, widget, route or permission.

Choosing the Bootstrap carousel specifically means the markup and behaviour come from a framework the theme probably already loads, so there is no additional slider library and the styling follows the site's Bootstrap variables. The formatter emits Bootstrap 5 markup (the `data-bs-*` API), so the theme must supply Bootstrap's carousel JavaScript as well as its CSS — with CSS only, the carousel looks right and does not move. Settings cover interval, pause on hover, wrap, indicators, controls and an optional image style; indicators and controls are suppressed automatically when there is only one image. Slide captions come from each image's Title text.

For a product gallery, where the images are alternatives rather than a sequence to be read, the usual "images past the first are rarely seen" objection is much weaker than for content — which is the case this formatter fits best.

---

- Show a multi-value image field as a Bootstrap carousel.
- Present product photos as swipeable alternatives.
- Build a property-listing photo gallery.
- Render a homepage hero slideshow from an image field.
- Choose the carousel formatter per view mode.
- Show a thumbnail in teaser and the carousel in the full view.
- Reuse the theme's existing Bootstrap library instead of a separate slider.
- Apply an image style to every slide for consistent sizing.
- Set the auto-advance interval between slides.
- Enable pause-on-hover so visitors can read a slide.
- Turn wrap on or off to control looping at the ends.
- Show or hide the prev/next control arrows.
- Show or hide the dot indicators.
- Let single-image fields fall back to a plain image (indicators/controls auto-off).
- Add captions by filling in each image's Title text.
- Order the slides by reordering images in the field.
- Style the carousel through the site's Bootstrap variables.
- Confirm the theme ships Bootstrap's carousel JavaScript, not just its CSS.
- Diagnose a carousel that renders but does not advance.
- Keep image cache tags correct so slides invalidate with the files and image style.
