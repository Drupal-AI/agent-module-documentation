<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

Defined in `protected_pages_extra.permissions.yml`.

| Permission | Gates | Notes |
|---|---|---|
| `administer protected pages extra` | Settings form; full admin access | `restrict access: true` |
| `access protected pages extra overview page` | View the list at `/admin/config/system/protected-pages-extra` | `restrict access: true` |
| `create and edit protected page` | Add/edit protected pages; send notification emails | `restrict access: true` |
| `delete protected page` | Delete protected pages | `restrict access: true` |
| `access protected page extra password screen` | See the login form when the middleware redirects to it | Grant to anonymous + authenticated when protected pages should be reachable by non-privileged visitors |
| `bypass protected page access check` | Visit any protected page without a password prompt | `restrict access: true`; grant sparingly |

## Bypass behavior (important)

The enforcement middleware runs **before** Drupal's authentication subscriber. To honor `bypass protected page access check` for a logged-in user, `ProtectedPagesExtraAccessChecker::userCanBypass()` reads the `uid` from the session and loads that user to evaluate the permission (falling back to `currentUser` when already available). Grant this permission only to trusted roles.

Without `access protected page extra password screen`, a visitor redirected to `/protected-page/login` gets a 403 instead of the prompt — so anonymous visitors who should be able to unlock pages need this permission.
