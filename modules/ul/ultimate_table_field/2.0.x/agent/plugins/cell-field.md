# `UltimateTableCellField` plugin type (table cell fields)

The one plugin type the module defines. Each plugin describes one **kind of cell content**: how it
is edited in the modal (`buildCellField`), summarised in the widget (`generateSummary`), rendered on
display (`cellFieldFormatter`), and optionally post-processed on save (`cellFieldAlterSubmitted`).

- Manager service: **`plugin.manager.ultimate_table_cell_field`**
  (`Drupal\ultimate_table_field\UltimateTableCellFieldManager`, extends `DefaultPluginManager`).
- Discovery dir: `Plugin/UltimateTable/CellField`. Interface: `UltimateTableCellFieldInterface`.
  Base class: `UltimateTableCellFieldBase`.
- Annotation: `Drupal\ultimate_table_field\Annotation\UltimateTableCellField` (fields: `id`,
  `label`). Uses the classic `@UltimateTableCellField(...)` annotation, not a PHP attribute.
- Alter hook: **`hook_ultimate_table_cell_field_info(&$definitions)`** (`alterInfo` id
  `ultimate_table_cell_field_info`) — implement to add/remove/edit cell-field definitions. Cache bin
  key `ultimate_table_cell_field_info`.

## Interface contract (`UltimateTableCellFieldInterface`)

```php
public function id(): string;                       // plugin id
public function label(): string;                    // admin label
public function buildCellField($default_value = NULL): array;  // Form API subform for the modal editor
public function generateSummary($data = NULL): array;          // render array shown in the cell summary
public function cellFieldAlterSubmitted(mixed &$submitted_value); // mutate the value on modal save
public function cellFieldFormatter(array $item): array;         // render array for display
public function cellFieldValidate();                            // (no-op in base)
```

`UltimateTableCellFieldBase` supplies `id()`, `label()`, `StringTranslationTrait`, a generic
`generateSummary()` and `cellFieldFormatter()`, and empty `cellFieldAlterSubmitted()` /
`cellFieldValidate()`. The stored cell-item is `['type' => <plugin_id>, <plugin_id> => <value>]`, so
inside `cellFieldFormatter(array $item)` the value is `$item[$this->id()]`.

## Bundled cell-field plugins

| id | Class | Edit widget | Display |
|---|---|---|---|
| `text` | `CellField/Text` | `textfield` (required) | value via `#markup` |
| `text_long` | `CellField/TextLong` | `textarea` (required) | value via `#markup` |
| `link` | `CellField/Link` | `entity_autocomplete` (node) URI + link text; validated by core `LinkWidget::validateUriElement` | `#type => link` built with `Url::fromUri()` (falls back to route `<none>` on an invalid URI) |
| `file` | `CellField/File` | `managed_file`, extensions **`pdf doc docx`**, upload dir `public://ultimate-table/documents` | `<a href … download>` to `file->createFileUrl()` |

Notes:
- `Text`/`TextLong` display returns `['#markup' => $item[<id>]]`; as a plain-string `#markup`, the
  value is rendered through Drupal core's standard `Xss::filterAdmin()` admin-tag filtering, so
  admin-safe formatting tags pass through and other markup is dropped.
- `File::cellFieldAlterSubmitted()` marks the uploaded file **permanent** on save (and `buildCellField`
  pre-creates the public destination directory).
- `Link::getUriAsDisplayableString()` reproduces core LinkWidget behaviour to show `internal:` /
  `entity:node/…` / `route:` URIs in a human form in the edit field and summary.

## Add your own cell-field plugin

Create `my_module/src/Plugin/UltimateTable/CellField/Color.php`:

```php
namespace Drupal\my_module\Plugin\UltimateTable\CellField;

use Drupal\ultimate_table_field\UltimateTableCellFieldBase;

/**
 * @UltimateTableCellField(
 *   id = "color",
 *   label = @Translation("Color swatch"),
 * )
 */
class Color extends UltimateTableCellFieldBase {

  public function buildCellField($default_value = NULL): array {
    return ['#type' => 'color', '#title' => $this->t('Color'), '#default_value' => $default_value, '#required' => TRUE];
  }

  public function generateSummary($data = NULL): array {
    return ['#markup' => '<p><strong>Color:</strong> ' . $data[$this->id()] . '</p>'];
  }

  public function cellFieldFormatter(array $item): array {
    return ['#markup' => '<span style="background:' . $item[$this->id()] . '">&nbsp;&nbsp;</span>'];
  }
}
```

Clear caches; the new type then appears in the modal `Type` select and in the field's
`allowed_types` setting. If `buildCellField` returns a nested `#tree` fieldset (as `link`/`file` do),
the stored value is that nested array and `cellFieldFormatter` reads it from `$item[$this->id()]`.
