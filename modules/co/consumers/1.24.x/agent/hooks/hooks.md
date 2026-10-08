# Hooks

Documented in `consumers.api.php`.

### `hook_consumes_list_alter(array &$data, array $context)`
Alter the Consumers admin list builder — add/modify columns and cell values.

- `$context['type']` is `'header'` or `'row'`.
- For rows, `$context['entity']` is the `consumer` entity.

```php
function mymodule_consumes_list_alter(array &$data, array $context) {
  if ($context['type'] === 'header') {
    $data['scopes'] = t('Scopes');
  }
  elseif ($context['type'] === 'row') {
    $data['scopes'] = $context['entity']->get('scopes')->value;
  }
}
```

Also relevant (core hooks the module implements, so you can extend alongside them):
`hook_jsonapi_consumer_filter_access()` controls JSON:API filter access to consumer entities.
