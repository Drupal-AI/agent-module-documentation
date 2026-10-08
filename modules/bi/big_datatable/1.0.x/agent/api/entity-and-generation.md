<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Big Data Table — entity, routes, CSV→HTML generation, Drush

## Install / enable

`drush en big_datatable` (or `ddev drush en big_datatable`). No module dependencies are declared;
core `file` and `path_alias` must be enabled (they are in a standard install). Uploaded CSVs and
generated HTML land in `public://big_data_tables/`, so the public files directory must be writable.

## Routes & permissions (`big_datatable.routing.yml`)

| Route | Path | Access |
|---|---|---|
| `entity.big_datatable.collection` | `/admin/config/content/big-data-table` | `administer big_datatable` |
| `entity.big_datatable.add_form` | `/admin/config/content/big-data-table/add` | `administer big_datatable` |
| `entity.big_datatable.edit_form` | `/admin/config/content/big-data-table/{big_datatable}` | `administer big_datatable` |
| `entity.big_datatable.delete_form` | `.../{big_datatable}/delete` | `administer big_datatable` |
| `entity.big_datatable.view` | `/big-data-table/{big_datatable}` | `access content` |

`configure` (info.yml) = `entity.big_datatable.collection`. A menu link
(`big_datatable.links.menu.yml`) puts the collection under Configuration → Content Authoring, and an
action link (`.links.action.yml`) adds "Add big data table" on the collection page. The single
permission is `administer big_datatable` (`big_datatable.permissions.yml`).

## The workflow (author path)

1. Add/edit a table via `BigDataTableForm::form()` — fields: `name` (label), `id` (machine_name),
   `title`, `body` (`text_format`), `bigdata_file` (`managed_file`, `#upload_location`
   `public://big_data_tables/`, `#upload_validators` → `file_validate_extensions: [csv]`,
   required), and `alias` (a URL alias, must start with `/`, uniqueness checked in
   `validateForm()`).
2. `save()` marks the uploaded file permanent, records file usage
   (`file.usage->add(..., 'big_datatable', ...)`), deletes the previously-referenced file if it
   changed, saves the config entity, and creates/updates a `path_alias` for
   `/big-data-table/{id}` via `tablePagePath()`.
3. On an existing entity with a file, a **"Generate HTML"** submit button (`::generateHtml`) runs a
   **Batch** (`processCsvToHtml`): it `fopen`/`fgetcsv`-parses the CSV (comma delimiter, 1000-byte
   line cap), builds the render array, and `file_put_contents()`es the rendered HTML to
   `public://big_data_tables/<id>.html`. `batchFinished()` reports the path.

## CSV → HTML rendering (`generateHtmlFromCsv()`)

Shared logic in both `BigDataTableForm` and `HtmlGeneratorCommands`:

- First CSV row becomes `#header`; remaining rows become `#rows`, each cell passed through
  **`array_map('htmlspecialchars', $row)`** (cell values are HTML-escaped at generation time).
- Builds `#theme => 'big_datatable_table'` with `#header`, `#rows`, `#footer => [$header]`, and an
  `Attribute` giving the `<table>` `id="maintable"` and DataTables CSS classes.
- Rendered with `renderer->renderInIsolation($build)`; a debug line is logged to the
  `big_datatable` channel with `print_r` of header+rows (verbose; disable/lower in production).
- Template `templates/big-datatable-table.html.twig` emits `<thead>/<tbody>/<tfoot>` (Twig
  auto-escapes `{{ cell }}`) plus a mobile "Sort by" dropdown scaffold.

## Serving the page (`BigDataTableController::view()`)

Renders `#markup` for the entity title (`<h2>`), the body value
(`getBody()['value']` wrapped in a `<div class="big-table-description">`), and — if
`public://big_data_tables/<id>.html` exists (`fileExists()`/`getFileContents()` wrap
`file_exists`/`file_get_contents`) — the pre-generated HTML; otherwise "The HTML file does not
exist." Attaches library `big_datatable/big_datatable_styling`. `title()` is the route
`_title_callback`. The `<id>` used to build the file path is the entity's own machine name (route
`{big_datatable}` upcast to the entity), not free-form request input.

## Client-side DataTables (`js/app.js`)

`Drupal.behaviors.bigDatatable` calls `$('#maintable').DataTable(...)`: paging
(10/25/50/100/all), `mark` search highlighting, `Bfrtip` DOM with copy/Excel/CSV/print/PDF export
buttons + column visibility, a mobile "Sort by" dropdown, and per-column footer search inputs.
Library `big_datatable.libraries.yml` → `js/jquery.dataTables.min.js` + `js/app.js`, CSS bundle,
deps `core/jquery`, `core/drupal`. **All interaction is client-side over the static table** — no
server round-trips, no query building.

## Drush

`big_datatable.html_generator` service (`drush.services.yml`) →
`HtmlGeneratorCommands::getBigDataTableEntities()`, command
`big_datatable:get-big-data-table-entities` (alias **`bigdata-generate-html`**). Loads every
`big_datatable` entity, reads each one's referenced CSV, and regenerates its
`public://big_data_tables/<id>.html`. Use it to rebuild all table HTML after a bulk import or
config sync. (Its `create()` references `ContainerInterface` without importing it, but the service
is wired via explicit `arguments` in the yml, so `create()` is never invoked.)

## Operate / troubleshoot

- After changing a CSV, re-open the entity and click **Generate HTML** (or run the Drush command)
  — saving alone does not regenerate the HTML file.
- If the view page shows "The HTML file does not exist.", the HTML was never generated or the
  public files dir isn't writable.
- Deleting an entity does not remove its `<id>.html`; clean `public://big_data_tables/` manually if
  needed.
