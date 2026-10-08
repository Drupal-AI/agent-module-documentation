Restrict Password Change adds fine-grained permissions that let you give a role the ability to create/edit users without letting it change other users' passwords, e-mail addresses, usernames, block status, or delete accounts.

---

The module is permission-only (no config, no schema, no UI). It defines seven permissions and enforces them by altering the user account form (`hook_form_user_form_alter`) and the password-reset mail (`hook_mail_alter`). When an administrator edits **another** user, the module hides the fields their role is not permitted to change: without `change other users password` the password widget is removed; without `change other users username` the name field is replaced by a disabled display copy; without `change other users email` the e-mail field is likewise disabled; without `block other users` the status field is hidden; without `delete other users` the Delete action is removed. When a user edits **their own** account, lacking `change own password` removes both the new-password and current-password fields. Fields are removed with `#access = FALSE`, so Drupal's Form API also ignores any submitted value for them (the change is enforced on save, not just visually hidden). Separately, `hook_mail_alter` cancels the "reset password by request link" e-mail for any recipient whose account lacks the `reset password by request link` permission, blocking password recovery for restricted accounts. Typical setup: grant a "user manager" role `administer users` plus only the specific change-* permissions you want it to have.

---

- Let a support role create and edit users but never change other users' passwords.
- Allow help-desk staff to update user profiles without resetting passwords.
- Prevent a role from changing other users' e-mail addresses (anti-account-takeover).
- Stop a role from renaming other users while still allowing profile edits.
- Remove the Delete button from the user edit form for roles without delete rights.
- Prevent a role from blocking/unblocking other user accounts.
- Force certain users to be unable to change their own password (e.g. SSO-managed accounts).
- Disable password self-service for a role by withholding `change own password`.
- Block password-reset e-mails for accounts not allowed to reset via request link.
- Delegate user administration safely to non-superadmin roles.
- Separate "can edit user data" from "can change credentials" as distinct capabilities.
- Keep e-mail/username fields visible but read-only for restricted admins (shows current value).
- Harden a multi-admin site so only a top-level role can change credentials.
- Comply with a policy that only IT security may change passwords/e-mails.
- Give content moderators user-blocking rights without password rights (grant only `block other users`).
- Grant granular per-action user-management rights across several roles.
