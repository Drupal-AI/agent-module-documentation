<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Sendgrid routes Drupal's outgoing mail through the SendGrid API (Twilio) using the official SendGrid PHP library, for better deliverability and tracking than local sendmail/SMTP.

---

The module registers two core Mail plugins — `sendgrid_mail` for synchronous delivery and `sendgrid_queue_mail` for enqueue-then-cron delivery — which you select through the Mail System (`mailsystem`) module. A `sendgrid.mail_handler` service builds a `SendGrid\Mail\Mail` object from Drupal's `$message` (subject, HTML and plain-text bodies via html2text, CC/BCC, Reply-To, X-headers, and attachments) and posts it to SendGrid with your API key. The key can be entered directly or, with the optional Key module, referenced as an authentication Key entity. A settings form exposes debug logging, an IP-pool name, an optional text-format filter, and an optional themed HTML wrapper with per-module/per-key template suggestions. A test-email form verifies the configuration, a pre-send `sendgrid.send` event lets other modules alter each message, and queued mail is drained by the `sendgrid_send_mail` cron QueueWorker.

---

- Send all Drupal system email through SendGrid instead of local sendmail.
- Improve transactional email deliverability via SendGrid's infrastructure.
- Queue outgoing mail and deliver it on cron to smooth send spikes.
- Send synchronously for time-sensitive messages with the `sendgrid_mail` plugin.
- Store the SendGrid API key as a Key entity from an environment variable.
- Send password-reset and account emails reliably.
- Attach files (from content or a file path) to outgoing messages.
- Add CC and BCC recipients to notifications.
- Set a Reply-To address on outgoing mail.
- Forward custom `X-*` headers to SendGrid.
- Convert HTML mail bodies to a plain-text alternative automatically.
- Run message bodies through a chosen text format before sending.
- Wrap HTML emails in a branded template with `use_theme`.
- Override the mail template per module or per mail key.
- Send a test email to confirm the integration works.
- Log every successful send and queue with debug mode for troubleshooting.
- Restrict mail-service administration to trusted roles.
- Alter each outgoing message (categories, custom args) via the send event.
- Add SendGrid categories to segment sending in analytics.
- Route only selected modules' mail through SendGrid using Mail System per-module config.
- Replace SMTP-based delivery with an API-based one.
- Drain the mail queue on demand with `drush queue:run sendgrid_send_mail`.
- Send bulk site notifications through a managed email provider.
- Manage the site sender identity from `system.site` mail settings.
- Monitor delivery outcomes through the `sendgrid` logger channel.
