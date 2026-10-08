<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
One Time Login lets permitted administrators generate secure, single-use, expiring login links for users, built on Drupal core's one-time-login token mechanism.

---

One Time Login lets permitted administrators generate secure one-time login links for users — a link a
user can click to log in without a password, for onboarding, support access, or account recovery. It is
built correctly on Drupal core's own mechanism: the login token is generated with core's
`user_pass_rehash()` (the same cryptographically-strong, user-specific token core uses for password-reset/
one-time-login links), and the module wraps it with a short URL (`/s/{hash}`), IP-binding, expiry,
single-use, and revocation. It is configured at `onetimelogin.settings`, provides its own permissions and
Drush commands.

The generation side is well-guarded: it requires the `access one-time login` permission, validates the
target user is active, checks a CSRF token, applies rate limiting, and logs attempts with IP. This is a
soundly-built, security-conscious implementation of one-time login. When adopting: restrict the
generation permission tightly (it grants the ability to log in AS other users), keep the expiry short, and
treat generated links as sensitive bearer credentials (they log in whoever holds them until expiry/use).
Provide the revoke capability to invalidate outstanding links.

---

- Generate one-time login links.
- Log a user in without a password.
- Build on core user_pass_rehash.
- Use a short URL with IP-binding.
- Expire and single-use the link.
- Revoke outstanding links.
- Require access one-time login permission.
- Validate the target user is active.
- Check a CSRF token on generation.
- Rate-limit generation.
- Log attempts with IP.
- Provide Drush commands.
- Restrict the generation permission tightly.
- Keep expiry short.
- Treat links as bearer credentials.
- Understand it grants login-as-user.
- Use for onboarding/support/recovery.
- Configure at onetimelogin.settings.
- Provide its own permissions.
- Invalidate links via revoke.
