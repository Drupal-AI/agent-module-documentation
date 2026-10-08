<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Container Queries Responsive Images (cqri) lets an image field pick its source based on the size of its containing DOM element rather than the browser viewport.

---

CQRI extends Drupal Core's Responsive Image system so that images respond to their container's inline size instead of the viewport width. It ships a `cqri` breakpoint group (cloned from Core's Responsive Image breakpoints), a `container_queries_responsive_image` field formatter that subclasses Core's `ResponsiveImageFormatter`, and custom theming that emits a `<container-picture>` custom element whose `<source>` tags carry a `container` attribute (a CSS container query such as `(min-width: 500px)`) instead of the usual `media` attribute. A bundled `container-picture-element` JavaScript library (loaded as an ES module from `/libraries/`) reads those `container` attributes at runtime and swaps the displayed source as the wrapping `.cqri-container` (which sets `container-type: inline-size`) grows or shrinks. This makes it ideal for Layout Builder / component-driven pages (e.g. Sobki, Drupal Starshot) where the section layout — not the window — determines how wide an image renders. Configuration mirrors Core Responsive Image exactly: build a responsive image style on the `cqri` breakpoint group with `sizes` mappings, then set the image field's display formatter to "Container queries responsive image". The module provides no routes, no permissions, and no admin settings form of its own.

---

- Render an image field so it responds to the width of its Layout Builder block instead of the viewport.
- Use container queries for responsive images in component-based / design-system page building.
- Serve a smaller image derivative when a card sits in a narrow sidebar and a larger one when the same component spans a full-width region.
- Reuse the same component in multiple region widths and let each instance choose an appropriately sized image automatically.
- Add a `container_queries_responsive_image` formatter to any `image` field via Manage display.
- Build responsive image styles on the provided `cqri` breakpoint group using `sizes` image-style mappings.
- Clone or adapt the shipped `container_query` responsive image style (large / medium / thumbnail derivatives) as a starting point.
- Emit a `<container-picture>` element with per-source `container` media conditions instead of viewport `media` queries.
- Wrap responsive images in a `container-type: inline-size` container so CSS container queries apply.
- Provide art-direction-like source switching driven by element size for grid and masonry layouts.
- Keep using Core image styles, fallback image styles, and alt/title handling while switching the selection criterion to container size.
- Support multi-column templates where the same image field appears at several widths on one page.
- Improve perceived performance by downloading the derivative that matches the actual rendered box, not the widest viewport case.
- Preserve width/height attributes on the fallback `<img>` so the browser can reserve aspect-ratio space and avoid layout shift.
- Pair with Layout Builder sections whose column count changes the container width at different breakpoints.
- Offer content editors a drop-in alternative to Core's Responsive Image formatter with identical configuration steps.
- Prototype container-query image behavior on Drupal 10 or 11 without hand-writing custom Twig or JavaScript.
- Drive responsive media inside off-canvas, modal, or dashboard panels whose width is independent of the viewport.
- Let themers style the `.cqri-container` wrapper to control which element establishes the query container.
- Serve appropriately sized images in reusable paragraphs/blocks embedded at varying widths across a site.
