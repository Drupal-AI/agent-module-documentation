# Services

## field_permissions.permissions_service (`FieldPermissionsService`)
Args: `@entity_type.manager`, `@plugin.field_permissions.types.manager`.
Key methods:
- `getFieldAccess($operation, FieldItemListInterface $items, AccountInterface $account, FieldDefinitionInterface $field_definition)`
  — the core access decision ('view' / 'edit'); called from `hook_entity_field_access`.
- `fieldGetPermissionType(FieldStorageDefinitionInterface $field)` — the configured type
  id (`public` / `private` / `custom`) for a field.
- `getAllPermissions()` — dynamic permission definitions for all custom-typed fields
  (the `permission_callbacks` target).
- `getPermissionsByRole()` — matrix used by the report.
- `hasFieldViewAccessForEveryEntity($account, $field_definition)` — quick check for
  list/query optimisation.

## plugin.field_permissions.types.manager (`Manager`)
Plugin manager for `FieldPermissionType` plugins — see
[../plugins/field-permission-type.md](../plugins/field-permission-type.md).

## Migration
`Plugin/migrate/process/FieldPermissionSettings` — a migrate process plugin to carry
field permission settings across a D7→D9/10 migration.
