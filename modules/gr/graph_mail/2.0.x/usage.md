<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Graph Mail is a Drupal mail backend that sends outgoing email through the Microsoft Graph API (`/users/{id}/sendMail`) using an Azure app registration and OAuth2 client-credentials, instead of PHP `mail()` or SMTP.

---

The module registers a `graphmail` Mail plugin (`\Drupal\graph_mail\Plugin\Mail\GraphMail`) that Drupal's mail manager can use for any or all mail keys. All API work lives in the `graph_mail.helper` service (`MailHelper`): it reads the `graph_mail.settings` config, POSTs to `https://login.microsoftonline.com/{tenant_id}/oauth2/v2.0/token` with the client id/secret to obtain an app-only access token (scope `https://graph.microsoft.com/.default`, `grant_type=client_credentials`), builds a Graph `message` payload from Drupal's `$message` array (subject, HTML body, to/cc/bcc/reply-to parsed from comma-separated headers, plus `fileAttachment` entries from `params['attachments']`), and calls `sendMail` as the configured `user_id`. The sender address is the configured `default_mail` or the site mail; `save_to_sent_items` controls whether Graph keeps a copy in the mailbox's Sent Items. Credentials (tenant id, client id, client secret, user id, API version, default mail) are entered on the settings form at `/admin/config/services/graph_mail`, gated by the `administer graph mail configuration` permission, and stored in the `graph_mail.settings` config object. On a transient failure the plugin logs the exception and, when Graph returns HTTP 429 (throttling), re-queues the message into the `graph_mail_retry_queue` QueueWorker, which retries on cron honouring the `Retry-After` header (default 600s). It has no Drupal module dependencies but requires the `microsoft/microsoft-graph` PHP SDK (Composer); pairing with Mailsystem is recommended so you can pick Graph Mail as the site's default sender.

---

- Route all site email (registration, password reset, notifications) through a Microsoft 365 / Exchange Online mailbox via Graph instead of SMTP.
- Replace an unreliable or blocked SMTP relay with Graph API delivery on Azure-hosted sites.
- Send transactional mail from a shared/service mailbox using an Azure app registration and client secret.
- Use app-only (client-credentials) OAuth2 so no interactive user login is needed for sending.
- Set Graph Mail as the default mail backend site-wide through the Mailsystem module.
- Use Graph Mail only for specific mail keys (e.g. contact form) while keeping core mail for others, via Mailsystem.
- Send HTML-formatted email bodies (the payload uses `contentType: HTML`).
- Deliver mail with CC, BCC, and Reply-To recipients parsed from message headers.
- Attach files to outgoing mail by passing `params['attachments']` (filename + filecontent).
- Choose the sending mailbox per site with the `default_mail` / `user_id` settings.
- Keep a copy of sent mail in the mailbox's Sent Items folder by enabling `save_to_sent_items`.
- Automatically retry throttled (HTTP 429) sends on cron, respecting Microsoft's `Retry-After` delay.
- Target the Graph `v1.0` or `beta` API endpoint via the version setting.
- Send mail programmatically from custom modules by calling `MailManager` with the `graphmail` plugin.
- Send an ad-hoc message from code via the `graph_mail.helper` service (`initMailBody()` + `send()`).
- Centralise outbound mail on Azure to satisfy compliance/logging requirements in Microsoft 365.
- Avoid storing SMTP passwords by using an Azure app secret + Graph `Mail.Send` application permission.
- Support a directory-tenant-restricted setup by supplying the tenant GUID in config.
- Diagnose delivery failures through the `graph_mail` logger channel (exceptions are logged).
- Migrate a site off `smtp`/`swiftmailer` modules to a first-party Microsoft delivery path.
