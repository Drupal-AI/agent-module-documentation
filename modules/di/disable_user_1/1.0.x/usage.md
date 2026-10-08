<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Disable User 1 blocks the account with ID 1 — Drupal's implicit superuser, which bypasses every permission check — by logging it out on every request once you switch the feature on in `settings.php`.

---

User 1 is a special case in Drupal: it is not a role or a permission set but a hard-coded exception, so `hasPermission()` returns TRUE for it whatever the permissions page says. That makes it the single most valuable account on any site and the one least likely to be governed: typically created at install with a password chosen in a hurry, shared during a build, and rarely audited afterwards. A hardened site therefore wants it unusable, with real administrators holding an administrator role whose permissions are visible and reviewable. This module does that with one event subscriber (`src/EventSubscriber/DisableUser1EventSubscriber.php`): it subscribes to the kernel `REQUEST` event and, on every page load where the current user is uid 1, calls `user_logout()`, shows an error message and redirects to the front page — so uid 1 can never hold a usable browser session. Because the check runs per request rather than on the login form, it catches every browser sign-in path equally, including one-time login links and password-reset links. The module has no admin UI, no routes, no permissions and no dependencies, on core `^10 || ^11`; it stays inert until you activate it by adding `$config['disable_user_1.settings']['disable_user_1'] = TRUE;` to `settings.php`. Two things to establish first: confirm a genuine administrator account with an administrator role exists and works (disabling uid 1 without one leaves the browser with no full administrator), and remember the off switch is that same `settings.php` line — remove it (or uninstall the module) and rebuild the cache to restore uid 1. Command-line administration through Drush is unaffected, since Drush does not route through the HTTP kernel this subscriber listens on.

---

- Disable Drupal's implicit superuser account in the browser.
- Harden a site against uid 1 compromise.
- Force administration through a reviewable administrator role.
- Meet a security review or penetration-test recommendation to lock down uid 1.
- Remove a shared build-time account from browser use.
- Reduce the value of a leaked uid 1 password.
- Make configured permissions the real access model.
- Block browser login as the permission-bypassing account.
- Catch uid 1 sign-in via a one-time login link or password-reset link, not just the login form.
- Support a least-privilege policy.
- Close an account nobody audits.
- Reduce risk on a long-lived site.
- Move day-to-day superuser tasks to the command line.
- Prevent accidental use of uid 1 during a build.
- Enforce role-based administration.
- Reduce the blast radius of credential theft.
- Align with Drupal hardening guidance.
- Turn the protection on or off from `settings.php` per environment (e.g. production only).
- Activate it without touching exported site configuration.
- Restore uid 1 by removing one `settings.php` line and rebuilding the cache.
