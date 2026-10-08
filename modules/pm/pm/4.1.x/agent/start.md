<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# PM (pm) — agent index

**Base module of the Drupal PM project-management suite: a plugin-driven dashboard plus a shared content-entity framework consumed by many work-tracking submodules.**

- **Version:** 4.1.x (4.1.0-alpha1)
- **Core:** ^10 || ^11
- **Package:** Project Management
- **Key routes:** `/pm` (`pm.overview`, `_permission: access content`) renders the dashboard; `/admin/pm*` (`administer pm configuration`).
- **Permissions:** `administer pm configuration` (restricted).
- **Services:** `pm.pm_key` (keyvalue auto-increment key generator), `pm.config`, `pm.hierarchy`, `pm.etag`, `pm.computed_parent`, `plugin.manager.pm_dashboard_item`.
- **Plugin type:** `pm_dashboard_item` (declared in `*.pm_dashboard_items.yml`).
- **Submodules:** pm_project, pm_task, pm_sub_task, pm_story, pm_epic, pm_feature, pm_board, pm_invoice, pm_expense, pm_note, pm_persona, pm_organization, pm_timetracking, pm_priority, pm_status, pm_rest, pm_ui, pm_presets.

**Security:** admin config routes are permission-gated (`administer pm configuration`, restricted). The `/pm` dashboard uses `access content` but only renders a path-validated list of links to individually access-checked sub-tools — it returns no data and performs no mutation. No anonymous or unverified mutating endpoints.

See [configure/dashboard.md](configure/dashboard.md).
