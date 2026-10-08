<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Y LB Hero (lb_hero) — agent index

Full-width **hero block type** for YMCA Layout Builder pages. Version **2.0.3**.
Core `^9 || ^10 || ^11`. Depends on `y_lb`.

**Two things that matter more here than for other components:** it is almost always the page's
**largest contentful paint** (responsive config is the highest-value performance lever; preload it),
and **text over a photograph is a structural contrast problem** — overlay, scrim or constrained text
area, because the image is what editors change.

On a multi-location site the second compounds: **dozens of branches choosing their own hero image**
means the design must hold for images nobody reviewed.

**Documented from source — cannot be enabled** (the `y_lb` Packagist stub; see `modules/y_/y_lb`).