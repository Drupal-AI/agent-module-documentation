# sendgrid_integration — agent start

Provides a `sendgrid_integration` Mail (`MailInterface`) plugin (`SendGridMail`) that delivers
Drupal mail through the SendGrid Web API. Requires the **Mailsystem** module (>=4.x) to select it
as a mail system. API key lives in `sendgrid_integration.settings` (raw, or a Key entity id when
the Key module is on). Config UI: **Admin → Config → System → SendGrid**
(`/admin/config/services/sendgrid`); route `sendgrid_integration.settings_form`. Package: Mail.

- Set the API key, tracking, activate as the mail system, test send → [configure/settings.md](configure/settings.md)
- Send/customize mail programmatically (message array keys, template, per-message API key, queue) → [extend/mail-plugin.md](extend/mail-plugin.md)
- Alter categories, unique args, the SendGrid message, react on send → [hooks/hooks.md](hooks/hooks.md)

Single permission: `administer sendgrid settings` (gates the settings + test forms).
Submodule: `sendgrid_integration_reports` (stats dashboard) — see its own docs.
