<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Velocity integrates the Velocity.js animation engine so themes and modules can attach smooth JS animations and its UI transition pack.
---
Velocity.js is a fast drop-in replacement for jQuery `$.animate()`. The base `velocity` module ships Velocity.js v1.5.2 and v2.0.6 (plain and minified) plus CDN variants declared in `velocity.libraries.yml`. On its own it implements `hook_page_attachments()` and — only when the `velocity_ui` submodule is NOT enabled — attaches the v1 minified library and UI pack globally, using the local copy if present under the module's `lib/` folder, otherwise the cdnjs CDN. The `velocity_check_installed()` helper decides local vs CDN.

The optional **Velocity UI** submodule replaces that with a configurable loader: a settings form (`/admin/config/user-interface/velocity/settings`, permission `administer velocity`) chooses version (v1/v2), attach method (local/CDN), minified/dev variant, UI-pack on/off, and per-path visibility (all pages except listed / only listed, with `*` wildcards). Its `hook_page_attachments()` reads `velocity.settings` config and attaches the chosen libraries, honouring a `?velocity=no` query override. Attach the library to your own render arrays via `#attached`, or let the UI submodule attach it site-wide.
---
- Enable `velocity` to load Velocity.js v1 site-wide automatically.
- Enable the `velocity_ui` submodule for a configuration UI.
- Choose Velocity.js v1.5.2 or v2.0.6 in the settings form.
- Load the library from the local copy bundled in the module.
- Load the library from the cdnjs CDN instead.
- Toggle the Velocity UI transition pack on or off.
- Switch between minified (production) and non-minified (dev) builds.
- Restrict loading to specific paths with `url.pages` wildcards.
- Load on all pages except a listed set of paths.
- Load only on an explicit list of paths.
- Disable Velocity on a single page with `?velocity=no`.
- Attach `velocity/velocity-v2.min.js` to a custom render array via `#attached`.
- Animate SVG elements with Velocity.js.
- Replace jQuery `$.animate()` calls with Velocity for performance.
- Build chained UI transitions with the UI pack.
- Prevent double-loading by leaving `load` off when a theme includes it.
- Gate the settings form behind the `administer velocity` permission.
- Flush caches automatically on saving Velocity settings.
- Fall back to CDN automatically when the local library is missing.