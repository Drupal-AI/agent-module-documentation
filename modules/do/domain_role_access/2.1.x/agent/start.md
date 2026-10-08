<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Domain Role Access (domain_role_access) — agent index

Adds **per-role domain access** to Domain Access: assign user roles to a domain and every member of
those roles is treated as having that domain in their per-user Domain Access field. Purely additive
(OR logic) — it never removes or overrides existing access. Version **2.1.0**. Core
`^9 || ^10 || ^11`. License GPL-2.0-or-later. No permissions, no Drush, no config schema, no plugins.

- **Depends on** (all from the `domain` project): `domain`, `domain_config`, `domain_access`.
- **How it works, the config it writes, the route/form, and how to operate it** →
  [config/domain-roles.md](config/domain-roles.md)

## What it actually is (from source)

- **Service decorator** `domain_role_access.access_manager` (`domain_role_access.services.yml`)
  `decorates: domain_access.manager`, `decoration_priority: 1`. Class
  `Drupal\domain_role_access\DomainRoleAccessManager` **extends** `domain_access`'s
  `DomainAccessManager`, holding the inner service as `$this->parent`.
- It overrides the static `getAccessValues(FieldableEntityInterface $entity, $field_name)`. It first
  calls `parent::getAccessValues()` (the normal per-user `field_domain_access` values), then, when
  `$entity instanceof User`, for each of the user's roles adds the domains mapped to that role, using
  `$ret += $domain_roles[$role_id]` (array-union / OR). Role→domain map is built once (request-static)
  by loading every `domain` entity and reading config `domain.roles.<domain_original_id>` key `roles`.
- **No enforcement of its own.** It only changes the set of domains a user is considered to have;
  actual filtering (node grants, entity/field access) remains in Domain Access.

## Admin surface (from source)

- Route **`domain_role_access.admin`** — `/admin/config/domain/roles/{domain}/edit`, permission
  **`administer domains`** (`domain_role_access.routing.yml`). Controller
  `DomainRolesController::edit()` loads the `{domain}` entity (404 if missing) and renders
  `DomainRolesForm`.
- **`DomainRolesForm`** (`getFormId()` = `domain_role_form`): a `checkboxes` of all roles
  (`Role::loadMultiple()`); submit saves selected roles to `domain.roles.<domain_id>` (key `roles`),
  or **deletes** that config object when none are selected.
- `hook_domain_operations()` (`domain_role_access.module`) adds a **"Roles"** operation link (weight
  80) to each domain row in the domain admin listing (`admin/config/domain`).
