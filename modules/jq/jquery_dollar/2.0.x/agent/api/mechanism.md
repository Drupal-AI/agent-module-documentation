<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# jquery_dollar — the alias mechanism (`hook_js_alter`)

The module has no API to call, no service, no config, no route. It works entirely by altering the
JavaScript asset list on every page. This doc is the whole behavior; you do not need to read the
source after this.

## The two source files

`jquery_dollar.js` (the payload, one line):

```js
$ = jQuery;
```

`jquery_dollar.module` — `jquery_dollar_js_alter(&$javascript, AttachedAssetsInterface $assets)`:

```php
$file = \Drupal::service('extension.list.module')->getPath('jquery_dollar') . '/jquery_dollar.js';
if (isset($javascript['core/misc/drupal.init.js'])) {
  $javascript[$file] = $javascript['core/misc/drupal.init.js']; // clone the asset definition
  $javascript[$file]['data'] = $file;                           // repoint at our file
  $javascript[$file]['weight'] += 0.1;                          // just after drupal.js
}
```

## Why it is written this way

- It **copies** core's `drupal.init.js` asset entry (its `group`, `type`, `scope`, `cache`,
  `preprocess`, etc.) so the alias script inherits the same load context, then overwrites only
  `data` (the file to load) and nudges `weight` by `+0.1`.
- `drupal.init.js` is where core calls `jQuery.noConflict()`, which removes the global `$`. Loading
  `$ = jQuery;` at `weight + 0.1` re-defines `$` **immediately after** that removal, so every later
  script — including scripts other modules add in their own `hook_js_alter()` — sees `$`.
- The guard `if (isset($javascript['core/misc/drupal.init.js']))` means it only acts on pages that
  already load Drupal's JS bootstrap. In practice that is every rendered HTML page, **admin pages
  included**, wherever `core/drupal` (which pulls in `drupal.init.js`) is attached.

## Enable / disable

- Enable: `drush en jquery_dollar -y` (or `ddev drush en jquery_dollar -y`). No configuration step,
  no settings form, no permission to grant — `configure` is null and there is no
  `*.permissions.yml`.
- Effect is site-wide and immediate after a cache rebuild (`drush cr`); the alias appears in the
  aggregated/served JS.
- Remove it once vendor scripts are updated: `drush pmu jquery_dollar -y`. Nothing else references
  the alias in config or content, so uninstall is clean.

## Caveats to know before relying on it

- **Strict mode.** `$ = jQuery;` is an assignment to an undeclared identifier — an implicit global.
  Under `"use strict"` (e.g. inside an ES module or a strict IIFE) this throws
  (`ReferenceError` / "assignment to undeclared variable $"). The payload itself is not strict, so
  it runs, but this is why the assignment is bare rather than `var $` / `window.$`.
- **Collisions.** Any other library that wants the global `$` (Prototype, MooTools) will fight
  jQuery for it; whoever's asset loads last wins, silently. This module is only safe on a site that
  uses jQuery as its sole `$` claimant.
- **Version pinning.** `$` points at whatever single jQuery core loads; the module cannot give
  different pages different `$`/jQuery versions.
- **No inline script, no user data.** The payload is a static file asset (not an inline
  `<script>`), and it never incorporates request, config, or content data — it is a fixed string.

## When to prefer the standard pattern

For code you control, wrap it instead of enabling this module:

```js
(function ($, Drupal) {
  // $ is jQuery here, locally, no global side effect.
})(jQuery, Drupal);
```

Use `jquery_dollar` only as a documented compatibility shim for a third-party script you cannot
edit and that assumes a global `$`.
