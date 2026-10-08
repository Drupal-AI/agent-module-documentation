# Generic permissions & access control

Attach these handlers in your content entity type's annotation to get a full permission set
and enforcement for free:

```php
handlers = {
  "access" = "Drupal\entity\EntityAccessControlHandler",
  "permission_provider" = "Drupal\entity\EntityPermissionProvider",
}
```

`EntityPermissionProvider` generates (from the entity type + its bundles):
- the declared `admin_permission` (or `administer $entity_type`)
- `access $entity_type overview`
- `view $entity_type`, `view $bundle $entity_type`
- `view own unpublished $entity_type`
- `create $bundle $entity_type`
- `update (own|any) ($bundle) $entity_type`
- `duplicate (own|any) ($bundle) $entity_type`
- `delete (own|any) ($bundle) $entity_type`

Granularity is driven by the entity type's `permission_granularity` (`entity_type` vs
`bundle`). `EntityAccessControlHandler` **requires** `EntityPermissionProvider` (it throws
otherwise) and maps operations to those permissions, including owner-aware checks
(`checkEntityOwnerPermissions`) and unpublished-owner handling.

## Variants
- `UncacheableEntityPermissionProvider` + `UncacheableEntityAccessControlHandler` — use when
  you need **"view own $entity_type"** permissions (these force per-user page caching, hence
  "uncacheable").
- `EntityPermissionProviderBase` / `EntityAccessControlHandlerBase` — subclass to customize
  which permissions are built or how operations map.

The module's own permissions are assembled by `EntityPermissions::buildPermissions()` (wired
through `entity.permissions.yml`), which loops every entity type that declares a
`permission_provider` handler.
