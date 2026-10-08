<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Operation link reweighting

The entire module is one hook in `edit_role_permissions.module`:

```
function edit_role_permissions_entity_operation_alter(array &$operations, EntityInterface $entity) {
  if ($entity->getEntityTypeId() == 'user_role') {
    if (array_key_exists('permissions', $operations) && array_key_exists('edit', $operations)) {
      $operations['permissions']['weight'] = $operations['edit']['weight'] - 1;
    }
  }
}
```

## What it does
- Implements `hook_entity_operation_alter()` (core alter hook fired while building the operations column of an entity
  list builder).
- Acts only when the entity is a `user_role` (config entity for a Drupal role) and both the `permissions` and `edit`
  operations are present in `$operations`.
- Sets the `permissions` operation's `weight` to one less than the `edit` operation's weight, so "Edit permissions"
  sorts before "Edit". Because the first operation renders as the primary action on each row of
  `/admin/people/roles`, this makes "Edit permissions" the default operation.

## What it does NOT do
- It does not add, remove, or relabel any operation — the `edit` and `permissions` operations (and their links/URLs)
  are provided by core's User module list builder; this hook only changes ordering via `weight`.
- It defines no route, form, controller, service, permission, config object, or config schema.
- The "Edit permissions" link points at core's own route (`entity.user_role.edit_permissions_form`), which core gates
  with the `administer permissions` permission plus core's per-permission grant safeguards. This module changes none of
  that access logic.

## Install / operate
- `drush en edit_role_permissions` (depends on core `user`). No configuration; the behavior applies immediately to the
  roles admin list. Uninstall to restore core's default operation ordering.
