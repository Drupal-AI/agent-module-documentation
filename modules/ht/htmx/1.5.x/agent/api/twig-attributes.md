<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `create_htmx()` and the `HtmxAttribute` fluent API

The primary developer surface. A Twig function `create_htmx()` (registered by
`HtmxTwigExtension`) returns a `Drupal\htmx\Template\HtmxAttribute`, which extends core's
`Attribute` and adds chainable methods that render **`data-hx-*`** attributes (Drupal escapes
them safely; camelCase args are kebab-cased).

## In Twig

```twig
{% set attrs = create_htmx().get(url).target('#result').swap('outerHTML').trigger('click') %}
<button {{ attrs }}>Load</button>

{# print inline #}
<div {{ create_htmx().get(path('my.route')).select('#content').swap('innerHTML') }}>…</div>
```

`url` args are Drupal `Url` objects (in Twig use `path()`/`url()` or a passed Url variable).

## In PHP

```php
use Drupal\htmx\Template\HtmxAttribute;
use Drupal\Core\Url;

$htmx = new HtmxAttribute();
$htmx->get(Url::fromRoute('my.route'))
  ->target('#result')
  ->swap('outerHTML')
  ->trigger('click');
$build['#attributes'] = $htmx->toArray();   // or attach to an element's attributes
```

## Methods

Request verbs (take a `Url`): `get()`, `post()`, `put()`, `patch()`, `delete()`.

Core behavior:
- `target(string)` → `hx-target`; `swap(string $strategy, bool $ignoreTitle = TRUE)` → `hx-swap`
  (note: appends `ignoreTitle:true` by default so the page title is not replaced).
- `select(string)` → `hx-select`; `selectOob(string)` → `hx-select-oob`;
  `swapOob(true|string)` → `hx-swap-oob`.
- `trigger(string)` → `hx-trigger` (event name, filters, or `every 2s` polling).
- `vals(array)` → `hx-vals` (JSON); `headers(array)` → `hx-headers` (JSON);
  `request(array)` → `hx-request` (timeout/credentials/noHeaders).
- `pushUrl(bool|Url)` → `hx-push-url`; `replaceUrl(bool|Url)` → `hx-replace-url`.
- `on(string $event, string $action)` → `hx-on:*` (kebab-cased; `::EventName` → `htmx:EventName`).

Other attributes: `boost(bool)`, `confirm(string)`, `prompt(string)`, `disable()`,
`disabledElements(string)`, `disinherit(string)`, `inherit(string)`, `encoding(string)`,
`ext(string)`, `history(bool)`, `historyElement()`, `include(string)`, `indicator(string)`,
`params(string)`, `preserve(string)`, `sync(string)`, `validate(bool)`.

All return `$this` for chaining. Each maps to the matching HTMX attribute — see
<https://htmx.org/reference/>.

## Attach the library

The `data-hx-*` attributes only act once the HTMX JS is present. Attach core's library:

```php
$build['#attached']['library'][] = 'core/htmx';
```

(This module's own `htmx/drupal` library is **deprecated** in 1.5 — use `core/htmx`.)
