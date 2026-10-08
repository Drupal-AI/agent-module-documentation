<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# PhpSpreadsheet — agent index

Dependency-only wrapper module. Its single job is to declare a Composer requirement on
`phpoffice/phpspreadsheet` (`~1`) so the `PhpOffice\PhpSpreadsheet\*` classes autoload on the
site. Other contrib/custom modules depend on it to read and write spreadsheet files
(xlsx, xls, ods, csv, html).

- Version 2.1.x, core `^8 || ^9 || ^10`. No other module dependencies.
- The whole module is two files: `phpspreadsheet.info.yml` and `composer.json`. It ships
  no routes, services, forms, permissions, config, hooks, drush commands, or plugins.
- No settings page (`configure: null`) — nothing to configure; enable it and use the library.

Solution docs:
- **Depend on it and use the PhpSpreadsheet classes** → [api/library.md](api/library.md)

Key facts:
- Module machine name: `phpspreadsheet` (project `drupal/phpspreadsheet`).
- Composer requirement: `phpoffice/phpspreadsheet: ~1`.
- Provided namespace: `PhpOffice\PhpSpreadsheet\` (e.g. `Spreadsheet`, `IOFactory`,
  `Writer\Xlsx`, `Writer\Csv`, `Reader\Xlsx`).
- Nothing to enable beyond the module itself; a dependent module lists `phpspreadsheet` in
  its own `.info.yml` `dependencies:`.
