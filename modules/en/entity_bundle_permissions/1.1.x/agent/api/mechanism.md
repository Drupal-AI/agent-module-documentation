# Mechanism

Service class: `Drupal\entity_bundle_permissions\DynamicPermissions` (marked `@internal`,
resolved via `\Drupal::classResolver()`; not a registered service). Uses `entity_type.manager`,
`logger.factory`, `config.factory`.

## `applies(EntityTypeInterface $type): bool`

Returns TRUE (the module gates the type) only when **all** hold:

1. `!$type->isInternal()`
2. `$type->getBundleEntityType()` is set (the type has a bundle config entity, e.g. `node_type`,
   `media_type`, `taxonomy_vocabulary`).
3. `$type instanceof ContentEntityTypeInterface` (content, not config, entity).
4. `$type->id()` is **not** in `entity_bundle_permissions.settings:ignored_entity_types`.

So config entities, entity types with no bundles, internal types, and ignored types are skipped.

## `get(): array`

Loops applicable content entity types → loads each type's bundle entities → builds permission
`entity_bundle_permissions access {type} {bundle}` with a config dependency on the bundle entity.
Returns the array consumed by Drupal's permission system.

## `entity_bundle_permissions_entity_access($entity, $operation, $account)`

The gate (in `.module`):

```php
if ($dynamic_permissions->applies($entity->getEntityType())) {
  $permission = "entity_bundle_permissions access {$entity->getEntityType()->id()} {$entity->bundle()}";
  $access = AccessResult::forbiddenIf(!$account->hasPermission($permission))
    ->addCacheContexts(['user.permissions']);
}
```

- Only entities of an applicable type are checked; everything else returns `neutral`.
- `$operation` is ignored, so the check is identical for view/update/delete.
- Result is cached per `user.permissions`.
- Because a single `forbidden` beats any `allowed`, missing the permission blocks access even if
  another module (or core role permission) would allow it.

## Extending

There are no hooks, events, or plugin types to implement. To change coverage, edit
`ignored_entity_types` (see [configure/settings.md](../configure/settings.md)). To grant access,
assign the generated per-bundle permissions to roles.
