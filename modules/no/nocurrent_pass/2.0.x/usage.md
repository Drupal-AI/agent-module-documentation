<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
No Current Password makes the core "Current password" field on the user edit form optional, so users (and admins editing others) can change their email or password without re-entering the existing password.

---

The module is a small `hook_form_alter` layer over core's user account forms. It adds a single "Do not require current password" checkbox to the account settings form (`/admin/config/people/accounts`, route `entity.user.admin_form`), stored as the boolean `nocurrent_pass_disabled` in the `nocurrent_pass.settings` config object. When that flag is TRUE, the module alters `user_form` and `change_pwd_form`: it hides the `current_pass` field (`#access = FALSE`) and calls `$form_state->set('user_pass_reset', 1)` so core skips the current-password validation. The exception is user 1 (the superadmin), for whom the current-password field is always kept. The shipped install default is `nocurrent_pass_disabled: TRUE`, so enabling the module removes the requirement out of the box; unchecking the box on the settings form restores core's behavior. There is no permission, Drush command, or plugin — only that one config flag.

---

- Let editors update their profile email without knowing/retyping their current password.
- Allow administrators to reset another user's password without the current password.
- Remove the "current password" friction on a site where accounts are managed by staff.
- Simplify the user edit form for a low-security internal tool.
- Support SSO/externally-authenticated users who have no local password to enter.
- Turn the requirement off globally by ticking "Do not require current password" on the account settings page.
- Turn the requirement back on by unticking that checkbox (sets `nocurrent_pass_disabled` FALSE).
- Keep the current-password requirement for user 1 while dropping it for everyone else (built-in).
- Deploy the setting through config management by exporting `nocurrent_pass.settings`.
- Script the toggle in an install/update hook via the config factory.
- Reduce support tickets from users who forgot their existing password mid-edit.
- Streamline bulk account edits done by a site administrator.
- Allow a "change password" flow that doesn't demand the old password.
- Pair with a password-reset workflow where the current password is meaningless.
- Standardise the edit UX across environments by shipping the config value.
- Temporarily disable the requirement in a staging environment for testing.
- Let a customer-service role update contact emails on user accounts quickly.
- Avoid confusing anonymous-origin/imported accounts that never set a "current" password.
- Read the current setting with `drush cget nocurrent_pass.settings nocurrent_pass_disabled`.
- Set it programmatically with `drush cset nocurrent_pass.settings nocurrent_pass_disabled true -y`.
- Gate the behavior per environment by overriding the config in `settings.php`.
- Combine with a password policy module while still skipping the current-password check on edit.
