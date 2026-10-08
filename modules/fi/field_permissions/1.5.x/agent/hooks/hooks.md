# Hooks

## hook_field_permission_type_plugin_alter(array &$definitions)
Alter the discovered `FieldPermissionType` plugin definitions — add, remove, or reorder the
access strategies offered on the field settings form. Registered via the manager's
`alterInfo('field_permission_type_plugin')`.

```php
function my_module_field_permission_type_plugin_alter(array &$definitions) {
  // Remove the built-in "Private" option site-wide.
  unset($definitions['private']);
}
```

To add a new strategy, write a `FieldPermissionType` plugin rather than altering here —
see [../plugins/field-permission-type.md](../plugins/field-permission-type.md).
