<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AnimateCSS integrates the [Animate.css](https://animate.style/) library (v4.1.1) of ready-to-use, cross-browser CSS animations into Drupal. The base module simply attaches the library to every page so you can add `animate__animated animate__<name>` classes in templates/markup; the optional AnimateCSS UI submodule adds a full admin UI to bind animations to CSS selectors without writing code.

---

The base `animatecss` module defines the `animate.css` (local, `/libraries/animate.css/animate.min.css`) and `animate.cdn` (cloudflare v4.1.1) asset libraries and, in `hook_page_attachments()`, attaches one of them to every page **only when the `animatecss_ui` submodule is not installed** — using the local copy if `animatecss_check_installed()` finds `/libraries/animate.css/animate.min.css`, otherwise falling back to the CDN. `hook_requirements()` reports whether the library is local or CDN, with a "silent" config flag to suppress the warning. The module also exposes a set of procedural helper functions that return option lists for building animation forms: `animatecss_animation_names()` (the full catalog of ~90 animations grouped as attention seekers / entrances / exits across back, bouncing, fading, flipping, lightspeed, rotating, specials, zooming, sliding), plus `animatecss_animation_options()`, `animatecss_delay_options()`, `animatecss_speed_options()`, `animatecss_repeat_options()`, `animatecss_event_options()`, and `animatecss_scroll_options()`. Two hooks let other modules extend it: `hook_animatecss_animation_names()` (add custom animation names) and `hook_animatecss_scroll_options()` (register a scroll-reveal library). The base module has no config, no permissions, and no `configure` route of its own — those live in `animatecss_ui`.

---

- Load the Animate.css library on every page just by enabling the module.
- Add entrance animations (fadeIn, slideInUp, zoomIn, backInDown, bounceIn…) to elements via CSS classes.
- Add exit animations (fadeOut, slideOutDown, zoomOut, hinge…) to elements.
- Use attention-seeker animations (bounce, flash, pulse, shakeX, tada, jello, heartBeat…) for emphasis.
- Animate a heading or hero on the home page with `animate__animated animate__bounce`.
- Trigger animations from JavaScript by toggling `animate__animated animate__<name>` classes.
- Serve Animate.css from a self-hosted `/libraries/animate.css/` copy instead of the CDN.
- Fall back to the cloudflare CDN automatically when the library is not installed locally.
- Suppress the "library not installed" status warning via the silent flag (with UI submodule).
- Add custom animation names to the catalog with `hook_animatecss_animation_names()`.
- Register a scroll-reveal library's options with `hook_animatecss_scroll_options()`.
- Build a settings form using the module's animation/delay/speed/repeat/event option helpers.
- Apply delay classes (delay-1s … delay-5s) to stagger animations.
- Apply speed modifiers (slow, slower, fast, faster) to tune animation duration.
- Provide consistent cross-browser animation classes across a theme.
- Add attention-guiding hints to sliders, callouts, and CTAs.
- Enable the AnimateCSS UI submodule to bind animations to selectors from the admin UI (no theming).
- Use the base module alone (no UI) when you only need the library attached and will add classes in templates.
- Combine with scroll-triggered libraries (AOS/WOW) via the UI submodule's per-selector options.
- Prototype motion quickly on any element by adding two classes.
