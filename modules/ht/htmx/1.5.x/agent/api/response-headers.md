<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# HTMX response headers, HTMX routes & entity view

## `HtmxResponseHeaders` — emit `HX-*` headers

`Drupal\htmx\Http\HtmxResponseHeaders` builds HTMX response headers and converts them for a
render array's `#attached['http_header']` (or a Response).

```php
use Drupal\htmx\Http\HtmxResponseHeaders;
use Drupal\Core\Url;

$headers = new HtmxResponseHeaders();
$headers->trigger('myEvent')                       // HX-Trigger
        ->pushUrl(Url::fromRoute('my.route'))      // HX-Push-Url
        ->reswap('innerHTML');                     // HX-Reswap
$build['#attached']['http_header'] = $headers->toArray();
```

Methods (each returns `$this`): `location(Url|HtmxLocationResponseData)` → HX-Location;
`pushUrl(Url|false)`; `replaceUrl(Url|false)`; `redirect(Url)` → HX-Redirect;
`refresh(bool)` → HX-Refresh; `reswap(string)`; `retarget(string)`; `reselect(string)`;
`trigger(string|array)`, `triggerAfterSettle(...)`, `triggerAfterSwap(...)` (arrays are
JSON-encoded). See <https://htmx.org/reference/#response_headers>.

## `_htmx_route: true` — SimplePageVariant (bare page)

Any route with the option `_htmx_route: true` is rendered by
`HtmxPageDisplayVariantSubscriber` using core's **SimplePageVariant** — a stripped page shell
with no blocks/regions — so the response body is swap-ready for HTMX. Add it in your
`*.routing.yml`:

```yaml
my.fragment:
  path: '/my/fragment'
  defaults: { _controller: '\Drupal\my\Controller\Frag::build' }
  requirements: { _permission: 'access content' }
  options:
    _htmx_route: true
```

## Built-in HTMX routes

- **`/htmx/{entityType}/{entity}/{viewMode}`** (`htmx.htmx_entity_view`) — render any entity in
  a given view mode as a bare HTMX fragment (`_entity_access: entity.view`). Handy as an
  `hx-get` target.
- `/htmx/blocks/view/{block}` (`htmx_blocks.view`) — render a configured HTMX block
  (see configure/htmx-blocks.md).
- `/htmx/toolbar-only` (`htmx.toolbar_only`) — returns just the toolbar.

## Toolbar on HTMX requests

`htmx_page_top()` removes the admin toolbar from the page top whenever the request carries an
`HX-Request` header (except on the toolbar-only route) — so partial swaps never inject a
duplicate toolbar.
