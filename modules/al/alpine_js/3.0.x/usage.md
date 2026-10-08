<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Alpine.js Library support makes Alpine available as a bundled Drupal library and, more usefully, guarantees that anything declared as an Alpine plugin loads *before* Alpine itself initialises.

---

Alpine is the low-ceremony choice for sprinkling behaviour into server-rendered markup, which makes it a natural fit for Drupal themes that do not want a build step or a framework. The catch is initialisation order: Alpine registers whatever plugins it can see when it starts, so a plugin loaded after Alpine has started simply does not exist. Drupal's library system has weights and dependencies but no notion of "this is an Alpine plugin", so the ordering has to be arranged by hand and breaks whenever aggregation or another module's library changes the sequence.

This module gives that relationship a name. A `hook_js_alter()` hands the page's JS list to `AlpineAssetService`, which pulls out every file tagged `attributes: { alpinejs: true }`, re-weights them, and appends Alpine (or the CSP build) last so it initialises after all plugins. A settings form at `/admin/config/development/alpinejs` controls delivery: load globally or on demand, header or footer, on admin routes or not, standard or CSP build, plus toggles for the six bundled official plugins (anchor, collapse, focus, intersect, persist, resize) and an experimental Drupal bridge. All Alpine code is shipped inside the module under `js/vendor/`; nothing is fetched from a CDN.

Practically it suits progressive-enhancement work: dropdowns, tabs, modals and form interactions written as HTML attributes rather than as a JavaScript application, and patterns where markup comes from Drupal and only the interaction is client-side. If a site already has a bundler and a component framework, this is not the layer it needs — the value is precisely in not having a build step.

---

- Add Alpine.js to a Drupal theme without a build step.
- Guarantee an Alpine plugin loads before Alpine initialises.
- Declare a theme library as depending on Alpine (`alpine_js/alpine_js`).
- Tag a single JS file as an Alpine plugin with `attributes: { alpinejs: true }`.
- Fix an Alpine plugin that silently does nothing because it loaded too late.
- Keep load order correct under JS aggregation / preprocessing.
- Write dropdown and modal behaviour in markup attributes.
- Progressively enhance server-rendered Drupal markup.
- Add interactivity to a paragraph or block component.
- Avoid pulling in a full front-end framework.
- Register a custom Alpine directive as a plugin via the `alpine:init` event.
- Enable individual official Alpine plugins (persist, intersect, focus, collapse, anchor, resize).
- Switch to the CSP-safe Alpine build for stricter Content-Security-Policy sites.
- Control whether Alpine loads globally, on demand, in the header, or in the footer.
- Keep Alpine off admin routes to avoid conflicts with admin-only libraries.
- Share Alpine between several modules on one site with correct ordering.
- Replace a hand-tuned library-weight hack.
- Diagnose Alpine behaviour that works locally but not with aggregation on.
- Enable the experimental Drupal bridge to get the `$dbg()` debug magic.
- Prototype interaction quickly in a Drupal theme.
- Decide whether a site needs Alpine or a bundler.
