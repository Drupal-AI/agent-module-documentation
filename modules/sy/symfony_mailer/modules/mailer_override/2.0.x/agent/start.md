# mailer_override — agent start

Redirects legacy `hook_mail` / `MailManager` emails into Mailer Plus (installs a
`MailManagerReplacement` service). Which sources are captured is set by **MailerOverride**
plugins; enabling one imports default `mailer_policy` config. Depends on `symfony_mailer` +
`mailer_policy`. Admin: **Config → System → Mailer Plus → Override**
(`/admin/config/system/mailer/override`, route `mailer_override.status`, permission
`administer mailer`). No `configure:` key.

- Enable/disable/re-import overrides → [configure/overrides.md](configure/overrides.md)
- MailerOverride plugin type & built-ins → [plugins/mailer-override.md](plugins/mailer-override.md)
- Drush: `mailer:override`, `mailer:override-info` → [drush/commands.md](drush/commands.md)
