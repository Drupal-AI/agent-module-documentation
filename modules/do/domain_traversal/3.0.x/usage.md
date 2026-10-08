<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Domain Traversal adds one admin menu item per active domain on a multi-domain (Domain module) site; a permitted logged-in user clicks another domain's link and is redirected to that domain already logged in.

---

Domain Traversal is a cross-domain navigation convenience for sites built on the [Domain](https://www.drupal.org/project/domain) module, where several hostnames share one Drupal install and user base. It contributes a "Domain traversal" admin menu group whose children are generated one-per-active-domain by the `DomainTraversalMenuLink` derivative. Each child links to the `domain_traversal.traverse/{domain}` route (CSRF-token protected). When a permitted user clicks it, the `DomainTraversal::traverse()` controller mints a short-lived HMAC secret (`Crypt::hmacBase64` keyed on the site hash salt, the target domain id and the user's password hash), stores it in the `domain_traversal` table, and returns a `TrustedRedirectResponse` to the target domain's `domain_traversal.login/{domain}/{uid}/{timestamp}/{secret}` route. On the target domain, `DomainTraversal::loginAccess()` validates the secret (30-second expiry, `hash_equals` comparison, account active, account may traverse that domain) and `DomainTraversal::login()` calls `user_login_finalize()` so the same user ends up logged in on the second hostname, then redirects to the front page. Whether a user may traverse to a given domain is decided by the module's own permissions (`traverse domains`, `traverse all domains`) and, when the Domain Access submodule is installed, by the domains assigned to that user (via `DomainTraversal` service `accountMayTraverseDomain()`). Anonymous users are explicitly barred from holding either permission (a `hook_form_alter` hides the anonymous checkboxes and forces them off). The module also adds a toolbar item (`hook_toolbar`, `DomainTraversalHooks::toolbar()`) with a key icon. It has no settings form and no config schema; "which domains appear" is simply the set of active Domain entities. Despite the name, "traversal" means navigating between domains — it is unrelated to path traversal.

---

- Let editors and administrators hop between the hostnames of a multi-domain Domain-module site without retyping URLs.
- Arrive on a second domain already logged in as the same user, instead of re-authenticating per hostname.
- Add an admin menu group listing every active domain as a clickable link.
- Show a toolbar item (key icon) for quick access to the traversal menu.
- Restrict cross-domain hopping to specific roles via the "Traverse between assigned domains" permission.
- Grant power users cross-domain access to every domain via the "Traverse between all domains" permission.
- Limit each editor to only the domains assigned to them through the Domain Access submodule.
- Speed up review workflows where the same content must be checked on several affiliate domains.
- Reduce friction for staff who administer a network of related sites from one Drupal install.
- Provide per-domain deep links that respect the domain's configured base path/hostname.
- Keep anonymous visitors from ever gaining traversal permissions (enforced on the permissions form).
- Protect each hop with a CSRF token so a menu click cannot be forged from another site.
- Use short-lived, one-time-style login secrets tied to the user's password hash and the site hash salt.
- Support Domain 2.x and Domain 3.x on Drupal 10.1+, 11 and 12.
- Work with or without the Domain Access submodule (assigned-domain checks apply only when it is present).
- Give multi-brand or franchise operators a fast way to switch operating context.
- Let a support agent jump to the exact domain a ticket concerns.
- Avoid building custom cross-domain login links by hand.
- Complement Domain's own access controls rather than replacing them.
- Serve as a lightweight admin-navigation aid on any Domain-based site.
