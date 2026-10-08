<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Graph Mail — agent index

Mail backend that sends email through the Microsoft Graph API (`sendMail`) using an Azure
app registration + OAuth2 client-credentials. Provides the `graphmail` Mail plugin, the
`graph_mail.helper` service, and a `graph_mail_retry_queue` QueueWorker. No module deps;
needs the `microsoft/microsoft-graph` PHP SDK. Config route `graph_mail.mail_service.settings`
(`/admin/config/services/graph_mail`), permission `administer graph mail configuration`.

- **Settings keys, the config object, how to select Graph Mail as a mail backend, retry queue** →
  [configure/settings.md](configure/settings.md)
- **`graph_mail.helper` (MailHelper) API, the `graphmail` plugin, sending from code, token flow** →
  [api/mailhelper.md](api/mailhelper.md)

Key facts:
- Config object `graph_mail.settings`: `tenant_id`, `client_id`, `client_secret`, `user_id`,
  `version` (`v1.0`|`beta`), `default_mail`, `save_to_sent_items` (bool). All admin-entered.
- Token: POST `login.microsoftonline.com/{tenant_id}/oauth2/v2.0/token`, scope
  `https://graph.microsoft.com/.default`, grant `client_credentials`.
- Send: POST `/users/{user_id}/sendMail` with HTML body; needs Graph **Mail.Send** application permission.
- HTTP 429 → message re-queued to `graph_mail_retry_queue`, retried on cron per `Retry-After` (default 600s).
- One permission: `administer graph mail configuration`. No Drush. Config schema provided.
