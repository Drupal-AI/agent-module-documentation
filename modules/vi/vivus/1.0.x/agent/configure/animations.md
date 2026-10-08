<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring Vivus animations

## Base module (`vivus`)
- Registers the `vivus/vivus.js` (local) and `vivus/vivus.cdn` (jsDelivr) libraries, Vivus.js 0.4.6.
- `hook_page_attachments` auto-attaches the library site-wide ONLY when `vivus_ui` is not enabled; prefers the local copy at `/libraries/vivus/dist/vivus.min.js`, else the CDN.
- Option helpers: `vivus_type_options()` (delayed/sync/oneByOne/scenario/scenario-sync), `vivus_start_options()` (inViewport/manual/autostart), `vivus_timing_options()`, `vivus_switch_options()` (erase/fade).

## UI submodule (`vivus_ui`)
Enable `vivus_ui` (depends on `vivus`). All routes require permission `administer vivus`:
- `/admin/structure/vivus` — list (`VivusAdmin`).
- `/admin/structure/vivus/add`, `/edit/{vid}`, `/delete/{vid}`, `/duplicate/{vid}` — manage animations (`VivusForm`, `VivusDelete`, `VivusDuplicate`).
- `/admin/config/user-interface/vivus` — global settings (`VivusSettings`).

`VivusManager` (service `vivus.animation_manager`) stores animation definitions; config schema `vivus.settings`.

## Usage
Instantiate in markup, e.g. `new Vivus('my-svg', { type: 'delayed', duration: 200 })`. SVG paths must have a stroke and no fill; avoid hidden paths and `text` elements.
