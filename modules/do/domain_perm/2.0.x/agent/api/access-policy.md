<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The access-policy override

Domain Permissions makes permissions domain-aware by **replacing** core's user-roles access policy.
It defines no new plugin type — it re-points an existing core service.

## Install & enable

```bash
composer require drupal/domain_perm
drush en domain_perm -y
drush cr
```

No module dependencies (info.yml declares none; composer `require` is empty). Nothing else is
needed — enabling the module installs the service override.

## What decorates what

`src/DomainPermServiceProvider.php` — `DomainPermServiceProvider` implements
`ServiceModifierInterface`. Its `alter(ContainerBuilder $container)`:

- checks `$container->hasDefinition('access_policy.user_roles')` (core's user-roles access policy,
  `Drupal\user\AccessPolicy\UserRolesAccessPolicy`);
- **sets its class** to `Drupal\domain_perm\AccessPolicy\UserRolesAccessPolicy`;
- **sets its arguments** to `entity_type.manager`, `settings`, `request_stack`.

So the container keeps the service id `access_policy.user_roles` but instantiates this module's
class. This is a class/argument swap in the service container (not a `@decorates` decorator and not
a subclass of core's policy — it extends `Drupal\Core\Session\AccessPolicyBase` directly). Core's
`AccessPolicyProcessor` collects this policy like any other, so the replacement participates in the
normal permission-calculation pipeline.

## The policy itself

`src/AccessPolicy/UserRolesAccessPolicy.php` — `UserRolesAccessPolicy extends AccessPolicyBase`.

- `calculatePermissions(AccountInterface $account, string $scope)`:
  - starts from `parent::calculatePermissions()` (the base returns an **empty**
    `RefinableCalculatedPermissions`);
  - loops `effectiveRoles($account)` and, per role, calls
    `->addItem(new CalculatedPermissionsItem($role->getPermissions(), $role->isAdmin()))` and
    `->addCacheableDependency($role)`.
  - Because it starts empty and only adds effective roles, the effective role set is the *only*
    source of permissions — no full-role leakage from the parent.
- `effectiveRoles(AccountInterface $account): array`:
  - loads `entityTypeManager->getStorage('user_role')->loadMultiple($account->getRoles())`;
  - **edit domain** → returns all roles;
  - **otherwise** → `array_intersect_key($all_roles, array_flip($roles_exempt))`, keeping only
    roles whose machine name is in `settings->get('domain_perm_roles_exempt', ['anonymous',
    'authenticated'])`.
- `isEditDomain(): bool` →
  `str_contains($this->request_stack->getCurrentRequest()->getHost(), '-content')`. The edit domain
  is any host whose name contains the literal substring `-content` (e.g. `edit-content.example.com`).
  This is not configurable in code — see the Customization note.

## Cache contexts (why results don't bleed across domains)

`getPersistentCacheContexts()` returns `['user.roles', 'url.site', 'roles_exempt']`:

- `user.roles` — core's default for this policy.
- `url.site` — makes the calculated permissions (and the derived `user.permissions` context) vary
  **per domain**, so a permission set / rendered output computed on one host is not reused on
  another.
- `roles_exempt` — a custom context (below) so results also vary when the exempt-role list changes.

`src/Cache/Context/RolesExemptCacheContext.php` — `RolesExemptCacheContext` (service
`cache_context.roles_exempt`, tag `cache.context`, id `roles_exempt`, in
`domain_perm.services.yml`). `getContext()` returns
`implode(',', settings->get('domain_perm_roles_exempt', ['anonymous', 'authenticated']))`;
`getCacheableMetadata()` returns empty metadata (the value is a settings.php constant, not
per-request state).

## Customization

Per the README: for alternate `isEditDomain()` logic (or anything else), copy this module's class as
a model for your own service override rather than patching it — there is no config hook for the
edit-domain rule. See [config/settings.md](../config/settings.md) for the one setting it reads.
