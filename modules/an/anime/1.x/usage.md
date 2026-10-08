Anime is a thin Drupal integration that loads the Anime.js JavaScript animation library site-wide so your own theme or module JavaScript can call `anime()`.

---

Anime.js is a lightweight animation engine that drives CSS properties, SVG, DOM attributes and plain JavaScript objects through one small API. This module does nothing more than make that library available to Drupal: on every page it attaches either a locally installed copy (`/libraries/anime/lib/anime.min.js`) or, when no local copy is found, the anime.js 3.2.2 build served from cdnjs. It ships no configuration UI, routes, permissions, services or plugins — the animations themselves are written in your own JS. A status-report requirement tells you whether the library is being served locally or from the CDN and which version was detected. When the separate `anime_ui` module is enabled, that module takes over asset loading and this module stops attaching the library itself.

---

- Enable the module to make the `anime` global available on every front-end and admin page.
- Install the library locally at `/libraries/anime/lib/anime.min.js` to serve it from your own domain instead of the CDN.
- Rely on the automatic cdnjs fallback (anime.js 3.2.2) during quick prototyping without downloading anything.
- Animate a block or region on scroll or load from a theme's custom JavaScript.
- Translate, rotate, scale or fade DOM elements with a single `anime({...})` call.
- Animate SVG paths (line drawing, morphing) for logos, icons or infographics.
- Build staggered "follow-through" animations across a list of cards or menu items.
- Layer multiple CSS transforms with independent timings on one element.
- Drive numeric counters / odometer effects by animating a plain JavaScript object's property.
- Add hover or click micro-interactions to buttons and calls-to-action.
- Sequence multi-step intro animations using Anime.js timelines.
- Use play / pause / reverse / seek controls and completion callbacks in a custom Drupal behavior.
- Animate form validation feedback or wizard step transitions.
- Create loading spinners or progress indicators without extra plugins.
- Animate CSS custom properties (variables) to theme transitions.
- Coordinate animations from a `Drupal.behaviors` script so they re-run on AJAX-loaded content.
- Check `admin/reports/status` to confirm whether Anime.js is local or CDN-served and see the detected version.
- Provide a consistent animation library shared by several custom modules/themes on the same site.
- Prototype an animated landing page inside a custom template quickly.
- Serve the library from a local copy to satisfy strict Content-Security-Policy / offline requirements.
- Hand off to the companion `anime_ui` module (if installed) to manage library loading via its own UI.
