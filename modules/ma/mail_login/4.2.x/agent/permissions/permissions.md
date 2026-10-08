# Permissions

Defined in `mail_login.permissions.yml`.

| Permission | Gates |
|---|---|
| `administer mail login` | Access to the Mail Login settings form (`/admin/config/people/mail-login`, route `mail_login.admin`). Marked `restrict access: TRUE` (trusted/administrative — it controls how users authenticate). |

This is the module's only permission. It does not gate logging in by email — email login is
governed entirely by the `mail_login.settings` config (`mail_login_enabled`,
`mail_login_email_only`); the permission only protects who can change those settings.

```
drush role:perm:add site_admin 'administer mail login'
```
