<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Hooks (`field_token_value.api.php`)

Two alter hooks let other modules change what the formatter renders and which wrappers exist.

## `hook_field_token_value_output_alter(&$element, $wrapper_info)`

Alter the `html_tag` render array just before it is returned by the formatter (fired only when a
wrapper is selected). `$wrapper_info` is the resolved wrapper definition (`tag`, `attributes`, …).

```php
function mymodule_field_token_value_output_alter(&$element, $wrapper_info) {
  if ($wrapper_info['tag'] === 'p') {
    $element['#attached']['css'][] = \Drupal::service('extension.list.module')
      ->getPath('mymodule') . '/css/my-styles.css';
  }
}
```

## `hook_field_token_value_wrapper_info_alter(&$wrappers)`

Alter the collected list of wrappers (the `field_token_value_wrapper_info` alter invoked by
`WrapperManager`). Add, remove, or tweak wrapper definitions.

```php
function mymodule_field_token_value_wrapper_info_alter(&$wrappers) {
  if (isset($wrappers['p'])) {
    $wrappers['p']['attributes']['id'] = 'my-paragraph-id';
    $wrappers['p']['summary'] = t('Wrap the value in a paragraph with a custom ID attribute.');
  }
}
```

That is the full hook surface — there is no `hook_field_token_value_handlers` or similar. To add
wrappers declaratively (no PHP), ship a `EXTENSION.field_token_value.yml` file instead
(see [plugins/wrappers.md](../plugins/wrappers.md)).
