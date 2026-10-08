<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Dynamic permissions & access enforcement

Two pieces work together: `DynamicPermissions` (declares the permissions) and
`entity_type_permissions_entity_access()` (enforces them). Files:
`src/DynamicPermissions.php`, `entity_type_permissions.module`,
`entity_type_permissions.permissions.yml`.

## Which entity types apply

`DynamicPermissions::applies(EntityTypeInterface $def)` returns TRUE only when the type is a
`ContentEntityTypeInterface`, `!$def->isInternal()`, and `$def->getBundleEntityType()` is set (the
type has a bundle config entity). `getApplicableContentEntityTypeDefinitions()` runs the same filter
via `array_filter()` over `entityTypeManager->getDefinitions()`. This covers e.g. node, media,
comment, taxonomy_term, and custom bundled content entity types; it excludes internal/base-only types
and entity types without bundles.

## Permission generation — `DynamicPermissions::get(): array`

Registered as a `permission_callbacks` entry in `entity_type_permissions.permissions.yml`
(`\Drupal\entity_type_permissions\DynamicPermissions::get`). Steps:

1. Read `entity_type_permissions.settings:permissions_filter` (array of entity-type ids; `?? []`).
2. For each applicable entity-type definition, `continue` unless its id is in the filter.
3. For each bundle (`getBundlesForEntityTypeDefinition()` → `getStorage($bundleEntityTypeId)->loadMultiple()`),
   add key `"entity_type_permissions access {entity_type_id} {bundle_id}"` with:
   - `title` = `Access %entity_type_label "@bundle_label"` (plural entity-type label + bundle label);
   - `dependencies` = the bundle's config-dependency key/name, so the permission is removed if the
     bundle is deleted.

`getBundlesForEntityTypeDefinition()` catches `InvalidPluginDefinitionException` /
`PluginNotFoundException`, logs a warning to the `entity_type_permissions` channel, and returns `[]`.
The generated permissions do **not** set an explicit `restrict access` flag.

## Access enforcement — `entity_type_permissions_entity_access()`

Implements `hook_entity_access(EntityInterface $entity, $operation, AccountInterface $account)`:

1. Resolve `DynamicPermissions` via `\Drupal::classResolver()`; read `permissions_filter` (`?? []`).
2. Start from `AccessResult::neutral()`.
3. If `!$dynamic_permissions->applies($entity->getEntityType())` → return the initial neutral.
4. If the entity type's id is **not** in `permissions_filter` → return `AccessResult::neutral()`
   (governed only when selected on the settings form).
5. Otherwise build `$permission = "entity_type_permissions access {entity_type_id} {bundle}"` and
   return `AccessResult::allowedIf($account->hasPermission($permission))`, adding the
   `user.permissions` cache context and a reason string.

Because this is `hook_entity_access()`, the result combines with Drupal's other access results:
`allowedIf` yields `allowed()` when the account holds the per-bundle permission and `neutral()`
otherwise (it never returns `forbidden()`). The `$operation` argument is not branched on, so a held
permission governs the bundle uniformly. Enforcement is contingent on the entity type being selected
in `permissions_filter`; unselected types are left neutral.

Note: this hook covers `hook_entity_access` (view/update/delete and other operations on existing
entities). There is no `hook_entity_create_access()` implementation, so create access is not affected
by this module.
