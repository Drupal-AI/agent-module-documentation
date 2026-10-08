<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `external_roles` service

File: `src/Service/ExternalRoles.php` + interface `src/Service/ExternalRolesInterface.php`
Class: `Drupal\external_roles\Service\ExternalRoles` implements `ExternalRolesInterface`.
Service id: `external_roles`, args `@database`, `@external_roles.repository`.

Resolves a user's external roles and the permissions those roles grant. Consumed by the access policy and the
cache context.

## Methods (`ExternalRolesInterface`)

- `getExternalRoles(AccountInterface $account): array`
  Returns the account's external roles as a sorted `string[]`.
  - Statically cached per account id (`$this->externalRoles[$account->id()]`) because it can be called often
    while resolving cache contexts, and different users may be resolved in one request.
  - Guards with `$this->database->schema()->tableExists('user__external_roles')` — the method can run before
    the module is fully installed. If the table is absent it returns `[]`.
  - Query: `SELECT external_roles_value FROM user__external_roles WHERE entity_id = :uid ORDER BY
    external_roles_value` (via the database API, `->fetchCol()`).

- `getPermissions(AccountInterface $account): array`
  For each external role, calls `$this->repository->getPermissionsByRole($role)`; merges all results,
  then `array_values(array_unique(array_filter(...)))`. Returns a de-duplicated `string[]` of permission
  machine names. A user with no external roles, or roles not present in the definition, yields `[]`.

## Notes

- The service reads roles straight from the base-field table (not from the loaded user entity), so it sees
  saved values. Changes made only in memory via `ExternalRolesUser` are reflected after the user is saved.
- It performs no writes and grants nothing by default: with an empty definition or no assigned roles the
  result is an empty permission list.
