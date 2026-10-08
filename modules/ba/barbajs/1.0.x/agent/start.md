<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Barba JS (barbajs) — agent index

Integrates the **Barba.js** JS library for smooth, SPA-like page transitions. Package *User interface*.
Core `^9.5 || ^10 || ^11`. License GPL-2.0-or-later. Version 1.0.0-alpha1 (dir `1.0.x`).
**No dependencies** on other modules; **no permissions, no routes, no services, no plugins** in the base
module. Ships one submodule, **barbajs_ui**, for admin configuration.

- **Base module: how the library loads and attaches** → [integration/loading.md](integration/loading.md)
- **Submodule Barba JS UI: settings form, config, path/theme rules** →
  [../modules/barbajs_ui/1.0.x/agent/start.md](../modules/barbajs_ui/1.0.x/agent/start.md)

## What it actually is (from source)

- A library-integration module. `barbajs.libraries.yml` defines named libraries for the bundled UMD
  builds (`barba`, `barba.min`, `barba_css[.min]`, `barba_prefetch[.min]`, `barba_router[.min]`) under
  `dist/**`, plus matching `*.cdn[.min]` libraries that point at pinned **jsDelivr** URLs
  (`@barba/core@2.10.3`, `@barba/css@2.1.16`, `@barba/prefetch@2.2.0`, `@barba/router@2.1.11`).
- `barbajs.module` `hook_page_attachments()` (`barbajs_page_attachments`): **only attaches automatically
  when the `barbajs_ui` submodule is NOT enabled.** It skips the installer, then attaches
  `barbajs/barba.min` if a local build exists, else `barbajs/barba.cdn.min`. When `barbajs_ui` is on, the
  submodule takes over attachment.
- `barbajs_check_installed()` returns TRUE if `dist/core/barba.umd.min.js` exists in the module, else
  probes `/libraries` via `barbajs_find_library()` (core `LibrariesDirectoryFileFinder`, searches
  `sites/*/libraries`, root `libraries`, profile `libraries`).
- No config, no schema, no permissions, no forms, no hooks beyond `hook_help`, `hook_install` (a status
  message) and `hook_page_attachments`. You write transitions yourself with `barba.init(...)` in a theme
  or custom module. See [integration/loading.md](integration/loading.md).
