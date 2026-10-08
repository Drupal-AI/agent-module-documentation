<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Ultimate Table Field (ultimate_table_field) — agent index

Provides a single field type, `ultimate_table`, that stores an entire table (columns + rows + an
optional legend) as **one serialized blob per field item**, edited with an in-place grid widget and
an AJAX modal cell editor, and displayed with a themeable core `#type => table`. Each cell holds a
**list of typed cell-items** handled by an extensible plugin system (`UltimateTableCellField`); the
four bundled cell types are `text`, `text_long`, `link` and `file`. There is no dedicated settings
page — everything is configured per field instance (settings), per form-display (widget) and per
view-display (formatter).

The editing UI is a custom `ultimate_table` FormElement that renders the grid, add/remove buttons and
one hidden JSON input per cell; an `Add`/edit link opens the modal form (route
`ultimate_table_field.open_modal_form`) which edits one cell and posts its JSON back into the grid.

- Depends on: none declared in `.info.yml`. (Field plugins require core's **Field** module to create
  fields; it is not listed as a dependency.) No `.module` file.
- Core: `^11`. Package: `Field types`.
- No settings page / `configure` route. No permissions, no drush, **no `config/schema/`**.
- Defines one plugin type: **`UltimateTableCellField`** (manager `plugin.manager.ultimate_table_cell_field`).
- Two update hooks in `.install` migrate old stored-value shapes (`_update_10101`, `_update_10102`).

## What you'd do → where

- **Add the field / understand storage, widget and formatter settings (themes, stripes, legend)** →
  [fields/field.md](fields/field.md)
- **Add a custom cell content type, or alter the bundled ones (`text`/`text_long`/`link`/`file`)** →
  [plugins/cell-field.md](plugins/cell-field.md)
- **Understand the `ultimate_table` render element, the modal cell editor, its route and data flow** →
  [forms/modal-editor.md](forms/modal-editor.md)

## Key facts (real machine names)

- Field type / widget / formatter — all id `ultimate_table`
  (`Plugin/Field/FieldType|FieldWidget|FieldFormatter/UltimateTable*`). Storage: one serialized
  `blob` column `value`; value = `['columns' => …, 'rows' => …, 'legend' => …]`.
- Render element: `ultimate_table` (`Element\UltimateTable`, `@FormElement`, + `UltimateTableTrait`).
- Route: `ultimate_table_field.open_modal_form` → `/admin/config/table/modal-form`
  (`_admin_route: TRUE`), controller `Controller\ModalFormController::openModalForm`, form
  `Form\ModalForm` (id `ultimate_table_modal_form`).
- Plugin type: annotation `Annotation\UltimateTableCellField` (fields `id`, `label`), interface
  `UltimateTableCellFieldInterface`, base `UltimateTableCellFieldBase`, manager
  `UltimateTableCellFieldManager` (service `plugin.manager.ultimate_table_cell_field`), discovery dir
  `Plugin/UltimateTable/CellField`, alter hook `ultimate_table_cell_field_info`.
- Bundled cell-field plugin ids: `text`, `text_long`, `link`, `file`. File cell: `managed_file`,
  extensions `pdf doc docx`, dir `public://ultimate-table/documents`.
- Field settings: `allowed_types`, `enable_legend`. Formatter settings: `legend_position`
  (`before`/`after`), `table_theme` (15 colours), `table_style` (`striped-odd`, `striped-even`,
  `filled-head`, `row-hover`, `side-filled`), `table_color` (declared, unused).
- Libraries: `ultimate_table_field/style`, `ultimate_table_field/table-actions`,
  `ultimate_table_field/table-themes`.
