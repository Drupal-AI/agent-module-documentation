<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Libraries UI — agent index

Read-only inspector for Drupal **asset libraries**. Adds an admin report at
`/admin/reports/libraries` listing every CSS/JS library from installed modules, themes and core, with
version/files/dependencies. No configuration, no storage. One route, one permission, one service, one
Drush command, one theme hook.

- **The report page (route, path, access) and the theme hook** →
  [configure/report-page.md](configure/report-page.md)
- **The `libraries_ui` service (`getAllLibraries()`) for programmatic use** →
  [api/service.md](api/service.md)
- **Drush `libraries:debug` (alias `ld`)** → [drush/debug.md](drush/debug.md)
- **The `access libraries_ui` permission** → [permissions/permissions.md](permissions/permissions.md)

Key facts: route `libraries_ui.overview` = `/admin/reports/libraries` (this is also the `configure`
route), permission `access libraries_ui`. Service `libraries_ui`
(`Drupal\libraries_ui\LibrariesUiService`), method `getAllLibraries()` returns an array keyed
extension → library → definition. Data comes from core's `library.discovery` service; the module
stores nothing.
