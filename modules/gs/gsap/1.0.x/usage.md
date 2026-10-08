<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
GSAP integrates the GreenSock Animation Platform into Drupal. It registers GSAP core and every GreenSock plugin as Drupal asset libraries a theme or module can attach as `gsap/<name>`, and — unusually for a library-integration module — lets site builders author animations as config entities in the admin UI instead of writing JavaScript.

---

`gsap.libraries.yml` declares GSAP core plus 22 plugin libraries (ScrollTrigger, Flip, Draggable, MotionPath, MorphSVG, SplitText, DrawSVG, ScrambleText, Inertia, Physics2D, the custom-easing set and more), so a front end can depend on exactly the plugins it needs, e.g. `- gsap/scrolltrigger`. On the Drupal side, animations are modelled as a `gsap` config entity with full CRUD: a collection at `/admin/structure/gsap`, add/edit/delete forms, and a global settings form at `/admin/config/content/gsap`, all gated by the single `administer gsap` permission. Each entity names a CSS selector, a `to`/`from` direction, a trigger (`click`, `hover`, or `scrollTrigger`), and a JSON payload validated against an allowlist of GSAP and CSS properties; `js/animations.js` reads them from `drupalSettings` and builds the tweens. The settings form controls whether GSAP loads on every page (`include_gsap`), which plugin libraries load globally (`include_libs` + `libs`), and any admin-defined `custom_libs` (each exposed as `gsap/<key>`). Config-entity animations activate only when GSAP is enabled globally. Library JS is served from the jsDelivr CDN by default; a shipped `composer.libraries.json` installs `greensock/gsap 3.13.0` locally for sites that override the definitions to self-host.

---

- Register GSAP and its plugins as attachable Drupal asset libraries.
- Depend on a specific plugin (e.g. ScrollTrigger) from a theme's `.libraries.yml`.
- Add scroll-triggered animation to a Drupal site.
- Configure animations through the admin UI instead of writing code.
- Attach only the GSAP plugins a page actually needs.
- Animate elements as they enter the viewport.
- Trigger an animation on click or hover.
- Give a marketing site motion without a custom build step.
- Let a site builder create animations without JavaScript.
- Reuse an animation definition across pages as exportable configuration.
- Load GSAP and selected plugins globally for developer JavaScript.
- Register a custom or premium GSAP plugin as a library via the admin form.
- Morph SVG shapes on interaction.
- Split text for per-character animation.
- Make an element draggable.
- Animate along a motion path.
- Apply custom easing curves.
- Restrict animation authoring to a single permission.
- Serve GSAP from a local library instead of the CDN.
- Add parallax effects to a landing page.
- Debug animations with GSDevTools or ScrollTrigger markers.
- Animate a PixiJS canvas from Drupal.
- Adopt GSAP without committing to a decoupled front end.
