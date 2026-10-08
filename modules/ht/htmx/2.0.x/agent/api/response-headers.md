<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# HTMX response headers, HTMX routes & entity view

## Emit `HX-*` headers with core's `Htmx`

> Changed in 2.0.x: the module no longer ships a `Drupal\htmx\Http\HtmxResponseHeaders` class.
> HTMX response headers are now produced by core's **`Drupal\Core\Htmx\Htmx`** — the same object
> that builds `hx-*` attributes also carries the `HX-*` header methods.

```php
use Drupal\Core\Htmx\Htmx;
use Drupal\Core\Url;

$htmx = new Htmx();
$htmx->addTriggerHeader('myEvent')          // HX-Trigger
     ->addPushUrlHeader(Url::fromRoute('my.route'))  // HX-Push-Url
     ->addReswapHeader('innerHTML');        // HX-Reswap
$htmx->applyTo($build);   // adds the HX-* headers to $build['#attached']['http_header']
```

Core's `Htmx` provides the full response-header set — `HX-Location`, `HX-Push-Url`,
`HX-Replace-Url`, `HX-Redirect`, `HX-Refresh`, `HX-Reswap`, `HX-Retarget`, `HX-Reselect`,
`HX-Trigger`, `HX-Trigger-After-Settle`, `HX-Trigger-After-Swap`. Consult the core `Htmx` class
for exact method names and `https://htmx.org/reference/#response_headers`.

Note: the `create_htmx()` Twig builder ignores header methods when it is cast to a string, so
call header methods on a real core `Htmx` instance in PHP (then `applyTo()`), not on the Twig
proxy.

## `_htmx_route: true` — SimplePageVariant (bare page)

Any route with the option `_htmx_route: true` is rendered by core through a **SimplePageVariant**
— a stripped page shell with no blocks/regions — so the response body is swap-ready for HTMX.
Add it in your `*.routing.yml`:

```yaml
my.fragment:
  path: '/my/fragment'
  defaults: { _controller: '\Drupal\my\Controller\Frag::build' }
  requirements: { _permission: 'access content' }
  options:
    _htmx_route: true
```

## Built-in HTMX routes

- **`/htmx/{entityType}/{entity}/{viewMode}`** (`htmx.htmx_entity_view`) — render any entity in a
  given view mode as a bare HTMX fragment. Access-gated by `_entity_access: entity.view`, so the
  viewer must have view access to the requested entity. Handy as an `hx-get` target.
- `/htmx/blocks/view/{block}` (`htmx_blocks.view`) — render a configured HTMX block
  (`_htmx_route: true`, permission `access content`; the block's own `access('view')` is still
  enforced — see configure/htmx-blocks.md).
- The HTMX block admin add/edit/delete/list routes live under `/htmx/blocks/*` and the
  autocomplete endpoints under `/htmx/autocomplete/*` — all guarded by `administer htmx_block`.

## Toolbar on HTMX requests

`htmx_page_top()` removes the admin toolbar from the page top whenever the request carries an
`HX-Request` header (except on core's `htmx.toolbar_only` route) — so partial swaps never inject
a duplicate toolbar. `hook_install()` sets the module weight to 1 (above toolbar) so this runs
last.
