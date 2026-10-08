# Field enhancer plugins

Enhancers transform a field's value on output (normalize) and reverse it on input
(denormalize). They're plugins in `Plugin/jsonapi/FieldEnhancer`, managed by
`plugin.manager.resource_field_enhancer`, and attached to a field in a resource override
([../configure/resource-overrides.md](../configure/resource-overrides.md)). Built on the
`e0ipso/shaper` transformation library.

## Built-in enhancers
| id | Does |
|---|---|
| `date_time` | Format a **timestamp** field to a configured date format (`dateTimeFormat`) |
| `date_time_from_string` | Format a string **datetime** field |
| `json` | Parse a JSON-string field into a real nested object |
| `nested` (SingleNested) | Extract a value at a `path` inside a compound field |
| `single_value` | Flatten a single-cardinality field out of its array wrapper |
| `uuid_link` | Rewrite a reference into a UUID-based link |
| `url_link` | Rewrite a link/URL field |

## Write your own
```php
namespace Drupal\mymodule\Plugin\jsonapi\FieldEnhancer;

use Drupal\Core\StringTranslation\TranslatableMarkup;
use Drupal\jsonapi_extras\Attribute\ResourceFieldEnhancer;
use Drupal\jsonapi_extras\Plugin\ResourceFieldEnhancerBase;
use Shaper\Util\Context;

#[ResourceFieldEnhancer(
  id: 'uppercase',
  label: new TranslatableMarkup('Uppercase'),
  description: new TranslatableMarkup('Uppercases a string on output.'),
  dependencies: [],          // module machine names required for the enhancer
)]
class UppercaseEnhancer extends ResourceFieldEnhancerBase {
  protected function doUndoTransform($data, Context $context) {  // OUTPUT (normalize)
    return strtoupper($data);
  }
  protected function doTransform($data, Context $context) {      // INPUT (denormalize)
    return strtolower($data);
  }
  public function getOutputJsonSchema() {
    return ['type' => 'string'];
  }
}
```

- Attribute `Drupal\jsonapi_extras\Attribute\ResourceFieldEnhancer` (legacy annotation
  `@ResourceFieldEnhancer` also supported).
- `doUndoTransform()` = value as sent to the client; `doTransform()` = value parsed from a write
  request. Keep them inverse so round-trips are lossless.
- `getOutputJsonSchema()` describes the transformed output (used for schema generation).
- Store settings via a settings form (`getSettingsForm()`); schema type
  `jsonapi_extras.enhancer_plugin.<id>`.
- `drush cr`, then the enhancer appears in the field's dropdown on the resource override form.
