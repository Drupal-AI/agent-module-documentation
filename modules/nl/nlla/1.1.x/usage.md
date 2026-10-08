<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Native Lazy Load Animation animates elements marked `loading="lazy"` so they fade or reveal as the browser finishes loading them.

---

This is a small front-end module. It attaches a library (`native_lazy_load_animation.libraries.yml`) of CSS and JS that hooks the native `loading="lazy"` behaviour on images (and iframes) and applies a load-in animation once each element's `load` event fires. There is no configuration form, route, permission, service, or block — enabling the module attaches the assets sitewide.

Because it relies on the browser's built-in lazy-loading attribute rather than a JavaScript IntersectionObserver polyfill, it stays lightweight. It has no server-side surface and no user input, so there is nothing to secure beyond normal asset delivery; customisation is done by overriding the module's CSS in your theme.

---
- Fade images in smoothly as they lazy-load into view.
- Add a subtle reveal animation to below-the-fold media.
- Improve perceived performance with load-in transitions.
- Animate iframes that use `loading="lazy"`.
- Enhance native lazy loading without a heavy JS library.
- Apply a consistent load animation sitewide by enabling the module.
- Override the animation via theme CSS.
- Reduce abrupt content pop-in on long pages.
- Keep animations tied to actual load completion, not scroll guesses.
- Pair with Drupal core's responsive image lazy loading.
- Give image-heavy landing pages a polished feel.
- Avoid custom JavaScript for a common visual effect.
- Keep the front-end footprint minimal.
- Ship a decorative effect with zero configuration.
- Complement gallery or grid layouts with staggered reveals.
- Enhance UX on media galleries and article bodies.
