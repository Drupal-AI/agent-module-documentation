<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity expand API

## Wrap an entity
```php
$user = entity_expand_load(\Drupal\user\Entity\User::load(1));
$user->newname();          // custom method from your EntityExpandBase subclass
$user->field_ref->ref()->someMethod();
```
`_entity_load('node', 42)` loads then wraps; pass `$unchanged = TRUE` for `loadUnchanged()`.

## Register custom methods
```php
function mymodule_entity_expand_load($entity, $entity_type_id) {
  if ($entity_type_id === 'user') {
    return new \Drupal\mymodule\EntityExpand\UserExpand($entity);
  }
  return $entity;
}
```
If no hook returns a wrapper, `entity_expand_load()` wraps with the base `EntityExpandBase`.

## Base helpers
`get($field)`, `setValues(['name'=>'x','field_a'=>'y'])`, `bundleKey()`, and field-item helpers
`val($default)`, `ref()`, `refs($cb)`, `targets()`, `listTextLabel()`, `view($mode)`.

No access control is applied by the wrapper — apply it when you load the entity.
