<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Vivus (vivus) — agent index

**Integrates Vivus.js to animate SVGs as if drawn; optional `vivus_ui` submodule manages named animations.**

- **Version:** 1.0.x
- **Core:** ^8.8 || ^9 || ^10 || ^11 · **Package:** User interface
- **Library:** Vivus.js 0.4.6 (local `/libraries/vivus/dist/vivus.min.js` or jsDelivr CDN fallback)
- **Base module:** no routes/permissions/config; attaches the library via `hook_page_attachments` when `vivus_ui` is absent. Helper option lists in `vivus.module`.
- **Submodule `vivus_ui`:** routes under `/admin/structure/vivus` (add/edit/delete/duplicate) and `/admin/config/user-interface/vivus`, all `_permission: administer vivus`, admin routes. Service `vivus.animation_manager` (`VivusManager`).
- **Security:** All UI routes are gated by `administer vivus` and flagged as admin routes; no anonymous or mutating endpoints. The base module only attaches a front-end JS library (with a CDN fallback) and animates SVGs already on the page. No security findings.

See [configure/animations.md](configure/animations.md)