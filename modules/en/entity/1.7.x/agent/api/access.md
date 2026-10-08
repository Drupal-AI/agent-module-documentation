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
- `access $entity_type overview` (only if the type has a `collection` link template)
- `view $entity_type`, `view $bundle $entity_type`
- `view own unpublished $entity_type` (only if the type is owner-aware and publishable)
- `create $bundle $entity_type`
- `update (own|any) ($bundle) $entity_type`
- `duplicate (own|any) ($bundle) $entity_type` (only if the type has a `duplicate-form` link template)
- `delete (own|any) ($bundle) $entity_type`

Granularity is driven by the entity type's `permission_granularity` (`entity_type` vs
`bundle`). Owner-aware types (implementing `EntityOwnerInterface`) get the own/any split;
non-owner types get a single `update`/`delete`/`duplicate` permission.
`EntityAccessControlHandler` **requires** `EntityPermissionProvider` (its constructor throws
an `\Exception` otherwise) and maps operations to those permissions, including owner-aware
checks (`checkEntityOwnerPermissions`) and unpublished-owner handling — there is no permission
to view *another* user's unpublished entity, so that always returns neutral.

## Variants
- `UncacheableEntityPermissionProvider` + `UncacheableEntityAccessControlHandler` — use when
  you need **"view own $entity_type"** permissions (these force per-user page caching, hence
  "uncacheable").
- `EntityPermissionProviderBase` / `EntityAccessControlHandlerBase` — subclass to customize
  which permissions are built or how operations map. (Both are marked `@internal`.)

Create access: `checkCreateAccess` grants when the account holds the admin permission,
`create $entity_type`, or `create $bundle $entity_type` (OR).

The module's own permissions are assembled by `EntityPermissions::buildPermissions()` (wired
through `entity.permissions.yml`), which loops every entity type that declares a
`permission_provider` handler class and merges each provider's output.
