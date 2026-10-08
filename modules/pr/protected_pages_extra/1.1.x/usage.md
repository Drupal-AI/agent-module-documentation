<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Protected Pages Extra adds password protection to arbitrary pages, gated by granular permissions.

---

Protected Pages Extra allows site administrators to password-protect any page on their Drupal site — visitors must enter the configured password to view a protected path. It's an admin-configured access gate (independent of Drupal's role/permission access), useful for soft-gating specific pages.

It exposes granular permissions: `administer protected pages extra`, `create and edit protected page`, `delete protected page`, `access protected page extra password screen`, and notably `bypass protected page access check` — grant the bypass and admin permissions only to trusted roles. Depends on core `path_alias`; requires Drupal 11.1+.

---

- Password-protect any page.
- Require a password to view protected paths.
- Provide an admin-configured gate.
- Soft-gate specific pages.
- Work independently of role access.
- Gate admin with `administer protected pages extra`.
- Gate page CRUD with dedicated permissions.
- Offer `bypass protected page access check`.
- Restrict bypass/admin to trusted roles.
- Depend on core `path_alias`.
- Require Drupal 11.1+.
- Configure protected pages.
- Show a password screen
- Manage protected paths
- Support content gating.
- Protect pages by password.
- Control page access.
- Gate URLs
