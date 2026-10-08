<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Twig.js (twigjs) — agent index

Packages the client-side **Twig.js** JavaScript library (and a tiny underscore-based "light"
alternative) as Drupal asset libraries so PHP code / other modules can render Twig-ish templates in
the browser. Pure library provider: **no routes, no controllers, no services, no config, no schema,
no permissions, no plugins, no hooks** — just three entries in `twigjs.libraries.yml`. Empty
`.module`. Core `^8 || ^9 || ^10 || ^11`. License GPL-2.0-or-later. Version 2.0.4.

- **The three libraries, the JS globals they expose, how to attach and use them, the `trans` tag,
  and the "light" limitations** → [libraries/libraries.md](libraries/libraries.md)

## What it actually is (from source)

- `twigjs.libraries.yml` declares three asset libraries — nothing else in the module has behavior:
  - **`twigjs/twigjs`** → `js/twig.min.js` (vendored Twig.js). Exposes the global `Twig`; call
    `Twig.twig({id, data}).render(vars)`.
  - **`twigjs/light`** → `js/underscore.min.js` + `js/twigjs.light.js`. Exposes the global
    `TwigLight` with the same `.twig({id,data}).render(vars)` shape, but backed by Underscore's
    `_.template()` with `interpolate: /\{\{(.+?)\}\}/g` — so **only `{{ var }}` interpolation**, no
    Twig tags/filters, results cached by `id` (`js/twigjs.light.js`).
  - **`twigjs/drupal.twigjs`** → `js/twigjs.drupal.js`, depends on `twigjs/twigjs`. Calls
    `Twig.extend()` to register `trans` / `endtrans` custom tags (the `trans` parse just re-parses
    its inner tokens — it renders the wrapped content, it does not translate).
- `twigjs.module` is an empty `@file` stub. There is **no `.routing.yml`, `.services.yml`,
  `.permissions.yml`, `.install`, or `config/`**.
- Everything under `tests/` is a PHPUnit FunctionalJavascript fixture (`twigjs_test` module,
  `TestController`), **not shipped** and not enabled on a normal install — see the solution doc for
  why it is only a fixture.

Typical usage: a controller/render array stashes a template string into `drupalSettings` and
`#attached`es one of these libraries; a `Drupal.behaviors` callback then does
`Twig.twig({...}).render(...)` and writes the result into the DOM. Templates for twig.js must
resolve to **strings** (no nested render-array variables — a documented Drupal-vs-twig.js gap).
