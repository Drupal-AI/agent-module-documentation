# Cash DOM — manual setup guide

**Cash DOM** (`cash`) makes the [Cash](https://github.com/fabiospampinato/cash)
library available in Drupal — an "absurdly small" jQuery alternative for modern
browsers (Chrome, Firefox, Safari, and Internet Explorer 9+). Cash gives you the
familiar jQuery-style chainable syntax for manipulating the DOM (`$('.thing')
.addClass('active')`) at a fraction of the size: roughly 3.5 KB minified and
gzipped versus jQuery's ~30 KB. It is meant for themes and modules that want
jQuery-like code without bundling full jQuery — handy now that jQuery is no
longer loaded on every Drupal page by default.

This is a front-end **library integration**. It does nothing on its own: it
simply registers a `cash/cash` asset library that you attach where you need it.
It has no content model and no access-control role. A small admin form (gated by
the `administer cash` permission) lets you attach the library site-wide for
convenience, but most projects will instead declare `cash/cash` as a dependency
of their own library. It supports Drupal 8.8 and newer.

One setup detail to know up front: like most library-wrapper modules, Cash DOM
expects the actual Cash JavaScript to be present in your site's `libraries/`
directory (at `/libraries/cash/dist/cash.min.js` or
`/libraries/cash-dom/dist/cash.min.js`). See [Installation](installation/index.md)
for how to get the library files in place.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and place the Cash
   library files.
2. [Configuration](configuration/index.md) — the optional admin form for
   attaching the library site-wide.

## How to use it

Once the module is enabled and the library files are in place, you use it the way
you'd use jQuery — keep the `$` and call methods on it, but the underlying engine
is Cash. The recommended approach is to declare it as a dependency of your own
theme or module library in a `*.libraries.yml` file:

```yaml
my_library:
  js:
    js/my_theme.min.js: {}
  dependencies:
    - cash/cash
```

Or attach it from a render array in PHP:

```php
$page['#attached']['library'][] = 'cash/cash';
```

If you'd rather not touch code, the admin form described in
[Configuration](configuration/index.md) can load Cash across the whole site.
