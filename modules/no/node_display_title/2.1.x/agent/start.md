<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Node Display Title (node_display_title) — agent index

**Adds a `display_title` base field to nodes and shows it to visitors while admins keep the real title.**

- **Version:** 2.1.x (release 2.1.3)
- **Core:** ^8.8 || ^9 || ^10 || ^11 · Dependency: field
- **Config route:** `node_display_title.settings` → `/admin/config/content/display-title-settings` (permission `manage display title field settings`)
- **Permissions:** `manage display title field settings`, `access display title field`, per-bundle `access {bundle} display title field` (via `NodeDisplayTitlePermissions`)
- **Mechanism:** `hook_entity_base_field_info` adds `display_title`; entity class swapped to `NodeDisplayTitle` (overrides `getTitle()`/`label()` on non-admin routes); `hook_node_load` copies display title into `title` for front-end views (not on edit/delete)
- **Config:** `node_display_title.settings:bundles`

See [configure/settings.md](configure/settings.md)

**Security:** Admin config form + permission-gated form field only; field visibility gated by global/per-bundle `access ... display title field` permissions plus the per-bundle enable flag. No anonymous or mutating endpoints. No security findings.
