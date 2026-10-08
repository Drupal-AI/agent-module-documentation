# typed_data plugin types

The module defines two plugin types. Both support annotations (`src/Annotation/`) and PHP
attributes (`src/Attribute/`) for discovery.

## DataFilter — id `typed_data_filter`
- Manager service: `plugin.manager.typed_data_filter` (`DataFilterManager`).
- Discovery dir: `src/Plugin/TypedDataFilter/`; annotation/attribute `@DataFilter` / `#[DataFilter]`.
- Purpose: transform a resolved value in a placeholder pipeline (`{{ path | filter }}`).
- Shipped filters: `lower`, `upper`, `trim`, `strip_tags`, `count`, `format_date`,
  `format_text`, `replace`, `entity_url`, plus a `default` fallback.

Implement one:
```php
namespace Drupal\mymodule\Plugin\TypedDataFilter;

use Drupal\typed_data\Attribute\DataFilter;
use Drupal\typed_data\DataFilterBase;

#[DataFilter(id: 'reverse', label: new \Drupal\Core\StringTranslation\TranslatableMarkup('Reverse'))]
class ReverseFilter extends DataFilterBase {
  public function filter(\Drupal\Core\TypedData\DataDefinitionInterface $definition, $value, array $arguments, \Drupal\Core\TypedData\BubbleableMetadata $metadata = NULL) {
    return strrev((string) $value);
  }
  // Also implement canFilter()/filtersTo() to declare in/out data types.
}
```

## TypedDataFormWidget — id `typed_data_form_widget`
- Manager service: `plugin.manager.typed_data_form_widget` (`FormWidgetManager`).
- Discovery dir: `src/Plugin/TypedDataFormWidget/`; `@TypedDataFormWidget` / `#[TypedDataFormWidget]`.
- Purpose: render and process an edit form for a given data type.
- Shipped widgets: `TextInputWidget`, `TextareaWidget`, `SelectWidget`, `DatetimeWidget`,
  `DatetimeRangeWidget` (base: `DatetimeWidgetBase`), plus a `BrokenWidget` fallback.

Get one via the manager and call `form()` / `extractFormValues()` to build/collect a value for
a `TypedDataInterface`.
