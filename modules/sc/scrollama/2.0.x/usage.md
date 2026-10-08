<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Scrollama loads the [scrollama.js](https://github.com/russellgoldenberg/scrollama) library and exposes a simple `data-*`-attribute API that toggles CSS classes on HTML elements as they enter or exit a fixed scroll point, for scroll-triggered animations ("scrollytelling").

---

The module ships two Drupal asset libraries — `scrollama/scrollama` (the behavior plus the CDN-hosted scrollama 2.2.1 and an intersection-observer polyfill) and `scrollama/scrollama-css` (a small stock stylesheet with `fade-in`/`fade-out`/`slide-in`/`slide-out` transitions). Both are **off by default**: you either attach them from your own code where needed, or turn them on globally at the settings page (`/admin/config/system/scrollama`, permission `administer scrollama configuration`). At runtime `Drupal.behaviors.scrollama` reads every element carrying `data-scroll-init`, sets up a single scrollama scroller at the configured `offset` (default 0.75 of the viewport), and on step-enter adds the `data-scroll-init` class list (after any `data-scroll-delay` seconds), on step-exit adds the optional `data-scroll-exit` classes. Global settings (`offset`, `debug`, `order`, `once`, and whether to load each library) are stored in the `scrollama.settings` config object and passed to JS as `drupalSettings.scrollama`. The scroll point is fixed at the `offset` fraction; `once` fires each trigger a single time, `order` replays earlier triggers when a visitor lands mid-page, and `debug` draws the scroll line and logs element data to the console. The module supplies no field, formatter, block, or entity — it is a thin, front-end helper you drive from markup and CSS.

---

- Fade an element in as it scrolls into view by adding `data-scroll-init="fade-in"`.
- Fade an element out on exit with `data-scroll-exit="fade-out"`.
- Slide an element up into place with the shipped `slide-in` class.
- Delay a scroll-triggered animation by N seconds with `data-scroll-delay="2"`.
- Apply several classes at once, e.g. `data-scroll-init="fade-in highlight"`.
- Build a scrollytelling article where sections animate as the reader progresses.
- Trigger a CSS-only animation without writing any JavaScript.
- Attach `scrollama/scrollama` to a specific block or view so the library loads only where used.
- Load the library site-wide for prototyping by enabling it globally on the settings form.
- Enable the stock animation stylesheet (`scrollama/scrollama-css`) for ready-made fade/slide effects.
- Tune when triggers fire by changing the viewport `offset` (0 = top, 1 = bottom).
- Replay all earlier triggers for visitors who deep-link into a scrolled page (`order`).
- Fire each trigger only once per visit to avoid repeated animations (`once`).
- Turn on `debug` mode to visualize the scroll line and inspect element data in the console.
- Add class-based reveal effects to a Layout Builder or paragraph component's wrapper markup.
- Progressively reveal a long form or checklist as the user scrolls.
- Pin-and-reveal marketing sections on a landing page.
- Animate infographic steps in sequence as each scrolls past the trigger line.
- Use the provided CSS as a reference to write your own enter/exit transitions.
- Avoid jQuery/heavy animation libraries by relying on the lightweight IntersectionObserver-based scroller.
- Conditionally attach the library from a preprocess hook or `#attached` so it never loads on unrelated pages.
