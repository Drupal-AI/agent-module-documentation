# htmx — manual setup guide

**htmx** (`htmx`) brings the [HTMX](https://htmx.org) JavaScript library into
Drupal 11 and gives themers and developers a clean, server-side way to use it.
With HTMX you can make a link, button, or form fetch a fragment of a page and swap
it into place — "load more" buttons, in-place pagination, lazy-loaded blocks,
live-filtering lists — all without hand-writing AJAX JavaScript. This module lets
you express that behaviour from Twig and PHP instead.

The heart of it is a Twig function, **`create_htmx()`**, and the `HtmxAttribute`
class it returns: a fluent builder that emits Drupal-safe `hx-*` attributes
(`->get(url)->target('#result')->swap('outerHTML')->trigger('click')`, and the
full HTMX reference beyond that). On the response side, `HtmxResponseHeaders`
builds the matching `HX-*` headers, and a `_htmx_route: true` route option renders
a bare, swap-ready page shell. For site builders there is also an **HTMX Block**
config entity plus an **HTMX Loader** block that lazy-loads content when an event
fires, and Views integration (an HTMX display and an in-place "mini" pager).

This module builds on core's own `core/htmx` library, which Drupal ships in
**11.2** — so it targets Drupal 11.2 and newer and needs **PHP 8.3**. This is a
**developer-facing** module: `configure` is `null`, and apart from the HTMX Block
listing there is no general settings form.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent — the full `HtmxAttribute` method
list, the response-header API, and the block/Views details — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, meet the PHP
   8.3 / Drupal 11.2 requirements, and enable the optional debug submodule.

## How to use it

In a Twig template, build the attributes with `create_htmx()` and print them on
an element:

```twig
{% set attrs = create_htmx().get(path('my.route')).target('#result').swap('outerHTML').trigger('click') %}
<button {{ attrs }}>Load</button>
```

The same builder is available in PHP via `Drupal\htmx\Template\HtmxAttribute`. The
`hx-*` attributes only act once the HTMX JavaScript is on the page, so attach
core's library where you use them:

```php
$build['#attached']['library'][] = 'core/htmx';
```

(The module's own older `htmx/drupal` library is deprecated in 1.5 in favour of
`core/htmx`.)

Site builders get two no-code surfaces:

- **HTMX blocks** are managed at **Structure → Block layout → HTMX**
  (`/admin/structure/htmx-block`), guarded by the **Administer htmx_block**
  permission. Define a block here, then place an **HTMX Loader** block (category
  *HTMX*) in a region and point it at your HTMX block; it swaps itself for that
  block when a chosen event (such as `load` or `click`) fires.
- **Views**: add an **HTMX** display to expose a view at a URL meant for HTMX
  requests, and choose the **Mini (HTMX)** pager to page a listing in place.

The optional **htmx_debug** submodule swaps in the unminified library and logs
HTMX events to the console — handy while developing.
