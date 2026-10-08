<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Form Style (form_style) — agent index

**A showcase page rendering (nearly) all Form API elements in the front-end theme to test form usability and accessibility.**

- **Version:** 2.0.x (from `2.0.0`)
- **Core:** ^11 || ^12
- **Routes:** `form_style.form` /admin/form_style (`_permission: 'access content'`, `_admin_route: FALSE` — renders in front-end theme); `form_style.settings` /admin/config/form_style (`administer site configuration`).
- **Configure:** `form_style.settings`.
- **Security:** the showcase is reachable by anyone with `access content` (near-public) BY DESIGN — the README warns it should NOT be enabled in production. No data mutation beyond form validation; no external calls.
