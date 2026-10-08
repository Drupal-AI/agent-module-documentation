<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Create the field & read/write values in code

## Create a key_value field on a bundle

```php
use Drupal\field\Entity\FieldStorageConfig;
use Drupal\field\Entity\FieldConfig;

FieldStorageConfig::create([
  'field_name' => 'field_specs',
  'entity_type' => 'node',
  'type' => 'key_value',                 // or 'key_value_long'
  'cardinality' => -1,                   // -1 = unlimited rows
  'settings' => ['key_max_length' => 64, 'key_is_ascii' => FALSE],
])->save();

FieldConfig::create([
  'field_name' => 'field_specs',
  'entity_type' => 'node',
  'bundle' => 'article',
  'label' => 'Specifications',
])->save();
```

Then assign the widget on the form display and the formatter on the view display:

```php
\Drupal::service('entity_display.repository')
  ->getFormDisplay('node', 'article', 'default')
  ->setComponent('field_specs', ['type' => 'key_value_textfield'])
  ->save();

\Drupal::service('entity_display.repository')
  ->getViewDisplay('node', 'article', 'default')
  ->setComponent('field_specs', ['type' => 'key_value', 'settings' => ['value_only' => FALSE]])
  ->save();
```

## Read / write item values

Each item exposes three properties: `key`, `value`, `description` (plus `format` on the long
type).

```php
$node->set('field_specs', [
  ['key' => 'Weight', 'value' => '1.2 kg', 'description' => 'shipping weight'],
  ['key' => 'Color',  'value' => 'Blue'],
]);
$node->save();

foreach ($node->get('field_specs') as $item) {
  // $item->key, $item->value, $item->description
}
```

## Semantics to know

- **Empty check:** an item is empty when `key` is null/'' *and* the parent value is empty
  (`KeyValueFieldTypeTrait::isEmpty()`), so a value with no key is still stored but flags a
  validation error on save.
- **Schema:** the trait adds a `key` column (`varchar`/`varchar_ascii`, length =
  `key_max_length`, indexed) and a nullable `description` `varchar(255)` column to the base
  string/text schema.
- **Formatter:** `key_value` extends the core text default formatter; with `value_only` off it
  prepends `key : ` (via `#plain_text`) before the value.
