<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Y LB Accordion (lb_accordion) — agent index

Collapsible-panel **block type** for YMCA Layout Builder pages. Version **3.1.0**.
Core `^9 || ^10 || ^11`. Depends on `y_lb` (now `^4.0 || ^5.0` via composer), plus
`paragraphs` and `block_content`.

The block (`lb_accordion`) holds an ordered set of **`accordion_item`** sub-blocks,
each a title + body pair. An **"Is FAQ?"** flag emits a `FAQPage` JSON-LD schema in
the page head (front end only, not in Layout Builder preview). Rendering is a custom
Twig template using Bootstrap 5 collapse markup.

Suits **independent** items (FAQs, membership options); suits narrative badly.

**Accessibility requirements, specific and most often missed:** headers are real
**buttons**, `aria-expanded` reflecting state, `aria-controls` pointing at the panel,
keyboard-reachable content. A click-only accordion is content a keyboard user cannot open.

**Documented from source — cannot be enabled** (the `y_lb` Packagist stub; see `modules/y_/y_lb`).
