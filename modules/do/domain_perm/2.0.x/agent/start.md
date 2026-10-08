<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Domain Permissions (domain_perm) — agent index

Replaces core's `access_policy.user_roles` service so a user's **non-exempt roles are dynamically
stripped on any host that is not the edit domain**, confining authoring/admin to the edit domain.
A security-hardening access feature. Core `>=10.3 <12` (needs the Access Policy API). License
GPL-2.0-or-later. Version 2.0.0.

- **The access-policy override, the classes, cache contexts, and edit-domain detection** →
  [api/access-policy.md](api/access-policy.md)
- **How to configure it (settings override, exempt roles, verifying)** →
  [config/settings.md](config/settings.md)

## What it actually is

- **No dependencies.** `domain_perm.info.yml` declares no `dependencies:`; `composer.json` `require`
  is empty (only `drush` in `require-dev`). It does **not** require or use the Domain (`domain`)
  project — "domain" here means the HTTP host.
- No routes, no permissions, no forms, no admin UI, no `.module`/`.install`, no config objects,
  **no config schema**, no Drush commands, no submodules, no plugin types. `configure` is null.
- Three source files only:
  - `src/DomainPermServiceProvider.php` — `ServiceModifierInterface::alter()` swaps the class and
    arguments of the core service `access_policy.user_roles`.
  - `src/AccessPolicy/UserRolesAccessPolicy.php` — the replacement access policy (extends core
    `AccessPolicyBase`).
  - `src/Cache/Context/RolesExemptCacheContext.php` — the `roles_exempt` cache context service
    (`cache_context.roles_exempt`, in `domain_perm.services.yml`).

## Mechanism (from source)

- `UserRolesAccessPolicy::effectiveRoles()` loads the user's roles; on the edit domain it returns
  all of them, otherwise only those whose machine name is in the `domain_perm_roles_exempt` setting
  (default `['anonymous', 'authenticated']`), via `array_intersect_key`.
- `isEditDomain()` returns true when the current request host **contains the substring `-content`**
  (`str_contains(request_stack->getCurrentRequest()->getHost(), '-content')`).
- `calculatePermissions()` starts from an empty base and adds a `CalculatedPermissionsItem` per
  effective role, so the effective role set fully drives every permission check.
- `getPersistentCacheContexts()` returns `['user.roles', 'url.site', 'roles_exempt']` — so
  calculated permissions vary per domain (`url.site`) and per exempt-role config (`roles_exempt`).

## Configuration

- Configured entirely in `settings.php`:
  `$settings['domain_perm_roles_exempt'] = ['anonymous', 'authenticated'];`
- Name the edit domain with a `-content` host segment. Details in
  [config/settings.md](config/settings.md).
