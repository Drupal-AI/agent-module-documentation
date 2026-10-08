<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# External Roles (external_roles) — agent index

Developer **framework** module. Implements a core **Access Policy** (`access_policy` tag) that grants Drupal
permissions to users based on their **external roles** — roles that come from outside Drupal (SSO / OpenID
Connect / any external system). No routes, no controllers, no permissions of its own, no forms, no config
objects, no config schema, no Drush. Package `Access Control`. License GPL-2.0-or-later. Version 1.0.1.
Core `^10.3 || ^11` (Access Policy API needs 10.3+).

## Dependencies

- `drupal:user` (core). No third-party Composer/PHP libraries. `composer_requirements` is empty (only
  `drupal/core` is required, which is excluded).

## Data model

- A user base field `external_roles` (string, `max_length` 255, cardinality UNLIMITED) added in
  `external_roles.module` via `hook_entity_base_field_info()`; installed on existing sites by
  `external_roles_update_10000()` in `external_roles.install`. Values are stored in table
  `user__external_roles` (column `external_roles_value`, keyed by `entity_id`).

## What it provides (from source, `external_roles.services.yml`)

- **Access policy** `access_policy.external_roles` → `Drupal\external_roles\ExternalRolesAccessPolicy`
  (extends `AccessPolicyBase`). `calculatePermissions()` adds a `CalculatedPermissionsItem` of the user's
  external-role permissions; `getPersistentCacheContexts()` returns `['user.external_roles']`.
  → [api/access-policy.md](api/access-policy.md)
- **Service** `external_roles` → `Drupal\external_roles\Service\ExternalRoles`
  (`ExternalRolesInterface`). `getExternalRoles($account)` reads the base-field table;
  `getPermissions($account)` maps roles→permissions via the repository. → [api/service.md](api/service.md)
- **Repository** `external_roles.repository` → `Drupal\external_roles\ExternalRolesRepository`
  (`ExternalRolesRepositoryInterface`). Default source: `$settings['external_roles']` in `settings.php`.
  This is the **primary extension point** — override the service to source definitions elsewhere.
  → [api/repository.md](api/repository.md)
- **Cache context** `cache_context.user.external_roles` →
  `Drupal\external_roles\Cache\Context\ExternalRolesCacheContext` (context id `user.external_roles`).
  → [api/access-policy.md](api/access-policy.md)
- **User wrapper** `Drupal\external_roles\ExternalRolesUser` — plain class (not a service);
  `hasExternalRole` / `getExternalRoles` / `addExternalRole` / `removeExternalRole` / `resetExternalRoles`.
  → [api/user-wrapper.md](api/user-wrapper.md)

## How a consuming module uses it

1. Define role→permission map in `settings.php`: `$settings['external_roles']` (or override the repository).
2. Assign external roles to users in code (e.g. `hook_user_presave()` or OpenID Connect user-info save)
   with `new ExternalRolesUser($user)` + `addExternalRole()`.
3. Rebuild caches after changing the definition.

See [api/extending.md](api/extending.md) for the full extension recipe (custom repository, hooks).

## What it does NOT provide

No `*.routing.yml`, `*.permissions.yml`, controllers, forms, config objects, `config/schema`,
`config/install`, entities, or Drush commands. `configure` is null — there is no settings form.
