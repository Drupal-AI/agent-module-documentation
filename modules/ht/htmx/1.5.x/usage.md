<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
htmx integrates the [HTMX](https://htmx.org) JavaScript library with Drupal 11, giving themers and developers server-side helpers to add `hx-*` attributes, emit HTMX response headers, expose HTMX-friendly routes, and lazy-load blocks and paginated Views over AJAX-style partial page swaps — without writing custom JavaScript.

---

The module's core developer surface is a Twig function **`create_htmx()`** and the **`HtmxAttribute`** PHP class it returns: a fluent builder (`->get($url)->target('#x')->swap('outerHTML')->trigger('click')…`) that emits Drupal-safe `data-hx-*` attributes covering the full HTMX reference (get/post/put/patch/delete, target, swap, select, trigger, vals, headers, boost, confirm, pushUrl, sync, indicator, and more). On the response side, **`HtmxResponseHeaders`** builds `HX-*` headers (HX-Location, HX-Push-Url, HX-Redirect, HX-Refresh, HX-Retarget, HX-Reswap, HX-Reselect, HX-Trigger[-After-Settle/Swap]) for `#attached['http_header']`. Routes flagged with the `_htmx_route: true` option render through a **SimplePageVariant** (a bare page shell, no blocks/regions) so responses are swap-ready; the module ships such routes for viewing an entity in a view mode (`/htmx/{entityType}/{entity}/{viewMode}`) and for rendering a configured block. On an `HX-Request` the admin toolbar is stripped from the response. For site builders it adds an **HTMX Block** config entity (`htmx_block`, managed at `/admin/structure/htmx-block`, permission *administer htmx_block*) plus an **HTMX Loader** block plugin (`htmx_loader`) that swaps a placeholder for a configured HTMX block when a chosen event fires (with delay/throttle/target/filter options). For Views it provides an **HTMX display** plugin (`htmx`, a simple-page display exposing a URL for HTMX requests) and an **HTMX mini pager** (`htmx_mini`) that pages a view in place via `hx-get` swaps. It also re-uses core's off-canvas dialog styles and provides a themable `htmx_mini_pager`. Note: this module builds on core's own `core/htmx` library (Drupal core ships HTMX in 11.2); this module's older `htmx/drupal` and `htmx/debug` libraries are deprecated in favour of the core library. A companion **htmx_debug** submodule swaps in the unminified library and logs events.

---

- Add `hx-get`/`hx-target`/`hx-swap` attributes to a Twig template link so it loads a fragment in place.
- Build a "load more" button that fetches and appends the next chunk of content.
- Lazy-load an expensive block only when it scrolls into view.
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
- Debug HTMX behavior with the unminified library and console logging (htmx_debug submodule).
- Show a loading indicator element during an HTMX request (`hx-indicator`).
- Synchronize competing requests between elements with `hx-sync`.
- Build a bare "simple page" response (no regions) for swap-ready fragments via `_htmx_route`.
- Keep the admin toolbar out of HTMX partial responses automatically.
- Replace hand-written AJAX/JS with declarative server-generated `hx-*` attributes.
- Add out-of-band swaps to update several page regions from one response (`hx-swap-oob`).
- Disable HTMX processing on a subtree with `->disable()`.
