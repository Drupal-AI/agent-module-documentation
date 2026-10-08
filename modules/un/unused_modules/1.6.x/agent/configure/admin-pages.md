<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The admin report pages

Menu: **Configuration → Development → Unused Modules**. All routes require the core
**`administer modules`** permission. The `configure` route (info.yml) is
`unused_modules.overview.projects.disabled`.

## Routes

| Route | Path | Shows |
|---|---|---|
| `unused_modules.overview.projects.disabled` | `/admin/config/development/unused_modules/projects/disabled` | Projects with **no** enabled modules (safe to delete). Default landing tab. |
| `unused_modules.overview.projects.all` | `/admin/config/development/unused_modules/projects/all` | All projects + whether each has enabled modules. |
| `unused_modules.overview.modules.disabled` | `/admin/config/development/unused_modules/modules/disabled` | Disabled modules within fully-disabled projects. |
| `unused_modules.overview.modules.all` | `/admin/config/development/unused_modules/modules/all` | All non-core modules with enabled/has-modules flags. |

Controller: `UnusedModulesController::renderProjectsTable` / `renderModulesTable` (the `filter`
default `disabled`|`all` picks the view). Local tasks give the **Projects / Modules** tabs and
the **Fully disabled / Also enabled** sub-tabs.

## Concepts

- **Project** = a downloadable Drupal.org project (e.g. *Views*); may contain several
  **modules** (e.g. `views`, `views_ui`).
- A project is listed as **safe to delete** only when **all** its modules are disabled.
- **Core modules are never listed** — do not delete them.
- A module appearing in multiple locations is listed once, in its most specific location.

## Caveats (from the module)

Always back up code + DB first, **uninstall** modules before deleting their directories, and
double-check results. The page is intentionally a heavy load (it scans the whole modules tree).
It only reports — it never uninstalls or deletes anything for you.
