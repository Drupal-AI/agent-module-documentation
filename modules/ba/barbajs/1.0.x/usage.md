Barba JS integrates the Barba.js library so Drupal pages transition smoothly, SPA-style, without a full front-end framework.

---

Barba JS bundles the Barba.js UMD builds (core plus the CSS, Prefetch and Router plugins) and attaches the core library to every front-end page. Loading prefers a local build — the module's own `dist/` directory or a `/libraries/barba` install — and falls back to the pinned jsDelivr CDN when no local file is present. The base module adds no permissions, routes or config; you supply the actual transition behaviour in your theme or a custom module by calling `barba.init(...)`. Enable the optional Barba JS UI submodule to turn auto-loading into a configurable admin form: switch loading on or off, pick Local vs CDN, choose the minified (deployment) or non-minified (development) variant, toggle each plugin, and restrict attachment to specific themes or path patterns (with a `?barba=no` query override to disable per request).

---

- Add fluid, animated page-to-page transitions to a content site without adopting a SPA framework.
- Give portfolios, blogs and marketing sites a smoother perceived-performance feel on navigation.
- Load Barba.js core automatically on all front-end pages with zero configuration (base module only).
- Serve Barba from a locally installed build under `libraries/barba/dist/` for CDN-free / offline deployments.
- Fall back to the official jsDelivr CDN automatically when no local build is available.
- Write custom `leave`/`enter` transition hooks in your theme's JavaScript (e.g. GSAP fades).
- Use the Barba CSS plugin to drive transitions with helper CSS classes instead of JS timelines.
- Enable the Prefetch plugin to preload linked pages on hover for faster navigation.
- Enable the Router plugin to define route-based transition rules.
- Switch between minified (production) and non-minified (development) builds from one setting.
- Turn Barba loading globally on or off from the admin UI without uninstalling the module.
- Restrict Barba to only your public theme and keep it off the Claro/Gin admin theme.
- Load Barba on all themes except a selected admin theme using the "all except" theme mode.
- Limit Barba to a specific set of pages (e.g. only `/blog/*`) via path patterns.
- Exclude Barba from admin, node-edit, IMCE, batch and AJAX paths (the shipped default page list).
- Disable Barba for a single request by appending `?barba=no` to the URL (e.g. for debugging).
- Combine CSS + Prefetch + Router plugins selectively per site from checkboxes.
- Pin the exact Barba versions your site was tested against (core 2.10.3, css 2.1.16, prefetch 2.2.0, router 2.1.11).
- Avoid loading the library twice by disabling auto-load when a theme already includes Barba.
- Provide editors a smoother browsing experience on documentation or catalogue sites.
- Prototype page transitions quickly, then move transition code into a theme for production.
