# Field Inheritance hooks (`field_inheritance.api.php`)

Two `alter` hooks let you customise inheritance behaviour.

## `hook_field_inheritance_inheritance_class_alter(&$class, $field)`

Alter the **factory class** used to build the computed (inherited) base field. Invoked from
`hook_entity_bundle_field_info_alter()` after the default class is chosen
(`EntityReferenceFieldInheritanceFactory` for the `entity_reference_inheritance` plugin, else
`FieldInheritanceFactory`).

```php
function mymodule_field_inheritance_inheritance_class_alter(&$class, $field): void {
  if ($field->plugin() === 'entity_reference_inheritance') {
    $class = '\Drupal\mymodule\MyEntityReferenceFieldInheritanceFactory';
  }
}
```

`$field` is the `FieldInheritance` config entity (use `->plugin()`, `->type()`, `->sourceField()`, …).

## `hook_field_inheritance_compute_value_alter(array &$value, array $context)`

Alter the **computed value** of an inherited field, after the plugin has produced it. Invoked from
`FieldInheritancePluginBase::computeValue()` via
`moduleHandler->alter('field_inheritance_compute_value', $value, $context)`.

```php
function mymodule_field_inheritance_compute_value_alter(array &$value, array $context): void {
  if ($context['destination_field'] === 'inherited_title') {
    $value[0]['value'] = strtoupper($value[0]['value']);
  }
}
```

`$value` is the array of field-item values. `$context` keys: `source_field`, `source_entity`,
`destination_field`, `destination_entity`, `method` (the inheritance strategy).

> Note the naming: the module's *alter tags* are `field_inheritance_inheritance_class` and
> `field_inheritance_compute_value`, so the full hook function names are
> `hook_field_inheritance_inheritance_class_alter` and
> `hook_field_inheritance_compute_value_alter` respectively (as shown above and in
> `field_inheritance.api.php`).

## Plugin definition alter

Separately, the plugin manager exposes `hook_field_inheritance_info_alter()` (alter tag
`field_inheritance_info`) to alter the discovered `field_inheritance` plugin definitions.
