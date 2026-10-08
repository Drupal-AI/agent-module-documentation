<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring Domain Permissions

There is **no admin UI and no config object** for this module. All configuration is done in
`settings.php` (or a `settings.local.php`), plus how you name your hosts.

## The one setting

```php
// The roles that stay effective on a non-edit (public) host.
// Any role NOT in this list is stripped when the request host is not the edit domain.
$settings['domain_perm_roles_exempt'] = ['anonymous', 'authenticated'];
```

- Read by `UserRolesAccessPolicy::effectiveRoles()` and by the `roles_exempt` cache context.
- Values are **role machine names** (`anonymous`, `authenticated`, `editor`, `administrator`, …).
- Default when unset: `['anonymous', 'authenticated']` (the default is hard-coded in both call
  sites, so an unset value behaves the same as the default).
- Add a role here to keep its permissions on every host; remove `authenticated` only if you want
  even baseline authenticated capabilities stripped on public hosts.

## Naming the edit domain

The module treats a host as the **edit domain** when its name contains the substring `-content`
(`isEditDomain()` → `str_contains($host, '-content')`). So set up your hosts accordingly, e.g.:

- edit domain: `edit-content.example.com` (users keep all roles here)
- public domain(s): `www.example.com`, `example.com` (non-exempt roles stripped)

There is no setting for this rule; if you need different logic, override the service with your own
class (see [api/access-policy.md](../api/access-policy.md) — Customization).

## Operational notes

- Set core `trusted_host_patterns` in `settings.php` to your real hosts so host resolution is
  well-defined for both the edit and public domains.
- After changing `domain_perm_roles_exempt`, run `drush cr` — the `roles_exempt`/`url.site` cache
  contexts key the permission cache, but clearing cache guarantees a clean recompute.

## Verifying

1. Log in as a user with an elevated role on the **edit** host (a `-content` host) — roles and
   admin access are intact.
2. Visit a **public** host as the same user — only the exempt roles remain (admin toolbar, node
   edit, config routes gone).
3. If stripping does not happen on the public host, confirm the public host name does **not**
   contain `-content` and that the edit host name **does**.
