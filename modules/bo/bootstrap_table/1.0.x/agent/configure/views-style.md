<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure the Bootstrap Table Views style

## Select it
Edit a View → in a display's **Format** row choose **Bootstrap Table** (plugin id
`bootstraptable`). It extends the core **Table** style (`usesFields = TRUE`), so you still map
fields to columns and set per-column sortable/align exactly as with core tables. The style
removes the core `sticky` and `override` options and adds its own groups. Requires the
`administer views` permission (a restricted admin permission), like any Views style change.

Options are stored in the view's display config under `style_options` and validated by the
`views.view.bootstraptable` schema. There is no global settings page.

## Option groups (form in `BootstrapTable::buildOptionsForm`)
Values are consumed in `template_preprocess_views_view_bootstraptable()` and emitted as
`data-*` attributes on the `<table>` (bootstrap-table reads these), plus on-demand libraries.

### Widgets & Elements (`options['elements']`)
- `search_box` → `data-search` (+ accent-neutralise/align/highlight). Client-side search box.
- `table_info` → maps to `show-columns`.
- `save_state` → `cookie` library + `data-cookie-id-table` = viewId+displayId (persists state).
- `show-refresh`, `show-columns-toggle-all`, `show-pagination-switch`, `show-toggle`,
  `show-fullscreen`, `card-view` → matching `data-*` toolbar toggles.
- `height` → `data-height` (fixed height with internal scroll; empty removes it).
- `thousands_separator_html` / `decimal_mark_html` / `thousands_separator_output` /
  `decimal_mark_output` → assembled into `data-export-options` JSON `numbers`.
- `export-name` → export file name; passed through `\Drupal::token()->replace(..., ['view'=>$view])`
  so Views/global tokens resolve.
- Note: element options are skipped while rendering a Views **live preview**
  (`empty($is_live_preview)` guard).

### Extensions (`options['extension']`)
`auto-refresh`, `show-copy-rows`, `show-print`, `show-export`, `filter-control`,
`advanced-search`, `mobile-responsive`, `group-by`, `show-multi-sort`, `show-jump-to`,
`reorderable-rows`, `resizable`, `sticky-header`, `url` (from-URL), `defer-url`
(→ `data-side-pagination=server`), `locale`. Each enabled extension attaches
`bootstrap_table/<extension>` and sets a `data-<extension>` attribute; special cases:
`auto-refresh`→`data-show-refresh`, `advanced-search`→`data-regex-search` + `data-id-table`,
`mobile-responsive`→`data-check-on-init`, `show-jump-to`→`data-pagination`,
`show-copy-rows`→`data-click-to-select`.

### Pagination (`options['pages']`)
`pagination_style` (Two-Button / Full Numbers / No Pagination), `length_change`,
`display_length` (default page size → `data-page-size`, `data-pagination=true`).

### Bootstrap styles (`options['bootstrap_styles']`)
Checkboxes `striped` / `bordered` / `hover` / `sm` → CSS classes `table-<style>`.

### Footer sum (`options['footer']`)
`show-footer`, `sum-field` (checkboxes limited to numeric-ish field types:
`number_integer`, `number_decimal`, `bigint_item_default`, `list_default`,
`commerce_price_default`), `sum-title`, `sum-title-field`. Emits `data-show-footer` and
per-field `data-footer-formatter` attributes; a `sumFooter` variable is passed to the Twig
template to register the JS formatter.

## Views Bulk Operations
If a `views_bulk_operations_bulk_form` column is present, the preprocess adds
`data-click-to-select`, the `vbo-table` class, and attaches `bootstrap_table/vbo`.

## Libraries / assets
`bootstrap_table.libraries.yml` declares `bootstrapTable` and per-extension libraries pointing at
`//cdn.jsdelivr.net/npm/bootstrap-table/...` (external, minified, v1.27.0). The base library also
loads a local `js/jquery-deprecated-function.js` shim and depends on `core/jquery`. To self-host,
override these library definitions in your theme/module.
