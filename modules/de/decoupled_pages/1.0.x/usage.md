<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Decoupled Pages lets you declare a Drupal route that serves an empty page shell for a JavaScript single-page application (SPA) to mount onto, without writing a controller.

---

Decoupled Pages turns any module route into an SPA host by adding a `_decoupled_page_main` route default whose value is an asset library ID. A routing event subscriber validates the definition and installs the module's internal controller, which renders `<div id="decoupled-page-root">` in the active theme's main content region and attaches the named library. You can attach extra CSS/JS with the `_decoupled_page_assets` option, register in-app deep-link paths with `_decoupled_page_paths` (each cloned into its own route serving the same shell), and pass backend configuration to the frontend as HTML `data-*` attributes via the `_decoupled_page_data` route default or a custom data provider service. It is a progressive-decoupling / developer tool: it does not manage access (the route's own `requirements` do), and the SPA's data access (JSON:API/REST) is handled separately. A `decoupled_pages_test` example submodule demonstrates every feature.

---

- Mount a React, Vue, Ember, or vanilla-JS SPA at a chosen Drupal path.
- Progressively decouple a Drupal site — full SPAs on some routes, Drupal rendering elsewhere.
- Define an SPA host route with only YAML, no PHP controller.
- Point a route at an existing asset library with `_decoupled_page_main: your_module/app`.
- Use the built-in `decoupled_pages/route_test` library to smoke-test a route before writing your own.
- Attach extra stylesheets/scripts to a page with the `_decoupled_page_assets` route option.
- Register client-side deep links (e.g. `/app/settings`) as extra Drupal-served paths via `_decoupled_page_paths`.
- Pass an API base path or feature flags to the SPA as static `data-*` attributes with `_decoupled_page_data`.
- Compute per-request `data-*` attributes (e.g. from a query parameter) with a custom data provider service.
- Read backend config in JS from `document.getElementById('decoupled-page-root').dataset`.
- Keep an SPA inside the site theme's page shell (header/footer/regions) rather than a bare HTML document.
- Gate SPA host routes with normal Drupal route access requirements (`_permission`, `_role`, `_access`, etc.).
- Serve the same SPA shell from several URLs so client-side routes are directly linkable/bookmarkable.
- Add proper cacheability to dynamic data via `Dataset::cacheVariable()` with cache contexts/tags.
- Prototype a decoupled feature quickly, then swap the placeholder library for your real build output.
- Reuse one SPA library across multiple routes with different injected data attributes.
- Provide a data provider service shared by many decoupled routes through the `decoupled_pages_data_provider` service tag.
- Learn the full API from the shipped `decoupled_pages_test` example module.
- Enforce GET-only handling on SPA host routes (the module defaults to `GET` when no methods are declared).
