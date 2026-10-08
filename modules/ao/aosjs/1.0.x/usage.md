AOS JS integrates Michał Sajnóg's [AOS](https://github.com/michalsnik/aos) ("Animate On Scroll") JavaScript library with Drupal, letting elements animate as they scroll into and out of view via `data-aos` HTML attributes.

---

The base module registers AOS as Drupal asset libraries (`aosjs/aos-v2.js`, `aos-v2.cdn`, `aos-v3.js`, `aos-v3.cdn`, plus an `aos.init` initializer) and, when neither the `aosjs_ui` nor `animatecss_aos` module is enabled, auto-attaches AOS to every non-install page through `hook_page_attachments()`. It prefers a locally installed copy at `libraries/aos` (detected by `aosjs_check_installed()`) and falls back to the Cloudflare/unpkg CDN when the local files are absent. Initialization is a bare `AOS.init()` in `js/aosjs.init.js` (a `Drupal.behaviors` behavior), so out of the box you animate elements purely by adding markup attributes like `data-aos="fade-up"`, `data-aos-duration`, `data-aos-easing`, and `data-aos-offset`. The module also exposes PHP option helpers — `aosjs_animation_names()`/`aosjs_animation_options()` (fade, flip, slide, zoom groups, extensible via `hook_aos_animation_names()`), `aosjs_easing_functions()`, `aosjs_anchor_placements()`, and `aosjs_disable_options()` — that the optional `aosjs_ui` submodule uses to build its selector-management admin UI. There are no permissions, no config, and no configuration route on the base module. Two submodules extend it: `aosjs_ui` (a settings/selector CRUD admin UI that attaches animations to CSS selectors without markup edits) and `aosjs_animatecss` (swaps AOS's animation set for the Animate.css library).

---

- Add scroll-triggered fade/slide/zoom/flip animations to a Drupal site with no custom JS.
- Animate a block or region by adding `data-aos="fade-up"` to its markup or Twig template.
- Fade content in as the visitor scrolls down a long landing page.
- Reveal cards or teasers with a staggered effect using per-element `data-aos-delay`.
- Control animation speed per element with `data-aos-duration`.
- Change the easing curve of an animation with `data-aos-easing` (e.g. `ease-in-sine`).
- Offset when an animation triggers relative to the viewport with `data-aos-offset`.
- Anchor an element's animation to another element via `data-aos-anchor` / anchor placement.
- Serve the AOS library from a self-hosted `libraries/aos` copy instead of a CDN for privacy/offline use.
- Use AOS v2 or the v3 beta by attaching the corresponding library.
- Let the module auto-load AOS site-wide simply by enabling it (no UI submodule needed).
- Provide animation/easing/anchor option lists to a custom form via the `aosjs_*` PHP helpers.
- Add custom animation groups by implementing `hook_aos_animation_names()`.
- Emphasize a call-to-action as it enters the viewport.
- Animate images in a gallery as the user scrolls.
- Add subtle motion to marketing pages without a page builder.
- Attach animations to arbitrary CSS selectors (no markup change) by enabling the `aosjs_ui` submodule.
- Replace AOS's built-in animations with Animate.css effects via the `aosjs_animatecss` submodule.
- Reuse a single lightweight animation library across an entire theme.
- Disable animations on phone/tablet/mobile breakpoints via AOS's `disable` option (through `aosjs_ui`).
