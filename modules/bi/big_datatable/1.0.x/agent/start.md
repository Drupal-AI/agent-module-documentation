<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Big Data Table (big_datatable) — agent index

Config-entity module: an admin uploads a CSV, the module pre-renders it to a static HTML
`<table>` file, and a public page serves that file with a bundled jQuery **DataTables** UI
(sort / search / paging / export) running **entirely client-side**. Package `Big Data Table`.
Core `^8 || ^9 || ^10 || ^11`. License GPL-2.0-or-later. Version 1.0.4. No declared module
dependencies (uses core `file` and `path_alias` at runtime).

## What it actually provides

- **Config entity** `big_datatable` (`src/Entity/BigDataTable.php`, `@ConfigEntityType`,
  `config_prefix = big_datatable`, `admin_permission = administer big_datatable`). Exported keys:
  `id`, `name`, `title`, `body`, `bigdata_file`, `url`. Also implements `\JsonSerializable`
  (`jsonSerialize()` returns id/name/title/`check_markup(body)`/fid — no route consumes it).
- **1 permission**: `administer big_datatable` (`big_datatable.permissions.yml`).
- **5 routes** (`big_datatable.routing.yml`): collection/add/edit/delete admin forms under
  `/admin/config/content/big-data-table`, all `_permission: administer big_datatable`; plus the
  public **view** page `entity.big_datatable.view` at `/big-data-table/{big_datatable}`
  (`_permission: access content`).
- **Controller** `BigDataTableController` (`src/Controller/`): `view()` reads
  `public://big_data_tables/<id>.html` and renders it, plus title + body, attaching the
  `big_datatable/big_datatable_styling` library.
- **Entity form** `BigDataTableForm` (`src/Form/`): name/id/title/body(text_format)/CSV
  managed_file/alias fields, a **"Generate HTML"** batch that converts the CSV, alias creation via
  `path_alias`, and file-usage bookkeeping.
- **Drush command** `HtmlGeneratorCommands` (`src/Commands/`, `drush.services.yml`):
  `big_datatable:get-big-data-table-entities` (alias `bigdata-generate-html`) regenerates HTML for
  all entities.
- **Theme hook** `big_datatable_table` (`big_datatable.module`) + template
  `templates/big-datatable-table.html.twig`. Config schema in `config/schema/`.
  List builder `BigTableListBuilder`.

## Solution docs

- **Entity, routes, CSV→HTML generation, Drush, how to operate it** →
  [api/entity-and-generation.md](api/entity-and-generation.md)
- **Config entity schema + exported keys** → [config/entity.md](config/entity.md)

## Notes

- DataTables is bundled in `js/` and driven by `js/app.js` (`Drupal.behaviors.bigDatatable`) over
  the static table (`#maintable`) — there is **no server-side data/AJAX endpoint** and **no
  database query**; all sort/search/paging/export is in-browser.
- `src/Entity/BigDataTable.php` `links` annotation points at `/admin/system/...` and
  `config_export` lists a `url` key with no matching property — cosmetic mismatches with the
  actual `/admin/config/content/...` routes; harmless.
