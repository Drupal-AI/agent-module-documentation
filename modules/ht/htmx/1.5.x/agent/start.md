<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# htmx — agent index

Server-side helpers to use the [HTMX](https://htmx.org) library in Drupal 11: emit `hx-*`
attributes, `HX-*` response headers, HTMX-friendly routes, lazy-loaded blocks, and AJAX-paged
Views — no custom JS. Builds on core's `core/htmx` library (core ships HTMX in 11.2).
Requires PHP 8.3. `configure: null` (block UI lives at `/admin/structure/htmx-block`).

- **Add `hx-*` attributes in Twig/PHP: `create_htmx()` + the `HtmxAttribute` fluent API** →
  [api/twig-attributes.md](api/twig-attributes.md)
- **Emit HTMX response headers from a controller/render array (`HtmxResponseHeaders`), `_htmx_route`, entity-view route, toolbar behavior** →
  [api/response-headers.md](api/response-headers.md)
- **HTMX Block config entity + HTMX Loader block (lazy-load a block on an event)** →
  [configure/htmx-blocks.md](configure/htmx-blocks.md)
- **Views: the HTMX display plugin + HTMX mini pager (in-place paging)** →
  [plugins/views.md](plugins/views.md)

Key facts:
- Twig: `{{ create_htmx().get(url).target('#id').swap('outerHTML') }}` → `data-hx-*` attributes.
- PHP API classes: `Drupal\htmx\Template\HtmxAttribute`, `Drupal\htmx\Http\HtmxResponseHeaders`.
- Permission: **`administer htmx_block`**. Config entity: `htmx_block` (`htmx.htmx_block.*`).
- Block plugin `htmx_loader`; Views display id `htmx`; Views pager id `htmx_mini`.
- Route option `_htmx_route: true` → SimplePageVariant (bare page). Toolbar removed on `HX-Request`.
- Submodule **htmx_debug** → unminified library + console logging.
- Deprecated: this module's own `htmx/drupal` and `htmx/debug` libraries (use `core/htmx`).
