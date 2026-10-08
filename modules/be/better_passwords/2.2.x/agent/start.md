# Better Passwords — agent index

Enforces a **minimum length** and a **minimum zxcvbn strength** on every core `password_confirm`
field (register / user-edit / password-reset), and can **auto-generate** initial passwords for
admin-created accounts. All behavior is driven by one config object, `better_passwords.settings`.
No plugins, no Drush, no field types. Configure route: `better_passwords.admin_settings`
(`/admin/config/people/passwords`), gated by the `administer better passwords` permission.

- **Settings keys, defaults, the admin form, and how to read/set them** →
  [configure/settings.md](configure/settings.md)
- **How validation actually works (hooks, zxcvbn scoring, error messages, auto-generate)** →
  [api/mechanism.md](api/mechanism.md)
- **The one permission it defines** → [permissions/permissions.md](permissions/permissions.md)

Key fact: the whole policy is three integer keys in `better_passwords.settings` —
`length` (default 8), `strength` (default 3, a zxcvbn 0–4 score), `auto_generate`
(0 Never / 1 Optional / 2 Required). Read with `drush cget better_passwords.settings`.
