<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# jQuery Dollar (jquery_dollar) — agent index

Makes **`$` a global alias for jQuery**, undoing Drupal's no-conflict default.
Version **2.0.1**. Core `^9.3 || ^10 || ^11`. License GPL-2.0-or-later.
**No dependencies, no routes, no permissions, no config, no services, no plugins.**

The entire module is three files:
- `jquery_dollar.js` — one line: `$ = jQuery;`
- `jquery_dollar.module` — one function, `jquery_dollar_js_alter()`.
- `jquery_dollar.info.yml` — no `dependencies:` key.

- **How the injection works, load order, strict-mode/collision caveats, install & removal** →
  [api/mechanism.md](api/mechanism.md)

## What it actually is

`jquery_dollar_js_alter(&$javascript, AttachedAssetsInterface $assets)` (a `hook_js_alter()`
implementation) clones the asset definition of **`core/misc/drupal.init.js`**, repoints the copy
at `jquery_dollar.js`, and bumps its `weight` by `0.1` so the alias script loads **directly after
`drupal.js`** — i.e. right after `jQuery.noConflict()` runs. It only acts when
`core/misc/drupal.init.js` is present in the page's JS, which is essentially every page.

## Two caveats that follow from the one line

- `$ = jQuery;` has no `var`/`let`/`window.` — an **implicit global**, which **throws in strict
  mode** (`ReferenceError`/`assignment to undeclared variable`).
- Defining `$` globally is exactly what no-conflict mode prevents; any other library claiming `$`
  (Prototype, MooTools) now collides, silently, in asset-load order.

**Fit:** a deliberate, documented compatibility shim for a specific third-party script, not a
site-wide convenience. In your own code use `(function ($) { … })(jQuery)` instead.
