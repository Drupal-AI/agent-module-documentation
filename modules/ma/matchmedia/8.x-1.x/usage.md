<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Provides the `matchmedia` polyfill JavaScript asset library that Drupal core dropped in 9, so themes/modules that still depend on `core/matchmedia` keep working.

---

The module ships a `matchmedia/matchmedia` (and `matchmedia/matchmedia.addListener`) asset library and implements `hook_library_info_alter()` (`matchmedia.module`) to (a) remove the now-absent `core/matchmedia` and `core/matchmedia.addListener` libraries from the `core` extension, and (b) rewrite any other library that still declares a dependency on `core/matchmedia*` so it points at the module-provided replacement instead. There is no configuration, no route, no permission and no service - installing the module is the whole feature. It exists purely as a compatibility shim for the `window.matchMedia` / `addListener` polyfill that older code relied on. `hook_help()` links to the core change record (node/3086653).

---

- Keep a legacy theme or contrib module that depends on `core/matchmedia` working after upgrading Drupal core past 8.x.
- Restore `window.matchMedia` polyfill behaviour for older browsers (e.g. legacy IE) that lack native support.
- Transparently redirect a module's `core/matchmedia` library dependency to the replacement without editing that module.
- Restore the `matchmedia.addListener` variant used by code registering media-query listeners.
- Provide the polyfill site-wide simply by enabling the module (no config step).
- Avoid JavaScript errors on pages whose scripts call `matchMedia()` against the removed core library.
- Bridge a slow migration where third-party JS still assumes the core polyfill exists.
- Support responsive-behaviour JS on browsers without `matchMedia` during a transition period.
- Remove the shim later by simply uninstalling once dependents are updated.
- Serve as a reference for how to re-provide a removed core asset library via `hook_library_info_alter()`.
- Ensure `array_search`-based dependency rewriting only touches non-core extensions (core copies are unset entirely).
- Use on Drupal 8/9/10 sites (`core_version_requirement: ^8 || ^9 || ^10`).
- Package a browser-compatibility polyfill without bundling it into every theme.
- Diagnose "matchmedia library not found" render errors by enabling this module.
- Keep old carousel/responsive libraries functional on legacy hardware.
