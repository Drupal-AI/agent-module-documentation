<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Write a custom export field formatter

To export an arbitrary data structure for your own field type, write a normal `@FieldFormatter`
whose `viewElements()` returns render elements of `#type => 'data'` with a
`Drupal\rest_views\SerializedData` payload. The `field_export` handler + `DataNormalizer` pass
that data through serialization untouched.

```php
namespace Drupal\my_module\Plugin\Field\FieldFormatter;

use Drupal\Core\Field\FieldItemListInterface;
use Drupal\Core\Field\FormatterBase;
use Drupal\rest_views\SerializedData;

/**
 * @FieldFormatter(
 *   id = "my_field_export",
 *   label = @Translation("Export my field"),
 *   field_types = { "my_field" }
 * )
 */
class MyFieldExportFormatter extends FormatterBase {

  public function viewElements(FieldItemListInterface $items, $langcode): array {
    $elements = [];
    foreach ($items as $delta => $item) {
      $data = ['id' => $item->target_id, 'value' => $item->value]; // any structure
      $elements[$delta] = [
        '#type' => 'data',
        '#data' => SerializedData::create($data),
      ];
    }
    return $elements;
  }
}
```

## The two wrapper classes

| Class | Use | Normalizer |
|---|---|---|
| `SerializedData` | Wrap **already-computed data** (arrays/scalars). `jsonSerialize()` returns the data as-is. | `serializer.normalizer.serialized` (`DataNormalizer`) unwraps it. |
| `RenderableData` | Wrap a **render array** that should be rendered to a string *during* normalization (e.g. HTML you still want as a value). | `serializer.normalizer.render` (`RenderNormalizer`) renders it via the renderer. |

Both implement `MarkupInterface` and return `'[...]'` from `__toString()`, which lets them
survive the Render API without being stringified — the real value is extracted at
serialization time. Use `SerializedData` for structured data (the common case) and
`RenderableData` when you need Drupal to render markup lazily into the output.

Your formatter is selected per field in the view (as `type`), but only takes effect when the
field uses the **serializable** (`field_export`) handler.
