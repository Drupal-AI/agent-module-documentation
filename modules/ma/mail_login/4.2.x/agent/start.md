# mail_login — agent start

Lets users log in by email address (in addition to, or instead of, username) by decorating
core's `user.auth` service (`AuthDecorator`) and altering `user_login_form` / `user_pass`.
No module dependencies. One config object `mail_login.settings`. Config UI:
**Admin → Config → People → Mail Login** (`/admin/config/people/mail-login`); route
`mail_login.admin` (permission `administer mail login`).

- Enable email login, email-only mode, case-sensitivity, custom labels → [configure/settings.md](configure/settings.md)
- Permission that gates the settings form → [permissions/permissions.md](permissions/permissions.md)
