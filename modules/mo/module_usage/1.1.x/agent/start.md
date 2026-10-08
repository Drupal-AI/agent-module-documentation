<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Module usage (module_usage) — agent index

**Documents how/why/where modules are used** (descriptions, notes, URLs) with version-change activity tracking, reports, and JSON import/export.

- **Version:** 1.1.x (1.1.1)
- **Core:** ^10 || ^11 — depends on jquery_ui_accordion.
- **Permissions:** `administer module_usage` (restricted), `view module_usage`, `edit module_usage`, `delete module_usage`, `create module_usage`.
- **Routes:** add/edit/delete URL & note (perm edit/delete); view/report/import/export (perm `view module_usage`).
- **Services:** `module_usage.usage_service`, `module_usage.query` (`QueryService`, custom tables, parameterised SQL).
- **Drush:** `moduse:export`, `moduse:import`.
- **Security:** all routes permission-gated; SQL parameterised.

See [drush/commands.md](drush/commands.md) and [api/import-export.md](api/import-export.md).