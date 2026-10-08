<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Guardian (guardian) — agent index

Prevents chosen accounts — **user 1** above all — from logging in with a password. Entry is via
**password reset** (`/user/password`) or **`drush uli`** only. It enforces this by nulling the
guarded account's password hash and pinning its email on every save and on cron, so no
password-based auth path (login form, HTTP basic auth) can match. Version **2.3.0**. Core
requirement `^10.2 || ^11`. Package: Security.

**Why user 1 specifically:** it bypasses every permission check by design, exists on every site, is
often literally named `admin`, and is the target of essentially all automated Drupal credential
attacks. The standard advice — a long random password nobody uses — fails because the password ends
up in a password manager, a deployment script, an old handover document and a former contractor's
memory. Guardian makes the password **worthless** rather than strong.

## Capabilities
- **[configure/settings.md](configure/settings.md)** — the required `settings.php` keys
  (`guardian_mail`, `guardian_hours`), the one config-form field, the route and permission, and how
  enforcement (password null, session timeout, edit-form lockdown) actually works.
- **[hooks/hooks.md](hooks/hooks.md)** — guard accounts beyond uid 1 and add metadata to the reset
  mail: `hook_guardian_guarded_users()` and `hook_guardian_add_metadata_to_body_alter()`.

## Three things to work through before enabling it
The failure mode is being locked out of the account when it is needed most:
1. **The account's mailbox becomes the credential.** It must still exist, be monitored, and be
   protected. A reset flow pointing at a departed employee's address is **worse** than a password.
2. **Shell access becomes the other credential.** Correct on a well-run deployment; a lockout on a
   platform where nobody has a shell.
3. **Plan the emergency path in advance** — who can send a reset, who can run `drush uli`, and what
   happens if neither is available.
