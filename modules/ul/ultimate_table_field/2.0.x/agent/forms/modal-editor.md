# The `ultimate_table` render element and the modal cell editor

The in-place editing UI is two pieces: a custom Form API render element `ultimate_table` that draws
the grid of add/remove buttons and hidden per-cell inputs, and a separate AJAX **modal form** that
edits one cell's content and posts the JSON back into the grid.

## Render element — `Element\UltimateTable`

`src/Element/UltimateTable.php`, `@FormElement("ultimate_table")`, uses `UltimateTableTrait`.
Injected with the cell-field manager. Used by the field widget (`#type => 'ultimate_table'`).

- `getInfo()` defaults: `#input => TRUE`, process `elementProcess`, validate `elementValidate`
  (no-op), `#theme_wrappers => ['container']`, `#allowed_types => []`.
- Widget-supplied properties: `#default_value` (`['values' => <stored table>]`), `#allowed_types`,
  `#enable_legend` (adds a `text_format` legend with format `full_html`), `#enable_summary`.
- `elementProcess()` keeps `row_count` / `column_count` / `values` in `$form_state` keyed by a
  per-element id (`ut-…`), builds a `#type => table` with `#tabledrag` weight ordering, and for each
  cell emits a hidden input `data-input-<i>-<j>--<id>` holding `Json::encode($items_data)` plus a
  summary fieldset. Row/column/item add + remove are `#ajax` submit buttons whose names encode the
  element id as `add_row::<id>`, `add_column::<id>`, `update_table::<id>`, `row_remove:<i>::<id>`,
  `column_remove:<j>::<id>`, `item_remove:<i>_<j>_<k>` — parsed back in `elementSubmitCallback()` /
  `updateTable()`. Attaches libraries `ultimate_table_field/style`, `…/table-actions`,
  `core/drupal.dialog.ajax`.
- `valueCallback()` reads the submitted grid back out of the hidden `data` inputs (each is
  `Json::decode`d) into `['values' => ['columns' => …, 'rows' => …, 'legend' => …]]`.

The trait (`UltimateTableTrait`) builds the summary fieldset per cell, the remove buttons, and the
`Add` / edit **modal links** (`modalLinkBuilder()`), each a `use-ajax` link to route
`ultimate_table_field.open_modal_form` carrying the cell context in the query string
(`items_data`, `op`, `row_index`, `column_index`, `item_index`, `allowed_types`, `wrapper_id`).

## Modal open route + controller

Route `ultimate_table_field.open_modal_form` → path `/admin/config/table/modal-form`, controller
`ModalFormController::openModalForm`, `options: {_admin_route: TRUE}`.

`ModalFormController::openModalForm()` (`src/Controller/ModalFormController.php`) builds
`ModalForm` via the form builder and returns an `AjaxResponse` with an `OpenDialogCommand` targeting
`#ultimate-table-data-dialog-wrapper` (50% width, modal).

## Modal form — `Form\ModalForm`

`src/Form/ModalForm.php`, form id `ultimate_table_modal_form`.

- `buildForm()` reads the cell context from the **request query** (`items_data`, `allowed_types`,
  `op`, `row_index`, `column_index`, `item_index`, `wrapper_id`), then renders a `data_type` select
  (options = cell-field plugins, filtered by `allowed_types`) plus, once a type is chosen, that
  plugin's `buildCellField()` subform. A hidden `update_modal` submit drives the AJAX rebuild when
  the type changes (`triggerUpdateClick` → `updateModalForm`).
- `submitModalFormAjax()` (the `Save` button's AJAX callback) reads the chosen `type` and its value,
  calls the plugin's `cellFieldAlterSubmitted()`, assembles `['type' => $type, $type => $value]`, and
  appends/replaces it in `itemsData`. It returns `InvokeCommand`s that write
  `Json::encode($itemsData)` into the grid's hidden input `#data-input-<row>-<col>--<wrapper_id>`,
  close the dialog, and trigger the grid's `update_table::<id>` button to re-render the cell summary.

## Data flow summary

widget → `ultimate_table` element (grid + hidden JSON inputs) → `Add`/edit link opens `ModalForm`
for one cell → `Save` posts the cell JSON back into the hidden input and refreshes the grid →
`valueCallback` collects all hidden inputs into the stored `columns`/`rows`/`legend` structure →
`massageFormValues` wraps it as `['value' => …]` for the `ultimate_table` field storage.
