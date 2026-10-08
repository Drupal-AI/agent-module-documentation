<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `datatables` Views style plugin

The module **implements** a Views style plugin (it does not define a new plugin type).

- Plugin id **`datatables`**, title "DataTables", class
  `Drupal\datatables\Plugin\views\style\DataTables` extending core `Table`.
- Theme `views_view_datatables`; preprocess `template_preprocess_views_view_datatables()` builds
  the DataTables init object.
- `usesFields = TRUE` (a fields-based table). Core Table's `sticky` and `override` options are
  removed.

## Applying it

Build a view with **Fields**, set the display's **Format** to **DataTables**. In config this is:

```yaml
# views.view.<id> -> display.<display>.display_options
style:
  type: datatables
  options:
    elements: { search_box: true, table_info: true, save_state: false, table_tools: false }
    layout: { autowidth: false, themeroller: false, sdom: '' }
    pages: { pagination_style: 0, length_change: 0, display_length: 10 }
    hidden_columns: {  }
    filter_columns: {  }
    filter_columns_placeholder: '- Filter -'
    columns: { ... }        # inherited from Table: field => column mapping
    info: { ... }           # inherited from Table: per-column sortable/align/separator/empty_column
    default: <field>        # default sort column (from Table)
    order: asc              # default sort order (from Table)
```

Detect it: load the view and read
`display.<d>.display_options.style.type` — it equals `datatables`. Schema is
`views.style.datatables` (see `config/schema/datatables.views.schema.yml`).

## Options (schema `views.style.datatables`)

- **elements** — `search_box` (client filter box), `table_info` ("Displaying x–y of z" line),
  `save_state` (persist search/sort/page across reloads), `table_tools` (copy/print/export
  toolbar; adds the `datatables/datatables_tabletools` library and a `T` in the DOM).
- **layout** — `autowidth`, `themeroller` (jQuery UI), `sdom` (custom DataTables `sDom` string).
- **pages** — `pagination_style` (`full_numbers`, or `no_pagination` to disable the DT pager),
  `length_change` (show the page-length selector), `display_length` (rows per page).
- **Per-column** (`info[<field>]`): `sortable`, `default_sort_order`, `align`, `separator`
  (when combining fields into one column), `empty_column` (hide empty), `responsive`.
- **hidden_columns[<field>]** — `hidden` (bVisible=false) or `expandable` (child-row control
  column, adds a `dt-control` column).
- **filter_columns[<field>]** — per-column search/filter type; `thead_unsearchable` marks a
  column non-searchable. `filter_columns_placeholder` is the empty-filter placeholder text.

## What preprocess emits

`template_preprocess_views_view_datatables()` maps the above to a DataTables init object
(`aoColumns`, `aaSorting`, `bFilter`, `bInfo`, `bStateSave`, `bLengthChange`, `iDisplayLength`,
`sPaginationType`, `sDom`, `oLanguage`, etc.), attaches it as
`drupalSettings.datatables['#<table-id>']`, and loads `datatables/datatables` +
`datatables/datatables_core`. It also autodetects column `sType` (numeric/html/date) from the
first rendered rows. Tip: set the Views pager to show all items — DataTables paginates
client-side.
