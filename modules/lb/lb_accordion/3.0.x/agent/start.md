<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Y LB Accordion (lb_accordion) — agent index

Collapsible-panel **block type** for YMCA Layout Builder pages. Version **3.0.0**.
Core `^9 || ^10 || ^11`. Depends on `y_lb`.

Suits **independent** items (FAQs, membership options); suits narrative badly.

**Accessibility requirements, specific and most often missed:** headers must be real **buttons**,
`aria-expanded` reflecting state, `aria-controls` pointing at the panel, keyboard-reachable content.
A click-only accordion is content a keyboard user cannot open.

**Documented from source — cannot be enabled** (the `y_lb` Packagist stub; see `modules/y_/y_lb`).