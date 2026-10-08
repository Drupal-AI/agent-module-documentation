<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DSFR asset libraries

How `dsfr_libraries` exposes the DSFR distribution to Drupal. All source is two files:
`dsfr_libraries.libraries.yml` and `dsfr_libraries.module`. No `src/`, config, routes,
permissions, services or plugins exist.

## Install / enable

1. Place the DSFR distribution at `web/libraries/dsfr/` so its built files live under
   `web/libraries/dsfr/dist/`. Typical route: Asset Packagist —
   `composer require npm-asset/gouvfr--dsfr:^1.12` with an `installer-path` mapping
   `web/libraries/dsfr` → `npm-asset/gouvfr--dsfr`. The module ships no `composer.json`
   and does not vendor the DSFR.
2. Enable the module: `drush en dsfr_libraries -y`.
3. Check `/admin/reports/status` — no "DSFR library" error means the distribution was found.

## Static libraries (`dsfr_libraries.libraries.yml`)

- **`dsfr_libraries/core`**
  - CSS (`base`): `/libraries/dsfr/dist/core/core.min.css` — `{ minified: true }`.
  - JS: `/libraries/dsfr/dist/core/core.module.min.js` — `attributes: { type: module }`;
    `/libraries/dsfr/dist/core/core.nomodule.min.js` — `attributes: { nomodule: true }`.
    (The module/nomodule pair lets modern browsers load the ES module and legacy ones the fallback.)
- **`dsfr_libraries/utility`**
  - CSS (`base`): `/libraries/dsfr/dist/utility/utility.min.css` — `{ minified: true }`.

All paths are local, server-relative `/libraries/dsfr/...` references (no CDN, no remote URLs).

## Dynamic component libraries (`hook_library_info_build()`)

`dsfr_libraries_library_info_build()` runs at library-info build time and returns an array of
extra libraries, one per DSFR component:

- Globs `DRUPAL_ROOT . '/libraries/dsfr/dist/component/*'` with `GLOB_ONLYDIR`.
- For each directory, `$componentName = basename($path)` becomes the **library id**
  (so `dsfr_libraries/<componentName>`, e.g. `dsfr_libraries/button`).
- Each component library declares `dependencies => ['dsfr_libraries/core']`.
- It conditionally attaches, only if the file exists:
  - `.../<component>/<component>.min.css` → `css.component`, `{ minified: TRUE }`;
  - `.../<component>/<component>.module.min.js` → JS with `attributes.type = module`;
  - `.../<component>/<component>.nomodule.min.js` → JS with `attributes.nomodule = TRUE`.

Consequence: the available component libraries mirror whatever `dist/component/*` folders the
installed DSFR ships. Adding a component folder (and clearing caches) exposes a new library
automatically; there is no static list to maintain.

## Requirements hook (`hook_requirements()`)

`dsfr_libraries_requirements('runtime')` checks `DRUPAL_ROOT . '/libraries/dsfr/'`. If missing,
it returns a `dsfr_libraries` requirement with `severity => REQUIREMENT_ERROR` and a message
naming the expected path. This is a status-report advisory only; it does not block bootstrap.

## Attaching libraries

- Render array: `$build['#attached']['library'][] = 'dsfr_libraries/core';` (repeat for
  component libraries such as `'dsfr_libraries/button'`).
- Library dependency in a theme/module `*.libraries.yml`:

  ```yaml
  my-component:
    dependencies:
      - dsfr_libraries/checkbox
  ```

Attaching a component library pulls in `dsfr_libraries/core` automatically via its declared
dependency. Upgrading the DSFR is just swapping the `libraries/dsfr` distribution; component
libraries are re-derived on the next library-info rebuild (clear caches).
