<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
WOW JS integrates the WOW.js library so Animate.css animations play as elements scroll into view.

---

The module comes in two parts. The base **WOW JS** module is code-first: enable it, add the class `wow` together with an Animate.css class (keep the `animate__` prefix, e.g. `<section class="wow animate__slideInLeft">`), and it initializes WOW.js for you — no `new WOW().init()` in your own JavaScript, and no settings page. It depends on the **AnimateCSS** module (`drupal/animatecss`) for the animation CSS. The WOW.js JavaScript library itself is **not bundled**: place it at `/libraries/wow/dist/wow.min.js` (download `https://github.com/matthieua/WOW/archive/master.zip`, extract, rename to `wow`) and the module serves it locally; if it is missing the module automatically falls back to a **jsDelivr CDN** copy, and the Status Report flags this as a dismissible warning. The optional **WOW JS UI** submodule (`wowjs_ui`, depends on AnimateCSS UI) adds a point-and-click layer: it injects a "WOW settings" / "WOW default options" panel into the AnimateCSS settings page — choose local vs CDN, minified vs source, and the WOW defaults (`offset`, `mobile`, `live`, `once`, `mirror`, scroll container, reset) stored in the `wowjs.settings` config object — and adds per-animation **Once**/**Mirror** toggles to the AnimateCSS *Add animation* form so non-coders can turn WOW on for specific selectors. Two things are worth confirming for any scroll-animation build: that the site still honors the operating-system `prefers-reduced-motion` setting (moving content triggers real motion sickness/vertigo for some visitors), and that content is not left invisible if the script fails to run.

---

- Fade content in on scroll.
- Add scroll-reveal animations to a page.
- Animate sections as they enter the viewport.
- Give a long page visual rhythm.
- Highlight a call to action as it scrolls into view.
- Animate cards into place on scroll.
- Add motion to a landing page.
- Reveal statistics or counters as they appear.
- Animate a feature list on scroll.
- Add polish to a marketing page.
- Stagger entrance animations down a page.
- Signal that there is more content below.
- Animate an image gallery's entry.
- Add subtle motion to a homepage hero.
- Implement a design's scroll-animation spec.
- Configure WOW defaults without writing JavaScript (via WOW JS UI).
- Enable WOW per element from the AnimateCSS add-animation form.
- Load WOW.js locally or from a CDN as a fallback.
- Switch between minified (production) and source (development) library builds.
- Set a trigger offset so animations fire slightly before elements are fully visible.
- Enable or disable animations on mobile devices.
- Animate testimonials into view.
- Add entrance effects to individual sections.
- Use a custom scroll container instead of the window.
