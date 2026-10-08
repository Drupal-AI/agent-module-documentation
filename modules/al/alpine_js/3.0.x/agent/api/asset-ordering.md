<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Asset ordering — `hook_js_alter` + `AlpineAssetService`

The module's whole job: guarantee Alpine core initialises **after** every Alpine plugin, no matter
what JS aggregation/weighting would otherwise do. All Alpine code is bundled under `js/vendor/`.

## Libraries (`alpine_js.libraries.yml`)

Each library has one minified, preprocessed JS file tagged `attributes: { alpinejs: true }` so the
service can recognise it:

- `alpine` → `js/vendor/alpinejs.min.js` (v3.15.12, standard build)
- `alpine-csp` → `js/vendor/alpinejs-csp.min.js` (v3.15.12, CSP-safe build)
- `anchor`, `collapse`, `focus`, `intersect` (v3.15.12), `persist` (v3.14.12), `resize` (v3.15.1)
  → the matching `js/vendor/alpinejs-<plugin>.min.js`
- `drupalbridge` → `js/drupalbridge.plugin.js` (not minified), `dependencies: [alpine_js/alpine_js]`

There is **no** `alpine_js/alpine_js` library defined in this file — the README/opt-in name
`alpine_js/alpine_js` is what themes depend on; the service treats a dependency on it (or
`alpine_js/alpine-csp`) as the signal to enable Alpine (`themeNeedsAlpine()` checks the active
theme's `getLibraries()` for exactly those two names).

## Entry point (`alpine_js_js_alter`)

`hook_js_alter(&$javascript, AttachedAssetsInterface $assets)`:

1. Detects Ajax/XHR: `query->has('ajax_form')`, `_wrapper_format === 'drupal_ajax'`, or
   `isXmlHttpRequest()`. If any, it **returns early** and leaves JS untouched (rewriting Ajax delta
   assets can produce malformed definitions — regression fixed in 3.0.7; covered by
   `tests/src/Kernel/AlpineJsJsAlterTest.php`).
2. Otherwise, if `$javascript` is non-empty, calls
   `\Drupal::service('alpinejs.service')->findAndSplitAlpineLibraries($javascript)`.

## Service (`AlpineAssetService`)

Constructor loads `alpine_js.settings`, sets `alpineScope` = `footer` (if `footer` config on) else
`header`, `useAlpineCSPVersion` from `csp`, and `alpineEnabled = themeNeedsAlpine() || global`.

`findAndSplitAlpineLibraries(&$sources)` runs only when `alpineEnabled` OR `adminNeedsAlpine()`
(true when the route is **not** an admin route, or `admin` config is on — i.e. it *skips* admin
routes unless `admin` is enabled). Then it:

- Loads the module's own libraries via `LibraryDiscoveryInterface::getLibrariesByExtension('alpine_js')`
  (`getAlpineBaseLibraries()`), forcing scope + default options (`weight: 300`, `group: JS_LIBRARY`,
  `preprocess: true`) and carrying each library's `license` onto its JS records (the missing-license
  fix from 3.0.5).
- Walks every incoming source through `normalizeDefinition()` (drops non-array/invalid records,
  fills `type`/`data`). Files tagged `attributes.alpinejs` are moved into `librariesNeedsAlpine`
  (scoped to `alpineScope`) and removed from the normal list; everything else is bucketed by
  header/footer scope.
- `addAlpineToLibraries()` then appends, in order: enabled bundled **plugins** → custom
  `alpinejs`-tagged **libraries** → optional **`drupalbridge`** (if `bridge`) → **Alpine core**,
  choosing `alpine-csp` when `useAlpineCSPVersion` (set by config `csp`, or forced if a library
  explicitly requested the `alpine-csp` base). Each appended item gets an incrementing weight above
  the last existing item (so Alpine core is genuinely last), `preprocess` forced on, and the
  `attributes.alpinejs` marker stripped.
- Finally rebuilds `$sources` = header bucket + footer bucket, then `sanitizeSources()` re-runs
  `normalizeDefinition()` to drop anything malformed before returning.

## How to opt a theme/module in (from README)

- Whole theme: add `libraries: [alpine_js/alpine_js]` in `theme.info.yml`.
- A single library/script: give the JS file `attributes: { alpinejs: true }` and add
  `dependencies: [alpine_js/alpine_js]`.
- A plugin: listen for the `alpine:init` event and call `window.Alpine.plugin(myPlugin)`.

## The bridge plugin (`js/drupalbridge.plugin.js`)

When `bridge` is on, registers one Alpine magic on `alpine:init`: `$dbg(...args)` unwraps each arg
with `Alpine.raw()` and `console.log`s it. Debug convenience only; no data leaves the browser.
