<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Access model — one_time_login_link_admin

The module defines **no permission of its own** (there is no `*.permissions.yml`). Every entry point
reuses core's `administer users` permission.

## Who can run it

- Both routes require `_permission: 'administer users'` **and** `_csrf_token: 'TRUE'`
  (`_access_checks: access_check.permission`, `access_check.csrf`).
- `hook_entity_operation` shows the *Generate* / *Email* operations only when the current user has
  `administer users` **and** the target account `isActive()`.

There is no per-target restriction in the module: an operator with `administer users` can target any
active account by uid, including uid 1 and other administrators. This matches core's own trust
boundary for `administer users` rather than widening it — see below.

## Which users can be targeted (scope = core's `administer users` scope)

`administer users` is a core "restricted" permission (labelled with a security warning in the
permissions UI). In Drupal core it already grants update access to *every* non-anonymous user
profile, uid 1 included:

- `Drupal\user\UserAccessControlHandler::checkAccess()` returns `allowed()` for the `update`
  operation whenever the actor has `administer users`, with no uid-1 exception.
- The `pass` field is editable by anyone who can edit the user
  (`checkFieldAccess()` → `pass` / `edit` → `allowed()`).
- `ProtectedUserFieldConstraintValidator` only demands the *current password* when
  `$account->id() == $currentUser->id()` — i.e. when you edit **your own** account. Editing another
  account (uid 1 included) needs no current password.

So a holder of `administer users` can already reset any other user's password — including uid 1 —
through the normal `/user/{uid}/edit` form and log in as them. This module provides a more
convenient path (a login link) to the same capability; it does **not** cross a new privilege
boundary. Treat `administer users` as effectively administrator-equivalent when assigning it.

## Link validity & single use (all enforced by core)

The link is core's one-time-login URL, so validity is governed entirely by core, not by this module:

- **Token**: `user_pass_reset_url()` → `user_pass_rehash()`, an HMAC-SHA256 over the uid, a
  timestamp, the user's last-login time and current password hash, keyed with the site's private
  hash salt. It is not guessable and the module does not roll its own randomness.
- **Expiry**: the link stops working after `user.settings:password_reset_timeout` seconds.
- **Single use / invalidation**: because the hash incorporates the last-login time and the password
  hash, the link stops working once the user logs in (last-login changes) or once anyone changes
  that user's password.
