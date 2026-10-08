<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `create_htmx()` and the `HtmxAttributeBuilder`

The primary developer surface for building `hx-*` attributes. A Twig function `create_htmx()`
(registered by `HtmxTwigExtension`) returns a **`Drupal\htmx\Template\HtmxAttributeBuilder`** —
a `\Stringable` object that proxies every method call, via `__call`, to core's
**`Drupal\Core\Htmx\Htmx`** class. Casting it to a string emits **`data-hx-*`** attributes
(Drupal escapes them; camelCase args are kebab-cased). Header-oriented methods on the builder
have no effect when it is stringified (they are skipped by the proxy).

> Changed in 2.0.x: in 1.5.x `create_htmx()` returned a `Drupal\htmx\Template\HtmxAttribute`
> (extending core's `Attribute`). That class is gone; the fluent methods now live on core's
> `Htmx` class, and `create_htmx()` returns the thin `HtmxAttributeBuilder` proxy.

## In Twig

```twig
{% set attrs = create_htmx().get(url).target('#result').swap('outerHTML').trigger('click') %}
<button {{ attrs }}>Load</button>

{# print inline #}
<div {{ create_htmx().get(path('my.route')).select('#content').swap('innerHTML') }}>…</div>
```

`url` args are Drupal `Url` objects (in Twig use `path()`/`url()` or a passed Url variable).

## In PHP — use core's `Htmx` class directly

```php
use Drupal\Core\Htmx\Htmx;
use Drupal\Core\Url;

$htmx = new Htmx();
$htmx->get(Url::fromRoute('my.route'))
  ->target('#result')
  ->swap('outerHTML')
  ->trigger('click');
// Attach attributes (and any HX-* headers) + the htmx library to a render element:
$htmx->applyTo($build);
// or pull just the attribute object:
$attributes = $htmx->getAttributes();
```

`applyTo(array &$element, string $attributeKey = 'attributes')` writes the `data-hx-*`
attributes onto the element, attaches the core htmx library, and (for header methods) adds the
matching `#attached['http_header']`. This is how the module's own block, pager and admin-dialog
code builds its attributes (`new Htmx()` throughout `src/`).

## Methods

Request verbs (take a `Url`): `get()`, `post()`, `put()`, `patch()`, `delete()`.

Core behavior (all provided by core's `Htmx`): `target()` → `hx-target`; `swap()` → `hx-swap`;
`select()` → `hx-select`; `selectOob()`/`swapOob()`; `trigger()` → `hx-trigger` (event, filters,
`every 2s` polling); `vals()`/`headers()`/`request()` (JSON); `pushUrl()`/`replaceUrl()`;
`on($event, $action)` → `hx-on:*` (kebab-cased; `::EventName` → `htmx:EventName`); plus
`boost()`, `confirm()`, `prompt()`, `disable()`, `include()`, `indicator()`, `sync()`, `ext()`,
`history()`, `preserve()`, `validate()`, `encoding()`, and more. See the core `Htmx` class and
<https://htmx.org/reference/>.

## Attach the library

The `data-hx-*` attributes only act once the HTMX JS is present. When you build attributes with
core's `Htmx` and call `applyTo()`, the library is attached for you. Otherwise attach core's
library yourself:

```php
$build['#attached']['library'][] = 'core/htmx';
```

(This module's own legacy `htmx/drupal` library is **deprecated** — use `core/htmx`.)
