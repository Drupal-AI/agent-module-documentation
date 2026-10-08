# API — plugins, render element & hooks

TableField adds no services and no new plugin type; it ships standard Field API plugins plus
a form render element and one alter hook.

## Field API plugin ids

| Kind | id | Class |
|---|---|---|
| Field type | `tablefield` | `Plugin/Field/FieldType/TablefieldItem` (default widget & formatter both `tablefield`) |
| Widget | `tablefield` | `Plugin/Field/FieldWidget/TablefieldWidget` |
| Formatter | `tablefield` | `Plugin/Field/FieldFormatter/TablefieldFormatter` |

### Stored value (`TablefieldItem::schema`)

- `value` — `blob` (big, serialized) map of table cells; also holds `caption`.
- `format` — `varchar(255)` text format (used when `cell_processing` is on).
- `caption` — `varchar(255)`.

Properties include a computed `table_value` (class `Drupal\tablefield\TableValue`) that
returns a stringified version of the table. `generateSampleValue()` yields a 2×2 sample.
The stored value shape is a nested array `[row][col] => cell`, with an optional per-row
`weight` (from tabledrag) that is stripped on display/export.

## Render element — `#type => 'tablefield'`

`Element/Tablefield.php` (`@FormElement("tablefield")`). Build a standalone table input in a
custom form with these properties: `#rows`, `#cols`, `#input_type` (`textfield`|`textarea`),
`#default_value` (row/col array), `#lock` + `#locked_cells`, and the boolean toggles
`#rebuild`, `#import`, `#paste`, `#addrow` (enable the rebuild / CSV-import / paste /
add-row sub-controls). Rebuild, import and paste run via AJAX (`ajaxCallbackRebuild` /
`submitCallbackRebuild`).

## Hook — CSV import encodings

`tablefield.api.php`:

```php
/**
 * Alter the encodings tried when detecting a CSV file's charset on import.
 */
function hook_tablefield_encodings_alter(array &$encodings) {
  $encodings[] = 'UTF-16';
}
```

Invoked in the CSV importer before `mb_detect_encoding()`; the default list is
`['UTF-8', 'ISO-8859-1', 'WINDOWS-1251']`. Non-UTF-8 cell data is converted to UTF-8 on
import.

## Export route

`tablefield.export` →
`/tablefield/export/{entity_type}/{entity}/{field_name}/{langcode}/{delta}` streams the
grid as a CSV (`TablefieldController::exportCsv`, separator from `tablefield.settings`).
