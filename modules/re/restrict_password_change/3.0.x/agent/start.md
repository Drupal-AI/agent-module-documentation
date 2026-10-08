# Restrict Password Change — agent index

Permission-only module (no config, no schema, no UI, no Drush). Splits user-management
capabilities into granular permissions and enforces them by altering the user form and the
password-reset mail. Use it with core `administer users`.

- **The seven permissions and exactly what each hides/enforces** →
  [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Enforced in `restrict_password_change.module`:
  - `hook_form_user_form_alter` — on editing **another** user, hides password / disables
    username & email / hides status / removes delete per missing permission; on editing
    **own** account, hides password + current_password if missing `change own password`.
  - `hook_mail_alter` — cancels the `user_password_reset` mail if the recipient lacks
    `reset password by request link`.
- Fields are removed with `#access = FALSE` (Form API drops submitted input for them), so it
  enforces on save, not just visually.
- No `configure` route; grant permissions at `/admin/people/permissions`.
