# Colorbox Simple Load — manual setup guide

**Colorbox Simple Load** (`colorbox_simple_load`) is a tiny helper on top of the
Colorbox module: it makes any link you mark with the CSS class **`colorbox-load`**
open its `href` inside a Colorbox lightbox instead of navigating to it. Better
still, you can set per-link lightbox options right in the link's URL query string
— width, height, iframe mode, and so on — so different links can behave
differently without any custom JavaScript.

That's the whole module. There's no admin UI, no settings page, no permissions,
and no PHP API — you use it purely by adding a class (and optional query params) to
your markup. It works anywhere the class survives to the browser: a block body, a
WYSIWYG "source" field, a View's rewritten output, or a Twig template. All the
lightbox styling, default sizes, and mobile behavior come from the **Colorbox**
module itself; this module just adds the per-link trigger and the URL-param
override on top.

This guide is written for a **human**. If you want terse, token-cheap references
for an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   the Colorbox dependency.

## Where it lives in the admin menu

Nowhere of its own — it has no configuration page. The only related settings are
Colorbox's own, at **Configuration → Media → Colorbox**
(`/admin/config/media/colorbox`), which control the lightbox skin, default size,
transitions, and mobile behavior for the whole site.

## How to use it

Give any link the `colorbox-load` class:

```html
<a class="colorbox-load" href="/node/1">View</a>
```

Clicking it opens `/node/1` in a Colorbox overlay instead of loading the page.

To tune a single link, add query parameters to its `href` — they're passed to
Colorbox as options, merged over the site-wide Colorbox defaults:

```html
<a class="colorbox-load" href="/node/1?width=900&height=700&iframe=true">Open big</a>
```

The mapping rules are:

| In the URL | Becomes Colorbox option | Notes |
|---|---|---|
| `width=900` | `innerWidth: 900` | `width` is renamed to `innerWidth` |
| `height=700` | `innerHeight: 700` | `height` is renamed to `innerHeight` |
| `true` / `yes` | boolean `true` | e.g. `iframe=true`, `photo=yes` |
| `false` / `no` | boolean `false` | e.g. `open=no` |
| any other `key=value` | `key: value` (string) | passed straight to Colorbox |

So `?iframe=true` loads the target in an iframe, `?ajax=true` fetches it via AJAX,
and any option Colorbox's jQuery plugin accepts can be set this way. The module
also honors Colorbox's mobile-detect setting, bowing out on small screens if you've
configured Colorbox to do so.

Two things must be true for a link to open in the lightbox: the target must be
reachable, and the **Colorbox module must be installed and its library present**
(see [Installation](installation/index.md)). What you set here is only the
per-link trigger — the lightbox's look and defaults are all Colorbox settings.
