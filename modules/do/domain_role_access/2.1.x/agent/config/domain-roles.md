<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring and operating Domain Role Access

Grounded in `domain_role_access.services.yml`, `.routing.yml`, `.module`,
`src/DomainRoleAccessManager.php`, `src/Controller/DomainRolesController.php`,
`src/Form/DomainRolesForm.php`.

## Install / enable

`composer require drupal/domain_role_access`, then enable it (`drush en domain_role_access`). The
`.info.yml` requires `domain:domain`, `domain:domain_config` and `domain:domain_access`, so the whole
Domain Access stack must be installed and configured first. There is no settings page, no permission
of its own, and no config schema shipped.

## The access mechanism (`DomainRoleAccessManager`)

Domain Access resolves a user's domains through `DomainAccessManager::getAccessValues()`. This module
registers a **service decorator** (`domain_role_access.access_manager`, `decorates:
domain_access.manager`, `decoration_priority: 1`) whose class extends `DomainAccessManager` and keeps
the original service as `$this->parent`.

Override logic in `getAccessValues(FieldableEntityInterface $entity, $field_name = DOMAIN_ACCESS_FIELD)`:

1. Build a request-static `$domain_roles` map once: load all `domain` entities, and for each read
   config `domain.roles.<domain->getOriginalId()>`, key `roles`. Every listed role id gets
   `$domain_roles[$role_id][$domain->id()] = $domain->getDomainId()`.
2. `$ret = parent::getAccessValues($entity, $field_name)` — the standard per-user
   `field_domain_access` values.
3. If `$entity instanceof User`, for each `$entity->getRoles()` that appears in `$domain_roles`,
   merge with `$ret += $domain_roles[$role_id]`.
4. Return `$ret`.

Because step 3 uses array-union (`+=`) keyed by domain machine name, the result is strictly
**additive (OR)**: role mapping can only *add* domains, never drop or override the per-user values.
The module contributes **no enforcement** — node grants and entity/field access stay entirely with
Domain Access; this only widens the domain set Domain Access sees for a user. Non-`User` entities are
returned unchanged from the parent.

Note it is a `static` method: the role additions apply wherever Domain Access resolves domains via the
decorated service / subclass. Any effect on cached access is inherited from Domain Access's own cache
handling; this module adds no render caching of its own.

## Route, controller and form

- Route `domain_role_access.admin` → `/admin/config/domain/roles/{domain}/edit`, requirement
  `_permission: 'administer domains'`. `DomainRolesController::getTitle()` shows
  "`<domain label> roles`"; `::edit()` loads the `{domain}` entity (throws
  `NotFoundHttpException` if it does not exist) and returns `DomainRolesForm` for that domain.
- `DomainRolesForm` (`domain_role_form`): a `#type => checkboxes` element listing all roles
  (`Role::loadMultiple()`), defaulted from the existing `roles` config. On submit it takes
  `array_filter($form_state->getValue('roles'))` and, via `configFactory->getEditable(
  'domain.roles.' . $domain_id)`, either `->set('roles', $roles)->save()` or `->delete()` when the
  selection is empty. A standard Form API submission (CSRF-token protected).

## Configuration objects

Per domain: `domain.roles.<domain_id>` with a single `roles` array of role machine names, e.g.
`domain.roles.example_com: { roles: { editor: editor, author: author } }`. No object exists for a
domain with no mapped roles (it is deleted). These are exportable/deployable config; there is no
`config/install` default and no schema, so they are schema-less config.

## Operating it

1. Go to `admin/config/domain`. Each domain row now has a **Roles** operation
   (`hook_domain_operations()`, weight 80).
2. Open it, check the roles that should have this domain's access, Submit.
3. Members of those roles are immediately treated as having that domain in addition to any per-user
   `field_domain_access` value. Unchecking all roles removes the mapping.
