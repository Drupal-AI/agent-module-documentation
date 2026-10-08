<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
htmx integrates the [HTMX](https://htmx.org) JavaScript library with Drupal 11, giving themers and developers server-side helpers to add `hx-*` attributes, emit HTMX response headers, expose HTMX-friendly routes, and lazy-load blocks and paginated Views over AJAX-style partial page swaps — without writing custom JavaScript. Version 2.0.x targets Drupal **11.3+** and builds directly on the full HTMX integration that now ships in Drupal core.

---

The module's core developer surface is a Twig function **`create_htmx()`** (registered by `HtmxTwigExtension`) which returns a **`HtmxAttributeBuilder`** — a `\Stringable` proxy that forwards every call to core's **`Drupal\Core\Htmx\Htmx`** class. You chain the builder (`->get($url)->target('#x')->swap('outerHTML')->trigger('click')…`) and cast it to a string to emit Drupal-safe `data-hx-*` attributes covering the full HTMX reference (get/post/put/patch/delete, target, swap, select, trigger, vals, headers, boost, confirm, pushUrl, sync, indicator, and more). In PHP you use core's `Htmx` class directly: build attributes and `HX-*` response headers on one object, then `->applyTo($build)` to attach attributes, HTTP headers, and the htmx library to a render array. Routes flagged with the `_htmx_route: true` option render through core's **SimplePageVariant** (a bare page shell, no blocks/regions) so responses are swap-ready; the module ships such routes for viewing an entity in a view mode (`/htmx/{entityType}/{entity}/{viewMode}`, gated by `entity.view` access) and for rendering a configured block. On an `HX-Request` the admin toolbar is stripped from the response. For site builders it adds an **HTMX Block** config entity (`htmx_block`, managed at `/admin/structure/htmx-block`, permission *administer htmx_block*) plus an **HTMX Loader** block plugin (`htmx_loader`) that swaps a placeholder for a configured HTMX block when a chosen event fires (with delay/throttle/target/filter/from/consume options). For Views it provides an **HTMX display** plugin (`htmx`, a simple-page display exposing a URL for HTMX requests, with exposed-filter swaps) and an **HTMX mini pager** (`htmx_mini`) that pages a view in place via `hx-get` swaps. It re-uses core's off-canvas dialog styles for its admin UI. **Major change from 1.5.x:** this module's own `HtmxAttribute` and `HtmxResponseHeaders` classes were removed — everything now delegates to core's `Drupal\Core\Htmx\Htmx`; the older `htmx/drupal` library is deprecated in favour of `core/htmx`. A companion **htmx_debug** submodule un-minifies core's htmx library and enables the `debug` htmx extension for console logging.

---

- Add `hx-get`/`hx-target`/`hx-swap` attributes to a Twig template link so it loads a fragment in place.
- Build a "load more" button that fetches and appends the next chunk of content.
- Lazy-load an expensive block only when it scrolls into view (the `revealed` event).
- Turn a Views listing into an in-place AJAX-paged list with the HTMX mini pager.
- Expose a View at a clean URL for HTMX partial requests via the HTMX display plugin.
- Render an entity in a chosen view mode over HTMX at `/htmx/{type}/{id}/{viewMode}`.
- Submit an exposed Views filter form via HTMX and swap only the results container.
- Emit an `HX-Redirect` header from a controller to redirect the client after an action.
- Fire an `HX-Trigger` event from the server to notify other elements to refresh.
- Push a new URL into the browser history after an HTMX swap (`hx-push-url` / HX-Push-Url).
- Add a confirmation dialog before an HTMX request with `->confirm('Are you sure?')`.
- Progressive-enhance normal links/forms with `hx-boost` for AJAX navigation.
- Poll an endpoint on an interval with an `hx-trigger` timing declaration.
- Include extra element values or JSON `vals` with an HTMX request.
- Retarget or reswap a response server-side (`HX-Retarget` / `HX-Reswap`).
- Configure an HTMX Loader block to replace itself when a custom event fires.
- Manage reusable HTMX block definitions at /admin/structure/htmx-block.
- Debug HTMX behavior with the un-minified library and the debug extension (htmx_debug submodule).
- Show a loading indicator element during an HTMX request (`hx-indicator`).
- Synchronize competing requests between elements with `hx-sync`.
- Build a bare "simple page" response (no regions) for swap-ready fragments via `_htmx_route`.
- Keep the admin toolbar out of HTMX partial responses automatically.
- Replace hand-written AJAX/JS with declarative server-generated `hx-*` attributes via core's `Htmx` class.
- Add out-of-band swaps to update several page regions from one response (`hx-swap-oob`).
- Attach `hx-on:*` inline behaviors to elements with `->on('::load', 'myHandler(this)')`.
