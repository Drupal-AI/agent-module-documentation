<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AOS (module machine name `aos`) integrates the AOS (Animate On Scroll) JavaScript library so page elements animate as they scroll into view.

---

AOS wires Michal Sajnog's **AOS (Animate On Scroll)** library into Drupal. It defines one asset
library (`aos`) that loads AOS 3.0.0-beta.6 CSS + JS from the cdnjs CDN (or from a local
`libraries/aos` copy when present) and a tiny `Drupal.behaviors.aos` behavior that calls
`AOS.init()`. The project directory is `aos-aos` and the **module machine name is `aos`**, in the
*Other* package, core `^9 || ^10 || ^11`. It has **no configuration UI, no routes, no
permissions, no services and no config schema** — you opt elements in purely with `data-aos`
HTML attributes in your templates/markup, then attach the `aos/aos` library so the JS runs.
It is a front-end/theming feature that affects presentation only.

---

- Fade a hero image or headline in as the visitor scrolls it into view.
- Slide content blocks in from the left/right (`data-aos="fade-left"` / `fade-right"`).
- Zoom cards or teasers in with `data-aos="zoom-in"`.
- Animate Views rows or grid items as they enter the viewport by adding `data-aos` to the row template.
- Stagger a list's items using per-element `data-aos-delay` values.
- Tune each element's motion with `data-aos-duration`, `data-aos-easing` and `data-aos-offset`.
- Trigger the animation earlier/later by setting `data-aos-offset` (pixels before the trigger point).
- Play an animation only once with `data-aos-once="true"`.
- Add scroll reveals to a custom block's body markup.
- Animate field output by adding `data-aos` in a field or entity Twig template.
- Provide subtle entrance effects on a landing page without writing custom JS.
- Attach the library site-wide from a theme's `.info.yml` `libraries:` key.
- Attach the library on specific render arrays via `#attached['library'][] = 'aos/aos'`.
- Serve the AOS assets locally (offline / privacy) by unpacking the library into `libraries/aos`.
- Keep loading AOS from cdnjs CDN with zero library download for a quick setup.
- Use minified local assets, or turn off `minified` when installing via asset-packagist (per README).
- Give menus, footers or CTAs a scroll-in entrance for polish.
- Reveal timeline / step sections progressively as the user scrolls down.
- Re-run animations when scrolling back up (default AOS behavior — elements reset above the fold).
- Apply consistent, declarative animations across a theme without per-component JavaScript.
