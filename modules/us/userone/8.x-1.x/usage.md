<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
User One hardens the Drupal super-admin (uid 1) against other administrators and adds automatic IP banning for brute-force login attempts.

---

Via `hook_ENTITY_TYPE_access()` (`userone_user_access`) it forbids any account other than uid 1 from viewing or editing the user-1 entity — even users with "Administer users". `hook_views_query_alter()` injects a `uid <> 1` condition into any view whose base is `users_field_data`, hiding user 1 from people lists / Who's Online / Who's New (the module also ships a corrected Who's Online view). `hook_form_alter()` removes `userone` from the modules install/uninstall forms for non-uid-1 so it cannot be trivially turned off. On the login form it adds a validator that, when `block_ip_on_failed_login_ip` is set, reads the core `flood` table for `user.failed_login_ip` events over a configurable window/threshold and permanently bans offending IPs through the `ban.ip_manager` service, optionally emailing user 1.

Security posture is sound and non-bypassable. The only route, the settings form at `/admin/config/people/userone`, is gated by a `_custom_access` callback that returns `AccessResult::allowed()` **only** when `$account->id() == 1` and forbidden otherwise — so its protections cannot be reconfigured by a lesser admin, and it exposes no route to grant access to, or block/unblock, user 1. The flood query is parameterised (no SQL injection). Note it depends on core `ban`. Typical setup: enable it (with `ban`), and as user 1 tune the failed-login limit/window and IP-ban/notify toggles.

---

- Block all non-uid-1 accounts from viewing the user-1 profile.
- Block all non-uid-1 accounts from editing the user-1 account.
- Deny even 'Administer users' holders access to user 1.
- Hide user 1 from the `/admin/people` list.
- Hide user 1 from Who's Online and Who's New blocks.
- Use the shipped corrected Who's Online view for accurate counts.
- Hide user 1 from any custom view built on `users_field_data`.
- Prevent non-uid-1 users from uninstalling the User One module.
- Prevent non-uid-1 users from disabling User One on the modules form.
- Automatically permanently-ban IPs after repeated failed logins.
- Tune the allowed failed-login attempts per IP (default 50).
- Tune the failed-login counting window (5 min – 24 h).
- Toggle whether offending IPs are auto-banned via core Ban.
- Email user 1 whenever an IP is blocked.
- Override Drupal's built-in IP flood limits site-wide.
- Restrict the settings form so only user 1 can open it.
- Review and manage banned IPs on the core Ban admin page.
- Harden a site against brute-force login attacks.
