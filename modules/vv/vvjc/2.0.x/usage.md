VVJC adds a Views display format that renders result rows as an accessible, dependency-free vanilla-JavaScript 3D carousel.

---

VVJC (Views Vanilla JavaScript 3D Carousel) registers a single Views style plugin, `views_vvjc` ("Views Vanilla JavaScript 3D Carousel"), that lays out each Views row as a cell on a virtual 3D cylinder (CSS `rotateY` + `translateZ`). Front-end behavior runs inside a `<vvjc-carousel>` custom element built on the shared `vvj_core` foundation — no jQuery, no bundled framework. The format is configured entirely through the Views UI style-options form (dimensions, autoplay interval, controls, accessibility toggles, background color/opacity, responsive breakpoint, optional deep linking) and works with any Views row style (Fields or Content/entity rows). It ships five per-breakpoint CSS libraries, a set of accessibility affordances (ARIA live-region announcements, full keyboard navigation, `prefers-reduced-motion` handling, IntersectionObserver pause-when-offscreen), touch/swipe gestures, deep-linkable slide fragments, `[vvjc:FIELD]` Views tokens for header/footer/empty text areas, and a `Drupal.vvjc.*` JavaScript API for programmatic control. It is display-only: Views still performs all filtering, sorting, access checking and caching.

---

- Turn a View of featured content into a rotating 3D carousel on the front page.
- Give a small set of promoted items visual prominence in perspective.
- Present equally-optional items (sponsors, partner logos) in gentle rotation.
- Replace a jQuery carousel plugin with a lightweight vanilla-JS format.
- Build a product highlight carousel from a commerce product View.
- Show a photo gallery as a 3D carousel using entity/teaser rows.
- Add a "Featured Articles" carousel block (see the shipped `vvjc_example` block display).
- Configure autoplay from 2 s to 15 s, or disable auto-rotation entirely.
- Offer play/pause, navigation arrows, a slide counter and a progress bar independently.
- Provide dot navigation, with a scrollable dots variant for many slides.
- Enable deep linking so individual slides get shareable `#carousel3d-<id>-<n>` URLs.
- Respect `prefers-reduced-motion` by pausing rotation and disabling transitions.
- Announce slide changes to screen-reader users through an ARIA live region.
- Support full keyboard control (arrows, Space, Home, End), RTL-aware.
- Enable touch/swipe gestures for mobile visitors.
- Pause the carousel on hover, on tab switch, and when scrolled out of the viewport.
- Tune the 3D look via width preset, per-screen heights, and CSS perspective.
- Set a per-item background color with adjustable opacity, or disable it.
- Pick a responsive breakpoint (576/768/992/1200/1400 px) for the layout shift.
- Inject first-row field values into a View's header/footer/empty text with `[vvjc:field]` tokens.
- Drive carousels from custom JS via `Drupal.vvjc.goToSlide/next/prev/pause/resume`.
- Read the built-in help (rendered README) at `/admin/help/vvjc`.
- Upgrade a 1.x carousel View in place — plugin ID, option keys and CSS classes are preserved.
- Theme the carousel by overriding `views-view-vvjc.html.twig` or targeting the stable `.vvjc*` classes.
- Combine with a Views contextual filter to build per-entity related-content carousels.
