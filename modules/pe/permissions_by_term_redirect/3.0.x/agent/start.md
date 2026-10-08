<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions by Term Redirect — agent index

On a Permissions by Term denial, redirects anonymous users to login and returns them to the
requested node afterwards. Depends on `permissions_by_term`. UX-only; enforcement stays in Permissions by Term.

Quick facts:
- Subscriber: `PermissionsByTermAccessDeniedEventSubscriber` on `permissions_by_term.access.denied` — if the denied node == current node and user is anonymous: kill-switch, set cookie `permissions_by_term_redirect.requested_nid`, 307-redirect to `user.login`.
- Login: `hook_user_login()` reads/deletes the cookie (skips `user.reset*`) and sets request `destination` to `entity:node/{nid}`.
- No permissions, no config; redirect target is an internal node route (no open redirect). Authenticated denials get normal Access Denied.
