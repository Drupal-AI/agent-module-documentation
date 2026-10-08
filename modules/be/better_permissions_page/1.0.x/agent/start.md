<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Better permissions page — agent index

Replaces the core permissions form on the **existing** route `user.admin_permissions`
(`/admin/people/permissions`) with a faster one that renders only **one provider module's
permissions at a time**, picked from a "Permission provider" select (AJAX-loaded). Fixes the
slow/WSOD full permissions table on large sites. **No configure route, no settings, no
config schema, no permissions of its own, no Drush, no plugins.** Saving still uses core's
`user_role_change_permissions()`, so role→permission grants are written exactly as core does.

- **How it works (route swap, provider select, AJAX, save path) and how to extend it** →
  [api/mechanism.md](api/mechanism.md)

Key facts:
- The route is not new — a `RouteSubscriber` sets `user.admin_permissions`'s `_form` default
  to `\Drupal\better_permissions_page\Form\BetterPermissionsForm` (extends core
  `UserPermissionsForm`).
- Nothing is stored by this module. Granting a permission to a role writes to the role
  config entity (`user.role.<rid>`) via the same core API as the stock page.
- To read/verify a grant, inspect `user.role.<rid>` permissions (e.g.
  `drush config:get user.role.<rid> permissions`), not any module-specific config.
