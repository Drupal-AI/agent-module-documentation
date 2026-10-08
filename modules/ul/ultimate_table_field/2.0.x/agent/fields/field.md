# The `ultimate_table` field type, widget and formatter

One field type (`ultimate_table`) with a matching default widget and formatter, all sharing the id
`ultimate_table`. It stores an entire table (columns + rows + optional legend) as a single
serialized value on one field item, using an extensible per-cell plugin system (see
[../plugins/cell-field.md](../plugins/cell-field.md)).

## Field type — `UltimateTableFieldType`

`src/Plugin/Field/FieldType/UltimateTableFieldType.php`, `@FieldType(id="ultimate_table")`,
`default_widget="ultimate_table"`, `default_formatter="ultimate_table"`.

- **Storage** (`schema()`): a single column `value`, `type => blob`, `not null`, `serialize => TRUE`.
  The whole table is one PHP-serialized blob per field item — not one column per table column. Not
  queryable at the DB level.
- **Property** (`propertyDefinitions()`): one property `value` of type `any`, required.
- **Stored value shape** (`$item->value`):
  ```php
  [
    'columns' => [ /* header cells */
      // each column = a list of cell-items:
      [ ['type' => 'text', 'text' => 'Name'], ... ],
      ...
    ],
    'rows' => [
      [ /* row */
        [ ['type' => 'text', 'text' => 'Alice'], ... ], // cell = list of cell-items
        ...
      ],
      ...
    ],
    'legend' => '<p>optional caption</p>', // raw string, only when the legend setting is on
  ]
  ```
  Every cell is a **list of cell-items**; each cell-item is `['type' => <plugin_id>, <plugin_id> => <value>]`.
- **`isEmpty()`**: returns `FALSE` unconditionally during an AJAX (`XmlHttpRequest`) request — this
  deliberately bypasses required-field validation while the table is being edited in place. Outside
  AJAX it treats the item as empty only when both `columns` and `rows` are effectively empty.
- **Field settings** (`defaultFieldSettings()` / `fieldSettingsForm()`), stored per field instance:
  - `allowed_types` — `checkboxes` of cell-field plugin labels; empty ⇒ all cell types allowed.
  - `enable_legend` — `checkbox`; adds a rich-text legend/caption to the table.

## Widget — `UltimateTableFieldWidget`

`src/Plugin/Field/FieldWidget/UltimateTableFieldWidget.php`, `@FieldWidget(id="ultimate_table")`,
`field_types = {"ultimate_table"}`.

- `formElement()` renders a single `#type => 'ultimate_table'` render element (see
  [../forms/modal-editor.md](../forms/modal-editor.md)), passing `#allowed_types` and
  `#enable_legend` down from the field settings, plus `#default_value => ['values' => <stored value>]`.
- `massageFormValues()` unwraps the element's `['values' => …]` structure back into
  `['value' => …]` for storage.

## Formatter — `UltimateTableFieldFormatter`

`src/Plugin/Field/FieldFormatter/UltimateTableFieldFormatter.php`,
`@FieldFormatter(id="ultimate_table")`, `field_types = {"ultimate_table"}`.

`viewElements()` walks `columns` then `rows`; for each cell-item it calls the cell plugin's
`cellFieldFormatter()` (see [../plugins/cell-field.md](../plugins/cell-field.md)), renders each
cell with `renderer->renderInIsolation()`, and emits a core `#type => 'table'` render element with
`#header => columns` and `#rows => rows` (so headers become real `<th>` cells). The optional legend
is emitted as `#type => markup` before or after the table per the `legend_position` setting.

Formatter settings (`defaultSettings()` / `settingsForm()`), stored per view-display:

| Key | Type | Values / notes |
|---|---|---|
| `legend_position` | select | `before` (default) or `after` the table |
| `table_theme` | select | `''`(default), `black`, `blue`, `brown`, `cyan`, `gold`, `gray`, `green`, `olive`, `orange`, `pink`, `purple`, `red`, `silver`, `yellow` → CSS class `table-<theme>` |
| `table_style` | checkboxes | `striped-odd`, `striped-even` (mutually exclusive via `#states`), `filled-head`, `row-hover`, `side-filled` → each becomes a CSS class |
| `table_color` | (declared default `''`) | present in `defaultSettings()` but not exposed in the form |

`getTableClasses()` always adds `custom-bordered-table`, then the theme and selected style classes.
The rendered table attaches library `ultimate_table_field/table-themes` (colour/stripe CSS in
`css/table-themes.css`). `settingsSummary()` echoes the applied colour and styles.

> Note: this module ships **no `config/schema/`**, so the field/widget/formatter setting keys above
> have no config schema definitions.

## Update hooks (`ultimate_table_field.install`)

Two update hooks migrate older stored values to the current shape (no `hook_install`/schema, no
`.module` file):

- `ultimate_table_field_update_10101()` — flattens the old multi-value structure to a single
  `['value' => …]` per item.
- `ultimate_table_field_update_10102()` — converts plain-string columns/first-row cells into the
  `[['type' => 'text', 'text' => …]]` cell-item shape.
