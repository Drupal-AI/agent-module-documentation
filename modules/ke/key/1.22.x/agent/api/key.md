# Read key values in code

Service `key.repository` (`Drupal\key\KeyRepositoryInterface`). Load a key, then ask it for its
value — the value is resolved through the key's provider (env/file/config/state).

```php
/** @var \Drupal\key\KeyRepositoryInterface $repo */
$repo = \Drupal::service('key.repository');

$key   = $repo->getKey('my_api_key');   // KeyInterface|NULL
$secret = $key->getKeyValue();          // the resolved string value
$fields = $key->getKeyValues();         // array, for multivalue key types
```

Repository methods:
- `getKey($key_id)` — one key entity.
- `getKeys(?array $key_ids = NULL)` — all keys, or a subset.
- `getKeysByType($key_type_id)`, `getKeysByProvider($key_provider_id)`,
  `getKeysByStorageMethod($storage_method)`, `getKeysByTypeGroup($type_group)`.
- `getKeysByTags(array $tags)` — filter by provider tags.
- `getKeyNamesAsOptions(array $filters)` — `id => label` map for form `#options`.

Key entity (`KeyInterface`): `getKeyValue()`, `getKeyValues()`, `getKeyType()`,
`getKeyProvider()`, `getKeyInput()`, `getDescription()`.

## Key-select form element
Add a picker to a config form with the `key_select` render element
(`Drupal\key\Element\KeySelect`):
```php
$form['api_key'] = [
  '#type' => 'key_select',
  '#title' => $this->t('API key'),
  '#default_value' => $config->get('api_key'),
  '#key_filters' => ['type' => 'authentication'],
];
```
