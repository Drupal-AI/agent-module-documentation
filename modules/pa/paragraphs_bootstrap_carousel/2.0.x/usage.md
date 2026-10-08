<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Paragraphs Bootstrap Carousel adds a field formatter, "Paragraphs boostrap carousel", that renders a Paragraphs reference field as a Bootstrap 5 carousel — one slide per referenced paragraph, each with an image and an optional caption and click link.

---

The mechanism is a `FieldFormatter` (`paragraphs_bootstrap_carousel_formatter`) applied to an `entity_reference_revisions` field, not a block or a Views style. You point it at a paragraphs field, choose which paragraph fields supply the image, caption and link, and it emits Bootstrap-5 carousel markup through its own Twig template. The module ships an example `bootstrap_carousel` paragraph type (`field_image`, `field_caption`, `field_link`) so it works immediately, but any paragraph type with an image field works because the formatter reads whichever fields you map. Formatter settings cover interval, pause-on-hover, indicators, controls, loop, image style, an image class (fluid/circle), and a custom class. Markup renders on any theme, but rotation needs Bootstrap's carousel JavaScript; if the theme is not Bootstrap-based, turn on the `cdn` setting to attach the bundled Bootstrap 5.2.3 CDN library. It fits a site whose pages are assembled from paragraphs and whose theme is already Bootstrap 5. As with every carousel, auto-advancing slides are a WCAG concern unless pausable, and controls need accessible names — the template provides visually-hidden labels and a pause-on-hover option, so verify both suit your content.

---

- Render a paragraphs field as a slideshow.
- Add a carousel component built from paragraphs.
- Turn slide paragraphs into a Bootstrap 5 carousel.
- Build a hero slider on a Bootstrap-themed site.
- Give editors an image carousel with captions.
- Make each slide clickable via a link field.
- Add prev/next controls and indicator dots to slides.
- Set the auto-advance interval per carousel.
- Pause the carousel on mouse hover.
- Loop slides continuously.
- Apply an image style to carousel images.
- Use fluid or circular image styling on slides.
- Reuse Bootstrap's own carousel markup and CSS.
- Load Bootstrap from a CDN on a non-Bootstrap theme.
- Add a testimonial or partner-logo rotator.
- Build a product highlights slider.
- Reorder slides by dragging paragraphs.
- Render the whole paragraph as the caption via a view mode.
- Map a plain caption field instead of a view mode.
- Match carousel markup to a Bootstrap 5 theme.
- Add a marketing landing-page hero without custom code.
- Show a responsive photo carousel using a responsive image style.
