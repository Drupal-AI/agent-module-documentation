<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Guardian stops chosen accounts — user 1 above all — from logging in with a password at all, leaving password reset and `drush uli` as the only routes in.

---

User 1 is Drupal's structural weak point: it bypasses every permission check by design, it exists on every site, its username is guessable and often literally `admin`, and it is the target of essentially all automated Drupal credential attacks. The standard advice is to give it a long random password nobody uses and administer through named accounts, and the standard reality is that the password ends up in a password manager, a deployment script, an old handover document and a former contractor's memory. Guardian removes the password as an entry point entirely: on every save (and on cron) it forces the guarded account's password hash to `NULL` and pins its email to the address you configure, so credential login — the standard form, HTTP basic auth, anything password-based — has nothing to match against, and legitimate access happens only through a reset link mailed to that address or through `drush uli` on a machine that already has shell access. It also disables the account/password fields on the user edit form, blocks non-guarded users from editing guarded accounts, and destroys guarded sessions after an inactivity timeout. Version **2.3.0** on core `^10.2 || ^11`, configured at `/admin/config/system/guardian` behind `administer site configuration`; the account's mail and inactivity window come from `settings.php` (`$settings['guardian_mail']`, `$settings['guardian_hours']`), not the UI. Three things to work through before enabling it. **The account's mailbox becomes the credential**, so it must be one that still exists, is monitored, and is itself protected — a reset flow pointing at a departed employee's address is worse than a password. **Shell access becomes the other credential**, which is correct on a well-run deployment and is a lockout on a platform where nobody has a shell. And **plan the emergency path** deliberately: the failure mode is being unable to reach the account when it is needed most, so decide in advance who can send a reset, who can run `drush uli`, and what happens if neither is available.

---

- Stop user 1 logging in with a password.
- Harden the root account.
- Remove a leaked admin password's value.
- Force administration through named accounts.
- Reduce credential-attack surface.
- Protect a legacy shared account.
- Require drush uli for privileged access.
- Meet a security review requirement.
- Guard extra privileged accounts via `hook_guardian_guarded_users()`.
- Reduce risk from an old handover document.
- Protect against credential stuffing on admin.
- Enforce reset-only access.
- Secure an inherited site's admin account.
- Reduce the value of a database leak.
- Support a least-privilege administration model.
- Protect a site with many former contractors.
- Harden a high-value site.
- Remove passwords from deployment scripts.
- Auto-terminate idle privileged sessions after N hours.
- Notify a mail group whenever a guarded account is reset.
