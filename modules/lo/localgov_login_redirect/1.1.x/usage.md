<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
LocalGov Login Redirect sends users to one admin-chosen page after they log in, instead of to their own user profile at `/user/{uid}`.

---

Drupal's default post-login destination is the account page, which is almost never where anyone wants to be. This module makes the alternative a single configuration value. A settings form at `/admin/config/system/localgov_login_redirect` (permission `administer site configuration`) holds two keys in the `localgov_login_redirect.settings` config object: `enabled` (a master switch) and `redirect_path` (the target, default `/admin/content`). The behavior is one `hook_user_login()` implementation in `localgov_login_redirect.module`: when enabled, it sets the request's `destination` query parameter to the configured path so core performs the redirect. It stays out of the way in three cases — when disabled, on one-time-login / password-reset routes (`user.reset`, `user.reset.login`), and when the request already carries a `destination` parameter, which it never overwrites. The target path is run through the `path.validator` service's `getUrlIfValid()`, which access-checks it for the logging-in user, so someone who cannot reach the configured page simply falls through to Drupal's default. The destination is therefore a single global path rather than a per-role one; the appearance of role-based behavior comes purely from that access check. It depends only on core `user` and works on any site — it originates in the LocalGov Drupal distribution but has no council-specific dependencies. Because the destination is plain configuration it exports with `drush config:export` and changes without a deployment.

---

- Send editors to the content list (`/admin/content`) after login.
- Redirect staff to a dashboard on login.
- Stop users landing on their own profile page after logging in.
- Send members to a members' area.
- Configure the post-login destination without writing custom code.
- Improve the first click after login.
- Direct users to a specific view after they authenticate.
- Keep the login destination in exportable configuration.
- Reduce support questions about "where do I go now".
- Match the login flow to an editorial workflow.
- Redirect to the front page instead of the profile page.
- Support a council site's staff intranet landing page.
- Change the destination without a code deployment.
- Reduce clicks to reach frequent tasks after login.
- Give a single-purpose site a sensible landing page.
- Align login with a site's information architecture.
- Replace a bespoke form alter or per-project event subscriber.
- Toggle the redirect on or off site-wide with one setting.
- Let users following a password-reset link reach their account normally.
- Preserve an explicit `?destination=` when one is already present.
- Fall back to the default account page for users who lack access to the target.
- Set the destination per environment via configuration overrides.
