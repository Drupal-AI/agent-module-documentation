<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Unused Modules — agent index

Reports modules/projects on disk that are fully disabled and safe to delete. Read-only — it
never changes the site. No permissions of its own (uses core `administer modules`), no config
schema, no config entities.

- **The Drush command (`unused:modules`, args, fields, JSON output)** →
  [drush/commands.md](drush/commands.md)
- **The admin report pages (routes, Projects vs Modules, Fully-disabled vs All)** →
  [configure/admin-pages.md](configure/admin-pages.md)
- **The `unused_modules.helper` service and the decorated-extension data** →
  [api/helper.md](api/helper.md)

Key facts:
- A **module** is unused when disabled; a **project** is "safe to delete" only when **none** of
  its modules are enabled.
- Drush: `drush unused:modules [projects|modules] [disabled|all]` (aliases `um`,
  `unused-modules`). Add `--format=json` for machine-readable output.
- Report: `/admin/config/development/unused_modules/projects/disabled` (configure route
  `unused_modules.overview.projects.disabled`), permission `administer modules`.
- Core modules are always excluded. Grouping uses the `.info.yml` `project` key, else the
  Composer package, else a `custom` bucket.
