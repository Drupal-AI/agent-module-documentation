# FieldProcessor plugin type

Field processors decide how a single field's values are carried onto a clone.

## Plugin registration

- Annotation: `@ContentEntityCloneFieldProcessor`
  (`Drupal\content_entity_clone\Annotation\ContentEntityCloneFieldProcessor`).
- Plugin namespace: `Plugin/content_entity_clone/FieldProcessor`.
- Interface: `Drupal\content_entity_clone\Plugin\FieldProcessorPluginInterface`.
- Base class: `Drupal\content_entity_clone\Plugin\FieldProcessorPluginBase`.
- Manager service: `plugin.manager.content_entity_clone.field_processor`
  (`Drupal\content_entity_clone\Plugin\FieldProcessorPluginManager`).
- Alter hook: `content_entity_clone_field_processor_info_alter` (see hooks/hooks.md).

## Annotation properties

```
@ContentEntityCloneFieldProcessor(
  id = "my_processor",
  label = @Translation("My processor"),
  description = @Translation("What it does."),
  fieldTypes = { "text", "string" }   // optional; empty/omitted = applies to all field types
)
```

## Interface

- `getPluginLabel()` — human label.
- `supports(FieldDefinitionInterface $field_definition)` — whether it applies to a given field
  (base class checks `fieldTypes`).
- `process(FieldItemListInterface $field)` — mutate the (already-cloned) field item list in place;
  the caller copies the resulting values onto the new entity.

## Shipped processors

| id | Effect |
|---|---|
| `copy_values` | Copies the field values as-is (no processing). Excludes `layout_section` fields. |
| `entity_label_clone_suffix` | Appends ` [CLONE]` to the entity's label field (types text/string). |
| `clone_referenced_entities` | Clones the referenced entities rather than reusing them. |
| `copy_layout` | Copies a Layout Builder `layout_section` field. |

## Writing one

```php
namespace Drupal\my_module\Plugin\content_entity_clone\FieldProcessor;

use Drupal\content_entity_clone\Plugin\FieldProcessorPluginBase;
use Drupal\Core\Field\FieldItemListInterface;

/**
 * @ContentEntityCloneFieldProcessor(
 *   id = "uppercase",
 *   label = @Translation("Uppercase"),
 *   description = @Translation("Make text field values uppercase."),
 *   fieldTypes = { "string", "text" }
 * )
 */
class Uppercase extends FieldProcessorPluginBase {
  public function process(FieldItemListInterface $field) {
    foreach ($field as $item) {
      $item->value = mb_strtoupper($item->value);
    }
  }
}
```

Place it under `Plugin/content_entity_clone/FieldProcessor/`; it then appears as a selectable
processor for matching fields in the bundle settings form. The manager also exposes
`getAvailablePlugins($field_definition)` (processors supporting a field) and
`processField($plugin_id, $field)`.
