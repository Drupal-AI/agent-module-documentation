<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Hooks & access wiring

The module ships no services and no routes of its own. Everything is bootstrapped from
`eck_bundle_permissions.module` and the access handler class.

## `hook_entity_type_alter` — `eck_bundle_permissions_entity_type_alter(array &$entityTypes)`

Runs only when an `eck_entity_type` entity type is present. It queries all ECK entity type ids through
the `eck_entity_type` storage, then for each ECK content entity type it:

1. **Swaps the access handler**: `$eckEntityType->setAccessClass(EckBundleAccessControlHandler::class)`
   — so every ECK entity type is now access-checked by this module's handler instead of eck's default.
2. **Adds a per-bundle permissions tab** (only if core's `EntityPermissionsRouteProvider` class exists,
   i.e. Drupal ≥ 10.3): on the bundle config entity type it sets the `entity-permissions-form` link
   template to `/admin/structure/eck/entity/{type}/bundles/{{type}_type}/permissions` and registers
   `\Drupal\user\Entity\EntityPermissionsRouteProvider` under the `permissions` route-provider key
   (only if not already set). This yields a per-bundle "Permissions" form/tab for each ECK bundle.

## Access enforcement — `EckBundleAccessControlHandler`

`src/EckBundleAccessControlHandler.php` extends `\Drupal\eck\EckEntityAccessControlHandler`. It adds a
per-bundle permission check and **ORs** it onto eck's per-type result — so it only ever *adds* access:

- `createAccess($bundle, $account, …)` = `parent::createAccess(…)->orIf(checkBundleAccess($bundle, 'create', NULL, $account))`.
- `checkAccess($entity, $op, $account)` = `parent::checkAccess(…)->orIf(checkBundleAccess($entity->bundle(), $op, $entity->getOwner(), $account))`.
- `checkBundleAccess($bundle, $op, $owner, $account)`:
  - maps operation `update` → `edit`;
  - always checks `"{op} any {entityTypeId} entities of bundle {bundle}"`;
  - additionally checks `"{op} own {entityTypeId} entities of bundle {bundle}"` when the entity's owner
    is the acting account;
  - returns `AccessResult::allowedIfHasPermissions($account, $permissions, 'OR')` — **allowed** if the
    account holds either permission, otherwise **neutral** (never forbidden). Core's
    `allowedIfHasPermissions()` automatically attaches the `user.permissions` cache context.

Inherited eck behavior still applies: the `bypass eck entity access` permission short-circuits to
allowed, and eck's coarse per-type permissions (`{op} any/own {type} entities`, `create {type} entities`,
`create {type} entities of bundle {bundle}`) are evaluated by `parent::` before the per-bundle OR.

## `hook_help` — `help.page.eck_bundle_permissions`

Returns static markup on the module's help page listing the per-bundle permission patterns it provides
(create / edit all / delete all / view all, plus own variants for author-field types). No behavior.
