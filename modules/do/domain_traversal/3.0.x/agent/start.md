<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Domain Traversal (domain_traversal) — agent index

Adds **one admin menu item per active domain** on a multi-domain [Domain](https://www.drupal.org/project/domain)
site; a permitted logged-in user clicks another domain's link and lands on that domain **already logged in**
via a short-lived HMAC secret. ("Traversal" = navigating domains, **not** path traversal.) Package `Domain`.
Depends on `domain` (`^2.0 || ^3.0`); optionally uses Domain Access. Core `^10.1 || ^11 || ^12`, PHP `>=8.1`.
License GPL-2.0-or-later. Version 3.0.0-rc3 (version-dir 3.0.x).

- **Routes, permissions, the traverse→login flow, the service, menu links, toolbar, and how to operate it** →
  [api/traversal.md](api/traversal.md)

## What it provides (from source)

- **3 routes** (`domain_traversal.routing.yml`): the menu-block page `/admin/domain-traversal`, the
  `domain_traversal.traverse/{domain}` mint-and-redirect route (CSRF-token protected), and the
  `domain_traversal.login/{domain}/{uid}/{timestamp}/{secret}` landing route on the target domain. Each has a
  `_custom_access` callback on `Controller\DomainTraversal`.
- **2 permissions** (`domain_traversal.permissions.yml`): `traverse domains` and `traverse all domains`
  (the latter `restrict access: true`). Anonymous is blocked from both.
- **1 service** `domain_traversal` (`src/DomainTraversal.php`, implements `DomainTraversalInterface`):
  `getAccountTraversableDomainIds()`, `accountMayTraverseDomain()`, `accountMayTraverseAllDomains()` — the
  authorization logic, using the optional `@?domain_access.manager`.
- **1 menu-link deriver** `Plugin\Derivative\DomainTraversalMenuLink` → one link per active domain.
- **1 hook class** `Hook\DomainTraversalHooks::toolbar()` (`hook_toolbar`) — a key-icon toolbar item; plus
  procedural `hook_form_user_admin_permissions_alter` in `.module` hiding the anonymous permission checkboxes.
- **1 DB table** `domain_traversal` (`.install`): stores `uid`, `domain`, `timestamp`, `secret`.
- No settings form, **no config schema**, no Drush, no field/plugin types.

## Mechanism in one paragraph

Click a per-domain link → `traverse()` computes `Crypt::hmacBase64($timestamp.$uid, hashSalt.$domainId.$passwordHash)`,
inserts it into the `domain_traversal` table, and returns a `TrustedRedirectResponse` to the **target domain's**
login route. `loginAccess()` re-validates: 30-second expiry, target domain reachable by that user, account active,
and `hash_equals()` against a freshly recomputed secret. `login()` then calls `user_login_finalize()` for that uid
and redirects to `<front>`. Access to mint is gated by `traverseAccess()` (real permission + assigned-domain check +
`_csrf_token`).
