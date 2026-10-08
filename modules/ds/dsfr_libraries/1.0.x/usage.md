<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Registers the DSFR (Système de Design de l'État français / French State Design System) distribution's core, utility and per-component CSS/JS as attachable Drupal asset libraries.

---

The DSFR ships as a set of built CSS/JS files — a `core` bundle, a `utility` bundle, and one folder per UI component — under `libraries/dsfr/dist/`. This module makes those consumable from Drupal without hand-writing a libraries entry per component. A static `dsfr_libraries.libraries.yml` declares the `core` library (`core.min.css` plus the ES-module and nomodule JS variants) and a `utility` CSS library. `hook_library_info_build()` then scans `libraries/dsfr/dist/component/*` at runtime and registers one library per component directory, attaching that component's `<component>.min.css` and its `.module.min.js` / `.nomodule.min.js` variants and depending on `dsfr_libraries/core`. Themes and modules then attach these libraries (e.g. `dsfr_libraries/core`, `dsfr_libraries/button`) as needed. The module is purely a library declarer: no routes, permissions, services, blocks, plugins or configuration. `hook_requirements()` adds a runtime status-report error if `libraries/dsfr/` is missing, since the DSFR assets must be provided separately (the module does not vendor the DSFR itself). Installation therefore means placing the DSFR distribution at `web/libraries/dsfr` (e.g. via Asset Packagist's `npm-asset/gouvfr--dsfr`) and attaching the libraries from your theme/templates. This release is a pre-release alpha (1.0.0-alpha3).

---

- Attach the DSFR core styles and scripts to a theme.
- Add the DSFR utility CSS bundle to a page.
- Attach a single DSFR component library (e.g. `dsfr_libraries/button`).
- Auto-register every DSFR component as a Drupal library.
- Avoid hand-writing a `.libraries.yml` entry per DSFR component.
- Depend on `dsfr_libraries/core` from a custom library.
- Load the module/nomodule JS variants correctly per component.
- Build a French-government-compliant Drupal theme.
- Reference DSFR assets by library name in render arrays.
- Verify the DSFR distribution's presence via the status report.
- Keep DSFR assets versioned outside the module (in `libraries/`).
- Serve minified DSFR CSS/JS already marked as minified.
- Attach component libraries only on pages that need them.
- Integrate DSFR with a component-based theme.
- Provide DSFR styling to modules via `#attached['library']`.
- Upgrade DSFR by swapping the `libraries/dsfr` distribution.
- Use with a subtheme that consumes DSFR tokens.
- Detect a missing DSFR install before rendering breaks.
- Standardize DSFR usage across multiple themes on one site.
- Expose newly added DSFR components automatically after adding their folder.
- Share DSFR libraries across contrib modules on the same site.
