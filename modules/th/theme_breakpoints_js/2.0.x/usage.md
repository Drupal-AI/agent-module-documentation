<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Theme Breakpoints for Javascript exposes a theme's declared breakpoints to JavaScript, so scripts test the same values the stylesheets use.

---

A responsive site defines its breakpoints once, in the theme's `*.breakpoints.yml`, and Drupal uses them for responsive images and for the breakpoint API. JavaScript that needs to know the viewport size — deciding whether to build a mobile menu, whether to initialise a slider, whether to lazy-load a map — cannot see them, so the width gets written into a script as a magic number. Then the design changes, the stylesheet's breakpoint moves, the script's does not, and there is a band of viewport widths where the CSS says mobile and the JavaScript says desktop. That bug is hard to find because it only appears between two widths nobody tests at. Exposing the declared breakpoints removes the duplication. Version **2.0.0**, and note the core requirement **`^11`** — Drupal 11 only, unusually narrow — depending on core `breakpoint`. Two implementation notes. The right way to test a breakpoint in JavaScript is **`window.matchMedia()`** with the same media query string the theme declared, not a `window.innerWidth` comparison: `matchMedia` accounts for the units the query actually uses, including `em`-based queries that move with the user's font size, and it fires an event on change rather than needing a resize listener. And **the values must reach the page as data rather than as code** — `drupalSettings` is the intended channel — so that a script does not have to be rebuilt when a breakpoint changes, which is the whole point.

---

- Test a breakpoint in JavaScript.
- Stop duplicating breakpoint values.
- Initialise a slider only on desktop.
- Build a mobile menu below a breakpoint.
- Keep CSS and JS breakpoints in step.
- Lazy-load a map on large screens.
- Avoid magic numbers in scripts.
- React to a viewport change.
- Support an em-based media query.
- Fix a mismatch between CSS and JS.
- Share theme breakpoints with a module.
- Decide behaviour by breakpoint.
- Support a responsive component.
- Avoid a resize listener.
- Keep breakpoints in one place.
- Adapt behaviour to screen size.
- Support a design system's breakpoints.
- Simplify responsive JavaScript.
