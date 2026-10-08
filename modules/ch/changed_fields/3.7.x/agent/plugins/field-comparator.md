# Plugin type: FieldComparator

Comparison logic is a plugin so that "did this field change?" can be answered correctly per field
type. `EntitySubject` picks one comparator (by id, default `default_field_comparator`) and calls
`compareFieldValues()` on every watched field.

## Plugin type facts
- Manager service: `plugin.manager.changed_fields.field_comparator` → `Drupal\changed_fields\FieldComparatorPluginManager` (`parent: default_plugin_manager`).
- Plugin directory: `src/Plugin/FieldComparator/`. Namespace `Drupal\<module>\Plugin\FieldComparator`.
- Annotation: the generic `@Plugin` (id only — no dedicated annotation class):
  ```php
  /**
   * @Plugin(
   *   id = "my_field_comparator"
   * )
   */
  ```
- Alter hook: `changed_fields_field_comparators_info` (alters the discovered plugin definitions).
- Plugin cache key: `changed_fields_plugins`.

## The base plugin: `DefaultFieldComparator`

`Drupal\changed_fields\Plugin\FieldComparator\DefaultFieldComparator` (`extends PluginBase`,
id `default_field_comparator`). Public entry point:

`compareFieldValues(FieldDefinitionInterface $field_definition, array $old_value, array $new_value): array|bool`
returns `TRUE` when equal, or `['old_value' => ..., 'new_value' => ...]` when changed. Logic:
value added/removed → changed; different delta count on a multi-value field → changed; otherwise it
compares each delta's **comparable properties** and reports changed on the first difference.

### Comparable properties per core field type
Which properties `getComparableProperties()` diffs (settings-dependent extras noted):

| Field type(s) | Properties compared |
|---|---|
| `string`, `string_long`, `text`, `text_long`, `boolean`, `integer`, `float`, `decimal`, `datetime`, `email`, `password`, `list_integer`, `list_float`, `list_string`, `telephone` | `value` |
| `text_with_summary` | `value`, `summary` |
| `entity_reference` | `target_id` |
| `entity_reference_revisions` | `target_id`, `target_revision_id` |
| `file` | `target_id` (+ `description` if the field's `description_field` setting is on) |
| `image` | `width`, `height`, `target_id` (+ `alt` if `alt_field`, + `title` if `title_field`) |
| `link` | `uri`, `title` |
| `daterange` | `value`, `end_value` |
| anything else | `getDefaultComparableProperties()` → `[]` (no properties ⇒ never detected as changed) |

So an unlisted (custom/contrib) field type is **not** compared until you provide a comparator that
declares its properties.

## Adding your own comparator

Extend `DefaultFieldComparator` and override one of two protected hooks (see the shipped example
`ExtendedFieldComparator`, id `extended_field_comparator`):

```php
namespace Drupal\MYMODULE\Plugin\FieldComparator;

use Drupal\Core\Field\FieldDefinitionInterface;
use Drupal\changed_fields\Plugin\FieldComparator\DefaultFieldComparator;

/**
 * @Plugin(
 *   id = "my_field_comparator"
 * )
 */
class MyFieldComparator extends DefaultFieldComparator {

  // Give an UNLISTED field type its comparable properties.
  public function getDefaultComparableProperties(FieldDefinitionInterface $field_definition) {
    return $field_definition->getType() === 'some_field_type'
      ? ['some_property_1', 'some_property_2']
      : [];
  }

  // OR add extra properties to any (listed or unlisted) field type.
  public function extendComparableProperties(FieldDefinitionInterface $field_definition, array $properties) {
    if ($field_definition->getType() === 'some_field_type') {
      $properties[] = 'some_property_3';
    }
    return $properties;
  }
}
```

- `getDefaultComparableProperties()` fills in the `default:` branch (unlisted field types).
- `extendComparableProperties()` runs for **every** field type, letting you append properties to a
  built-in type's list without rewriting the switch.

Then select it by id when building the subject:

```php
$subject = new EntitySubject($entity, 'my_field_comparator');
```

See [../api/entity-subject.md](../api/entity-subject.md) for the observer side.
