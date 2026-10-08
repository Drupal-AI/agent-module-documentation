<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Stop administrator login adds a validate handler to the site login form that rejects user 1 — and optionally anyone holding the administrator role — so the superuser account is kept out of interactive use.

---

Blocking user 1 from logging in is a recognised hardening step: it is the account every attacker knows exists, it bypasses every access check, and on most sites nobody actually needs to be it day to day. This very lightweight module implements that as a `#validate` callback attached to `user_login_form` and `user_login_block`; the rejection reuses core's own "Unrecognized username or password" wording so it discloses nothing about the account. A single checkbox extends the same treatment to every user whose role is flagged `is_admin`, and a `disabled` setting (config-only) turns the whole block off again for lower environments. When you need in as user 1, recovery is via `drush uli` or the one-time login link from the password-reset mail — so the module is a natural companion to an external IAM (OpenID Connect, SSO) where humans sign in with their own accounts. Configuration lives at `/admin/config/people/stop_admin` behind the `administer stop_admin configuration` permission, and the only stored config is the two booleans `disabled` and `block_admin_role`. Requires nothing beyond Drupal core and works on Drupal 8.8 through 11.

Before enabling it, make sure you have a personal administrator account with sufficient rights and Drush access for recovery — enabling this without a fallback path can leave you unable to reach user 1 interactively.

---

- Stop user 1 logging in through the login form.
- Stop every user with the administrator role logging in through the form.
- Reject superuser logins with core's generic, non-disclosing error message.
- Keep a Drush-only escape hatch (`drush uli`) for emergency access.
- Turn the block off again via the `disabled` configuration key on a DEV/STAG server.
- Satisfy an audit item about interactive superuser use.
- Discourage sharing the admin password across a team.
- Push administrators onto their own named accounts for change auditing.
- Harden a site where user 1 was historically a shared build account.
- Reduce the value of a leaked or guessed user-1 password on the login page.
- Pair with an external IAM / OpenID Connect where login happens elsewhere.
- Pair with a password policy on named administrator accounts.
- Restrict a whole role from the login form, not just user 1, with one checkbox.
- Resolve the administrator role dynamically via `is_admin` rather than a hard-coded role id.
- Delegate control of the setting with the `administer stop_admin configuration` permission.
- Add the settings link under the *People* admin menu for administrators.
- Recover access with a one-time login link from `/user/password` when needed.
- Deploy the two-key config (`disabled`, `block_admin_role`) through config management.
- Enable on Drupal 8.8–11 sites with no extra module or library dependencies.
- Document for site owners why interactive superuser login is intentionally refused.
