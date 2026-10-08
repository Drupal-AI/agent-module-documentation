<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DSFR libraries (dsfr_libraries) — agent index

Declares DSFR (French State Design System / Système de Design de l'État français) core, utility and per-component CSS/JS as attachable Drupal asset libraries. Pure library declarer — no routes, permissions, services, plugins or config.

- **Version:** 1.0.x (installed 1.0.0-alpha3 — PRE-RELEASE alpha; library set/API may change)
- **Core:** `^10 || ^11`. License GPL-2.0-or-later. No composer `require`, no PHP module deps.
- **Requires:** the DSFR distribution installed separately at `web/libraries/dsfr/` (e.g. `npm-asset/gouvfr--dsfr` via Asset Packagist). The module does NOT bundle it.

## What it provides

- **Static libraries** (`dsfr_libraries.libraries.yml`):
  - `dsfr_libraries/core` — `core.min.css` + `core.module.min.js` (`type=module`) + `core.nomodule.min.js` (`nomodule`).
  - `dsfr_libraries/utility` — `utility.min.css`.
  - All paths are local `/libraries/dsfr/dist/...` references, marked `minified: true`.
- **Dynamic libraries** — `hook_library_info_build()` (`dsfr_libraries.module`) globs `libraries/dsfr/dist/component/*` and registers one library per component dir (id = folder name), attaching its `.min.css` + `.module.min.js`/`.nomodule.min.js` if present, each depending on `dsfr_libraries/core`.
- **Requirements check** — `hook_requirements()` returns a `REQUIREMENT_ERROR` on the status report when `DRUPAL_ROOT/libraries/dsfr/` is absent.

## How to use

- Attach in a render array: `$build['#attached']['library'][] = 'dsfr_libraries/core';` (and e.g. `'dsfr_libraries/button'`).
- Or depend on it from your own `*.libraries.yml`: `dependencies: [ dsfr_libraries/checkbox ]`.

## Solution docs

- Library declaration, the two hooks, and how assets are resolved → [libraries/libraries.md](libraries/libraries.md)
