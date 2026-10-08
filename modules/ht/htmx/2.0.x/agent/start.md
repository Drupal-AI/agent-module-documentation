<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# htmx — agent index

Server-side helpers for the [HTMX](https://htmx.org) integration in Drupal 11.3+: emit `hx-*`
attributes, HTMX-friendly routes, lazy-loaded blocks, and AJAX-paged Views — no custom JS.
Version **2.0.x** builds directly on **core's `Drupal\Core\Htmx\Htmx`** class and the `core/htmx`
library (Drupal core ships a full HTMX integration in 11.3). Requires PHP 8.3.
`configure: null` (block UI lives at `/admin/structure/htmx-block`).

- **Add `hx-*` attributes in Twig/PHP: `create_htmx()` + the `HtmxAttributeBuilder`, or core's
  `Htmx` class directly** → [api/twig-attributes.md](api/twig-attributes.md)
- **HTMX routes, `_htmx_route`, entity-view route, response headers via core `Htmx`, toolbar
  behavior** → [api/response-headers.md](api/response-headers.md)
- **HTMX Block config entity + HTMX Loader block (lazy-load a block on an event)** →
  [configure/htmx-blocks.md](configure/htmx-blocks.md)
- **Views: the HTMX display plugin + HTMX mini pager (in-place paging)** →
  [plugins/views.md](plugins/views.md)

Key facts:
- Twig: `{{ create_htmx().get(url).target('#id').swap('outerHTML') }}` → `data-hx-*` attributes.
- `create_htmx()` returns `Drupal\htmx\Template\HtmxAttributeBuilder` (a `\Stringable` proxy over
  core's `Drupal\Core\Htmx\Htmx`). In PHP, use `new \Drupal\Core\Htmx\Htmx()` directly.
- Permission: **`administer htmx_block`**. Config entity: `htmx_block` (`htmx.htmx_block.*`).
- Block plugin `htmx_loader`; Views display id `htmx`; Views pager id `htmx_mini`.
- Route option `_htmx_route: true` → SimplePageVariant (bare page). Toolbar removed on `HX-Request`.
- Submodule **htmx_debug** → un-minifies core's htmx library + adds the `debug` htmx extension.

## Diff 1.5.x → 2.0.x (major bump — BC breaks)

- **`Drupal\htmx\Template\HtmxAttribute` removed.** `create_htmx()` now returns the new
  `Drupal\htmx\Template\HtmxAttributeBuilder`, a thin `\Stringable` wrapper that proxies every
  call to core's `Drupal\Core\Htmx\Htmx`. Code that type-hinted or `new`-ed `HtmxAttribute`, or
  called its `toArray()`, must switch to the core `Htmx` class (`->applyTo($build)` /
  `->getAttributes()`).
- **`Drupal\htmx\Http\HtmxResponseHeaders` removed.** HTMX response headers are now produced by
  core's `Drupal\Core\Htmx\Htmx` (same object carries both attribute and header methods; header
  methods are ignored when the builder is cast to a string in Twig). Replace
  `new HtmxResponseHeaders()` with core `Htmx`.
- **Core requirement raised `^11.2` → `^11.3`** (tracks core's full HTMX integration landing in
  11.3). PHP requirement unchanged (`^8.3`).
- **htmx_debug submodule reworked.** It no longer swaps a module-owned library; it now alters
  core's `core/htmx` to serve the un-minified `htmx.js` and attaches its own vendored `debug`
  htmx extension (`data-hx-ext="debug"`, library `htmx_debug/debug`).
- The htmx JS library is **not** vendored by this module — it comes entirely from Drupal core.
- The module's own legacy `htmx/drupal` (and `htmx/views` CSS) libraries remain; prefer core's
  `core/htmx` / `core/drupal.htmx`.
