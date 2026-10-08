# Entity Legal — hooks

The module invites one hook (`entity_legal.api.php`).

## `hook_entity_legal_document_method_alter(array $methods)`

Alter the list of available acceptance **delivery methods** offered in a document's New/Existing users
`require_method` selects. The array is keyed by method `type` (`new_users` / `existing_users`), then by
method id. (This is the `entity_legal_methods` alter registered by the plugin manager.)

```php
/**
 * Implements hook_entity_legal_document_method_alter().
 */
function mymodule_entity_legal_document_method_alter(array &$methods) {
  // Add an option or relabel/remove an existing one.
  $methods['existing_users']['email'] = t('Email all users');
  unset($methods['existing_users']['redirect']);
}
```

To add a method with real behaviour, prefer defining an `EntityLegal` plugin (see
[../plugins/methods.md](../plugins/methods.md)); this alter is for adjusting the presented option list.
