<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Guardian stops chosen accounts — user 1 above all — from having a usable password at all: on every save it pins their email to the address in `$settings['guardian_mail']` and blanks their password, so the only way in is a `/user/password` reset link or `drush uli`.

---

Guardian's protection is enforced at the entity layer, not just on a form. Whenever a guarded user is saved — through the user edit form, `drush user:password`, REST, JSON:API, a migration or any programmatic `$user->save()` — its `hook_user_presave` implementation calls `setDefaultUserValues()`, which forces `mail` and `init` back to the guardian email and calls `setPassword(NULL)`, wiping the stored hash. Because that hook runs after core's field-level `preSave`, the NULL sticks and password login for the account becomes impossible; the account is instead reached through Drupal's one-time-login flow (a password reset email or `drush uli [uid]`), which authenticates without a stored password. The set of guarded users is always `uid 1`, keyed to `$settings['guardian_mail']`, plus any accounts (uid >= 2, valid email) returned by `hook_guardian_guarded_users`. A kernel request subscriber force-logs-out any guarded user whose session is older than `$settings['guardian_hours']` (default 2) or whose uid-1 data has drifted, redirecting them to `/user/password` with a "please login again" warning; `hook_cron` similarly restores any guarded account that fails the data check. The user edit form additionally disables all account fields (and hides the password fields) for guarded users, showing the configurable "Disabled by Guardian." note from `/admin/config/system/guardian`. Enabling, disabling, and each password reset for a guarded user send/append a notification to the guardian email carrying the client IP, hostname and (on CLI) terminal user. `hook_requirements` errors at install if `$settings['guardian_mail']` is missing or not a valid address. Core requirement `^10.2 || ^11`; config behind `administer site configuration`.

---

- Stop user 1 from ever logging in with a password.
- Harden the root/superuser admin account of a Drupal site.
- Make a leaked or guessed admin password worthless.
- Force all privileged access through `drush uli` or password reset.
- Avoid storing or sharing complex admin passwords in an organization.
- Route user-1 password resets to a shared team inbox / mail group.
- Automatically revert any change to a guarded account's email.
- Automatically blank any password set on a guarded account.
- Auto-restore a guarded account's credentials via cron after out-of-band tampering.
- Force-log-out privileged accounts after a set idle period (default 2h).
- Shorten admin session lifetime on shared or public machines.
- Get emailed whenever Guardian is enabled or disabled on a site.
- Get client IP / hostname metadata on every guarded-user reset email.
- Extend protection to administrator-role accounts via `hook_guardian_guarded_users`.
- Protect an inherited site whose admin password history is unknown.
- Reduce the value of a database dump that exposes password hashes.
- Support a least-privilege model where admins use named accounts.
- Cut off a departed contractor by removing them from the shared inbox.
- Satisfy a security-review requirement to disable password login for uid 1.
- Remove admin passwords from deployment scripts and handover documents.
- Restrict who may view/edit guarded accounts to other guarded accounts.
- Customize the message shown on disabled guarded-account fields.
