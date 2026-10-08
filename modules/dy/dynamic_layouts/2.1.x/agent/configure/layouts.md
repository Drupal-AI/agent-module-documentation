# Create & manage layouts

Each layout is a `dynamic_layout` config entity. Manage them at
`/admin/config/dynamic-layouts` (list) → **Add new layout**. All routes require `admin dynamic layouts`.

## Routes

| Route | Path | Purpose |
|---|---|---|
| `dynamic_layout.dynamic_layout_list` | `/admin/config/dynamic-layouts` | List (entity `list_builder`). |
| `dynamic_layout.dynamic_layout_add` | `/admin/config/dynamic-layouts/add` | Add (custom access: settings must have a frontend library). |
| `entity.dynamic_layout.edit_form` | `/admin/config/dynamic-layouts/manage/{dynamic_layout}` | Edit (rows/columns UI). |
| `entity.dynamic_layout.delete_form` | `/admin/config/dynamic-layouts/manage/{dynamic_layout}/delete` | Delete. |
| `dynamic_layouts.add_row` | `/admin/config/dynamic-layouts/manage/{id}/add-row` | AJAX add a row. |
| `dynamic_layouts.delete_row` | `/admin/config/dynamic-layouts/manage/{id}/delete-row/{row_id}` | AJAX delete a row. |
| `dynamic_layouts.add_column` | `/admin/config/dynamic-layouts/manage/{id}/add-column/{row_id}` | AJAX add a column. |
| `dynamic_layouts.delete_column` | `/admin/config/dynamic-layouts/manage/{id}/delete-column/{row_id}/{column_id}` | AJAX delete a column. |
| `dynamic_layouts.edit_row_modal_form` | `/admin/config/dynamic-layouts/edit-row/modal_form` | Modal: set custom row classes. |
| `dynamic_layouts.edit_column_modal_form` | `/admin/config/dynamic-layouts/edit-column/modal_form` | Modal: set column name, width class, custom classes. |

The row/column add/delete controllers (`DynamicLayoutController`) mutate the entity and `save()` it,
then AJAX-replace the layout form (`ReplaceCommand('.dynamic-layout-form', …)`).

## Entity shape

`\Drupal\dynamic_layouts\Entity\DynamicLayout` (`@ConfigEntityType` id `dynamic_layout`,
config prefix `dynamic_layout`, `admin_permission = "admin dynamic layouts"`). `config_export`:

| Key | Meaning |
|---|---|
| `id` | Machine name. |
| `label` | Human name (shown as the layout's admin label). |
| `weight` | Sort weight. |
| `category` | Free-text category the layout is grouped under in the layout picker. |
| `regions` | **PHP `serialize()`d** array of rows → columns (see below). Schema type `text`. |
| `default_column_class` | Class applied to every column. |
| `default_row_class` | Class applied to every row. |

Schema `dynamic_layouts.dynamic_layout.*` mirrors those keys (`regions`, `default_column_class`,
`default_row_class` are `text`). Because `regions` is a serialized blob, **do not hand-author it in
YAML**; build layouts through the UI or the entity API so ids and structure stay consistent.

### The serialized `regions` structure

`getRows()` returns `unserialize($this->regions, ['allowed_classes' => FALSE])` — a list of rows:

```
row: {
  row_id: <uniqid>, default_row_class, custom_row_classes: [],
  admin_row_classes: ['dynamic-layout-row'],
  columns: [ {
    column_id: <uniqid>, column_name, region_name: 'r<row>c<col>',
    column_width_number, column_width_prefix, custom_column_width_number?,
    default_column_class, custom_column_classes: [],
    admin_column_classes: ['dynamic-layout-column'],
    edit_column, delete_column   # pre-rendered admin link markup
  } ]
}
```

Regions exposed to the layout come from `getLayoutRegions()`: one region per column, machine name =
`region_name` (from the column name lowercased → `[^a-z0-9_]`→`_`, or `r<row_id>c<col_id>` if unnamed),
label = the column name or `Row N - Column M`.

## Build a layout from PHP (instead of the UI)

```php
use Drupal\dynamic_layouts\Entity\DynamicLayout;

$layout = DynamicLayout::create([
  'id' => 'promo_three_col',
  'label' => 'Promo three column',
  'category' => 'Promo',
  'default_row_class' => 'row',
  'default_column_class' => 'promo-col',
]);
$layout->save();
// Seed rows (reads global settings for width classes); {start_rows_count} rows, 1 column each:
$layout->addStartingRows(['start_rows_count' => 1, 'default_column_class' => 'promo-col', 'default_row_class' => 'row']);
$layout->addColumn($rowId);                       // append a column to a row
$layout->setColumnName($rowId, $colId, 'Sidebar');// sets label + derived region machine name
$layout->setCustomColumnClasses($rowId, $colId, ['bg-light']);
$layout->setRowClasses($rowId, ['g-0']);
$layout->save();
```

Key `DynamicLayoutInterface` methods: `getRows()`, `getLayoutRegions()`, `getIconMap()`,
`addRow()`/`addStartingRows()`/`addColumn()`, `deleteRow()`/`deleteColumn()`,
`setRowClasses()`/`setCustomColumnClasses()`/`setColumnName()`/`setCustomColumnWidthNumber()`,
`setDefaultRowClass()`/`setDefaultColumnClass()`, and matching getters.

After any create/edit/delete the module calls `plugin.cache_clearer`→`clearCachedDefinitions()` so the
derived layout plugin list refreshes (needed for Display Suite / Panels to see the change).

## Where the layout appears

Once saved it is a derived `@Layout` plugin `dynamic_layout:<id>` (category = the entity's `category`),
selectable in Layout Builder sections and any other layout consumer. See
[plugins/layout.md](../plugins/layout.md).
