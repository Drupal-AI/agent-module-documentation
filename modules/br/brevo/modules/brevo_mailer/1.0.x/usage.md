Brevo Mailer routes Drupal's outgoing email through the Brevo transactional-email API, as either a Mail System mail plugin or an auto-configured Symfony Mailer transport, with optional queueing, theming, text-format filtering, and sandbox/test mode.

---

The submodule ships two `@Mail` plugins — `brevo_mail` (`BrevoMail`) and `brevo_queue_mail`
(`BrevoQueueMail`, which always queues) — plus a `BrevoMailerHandler` service (`brevo_mailer.mail_handler`)
that converts Drupal's `hook_mail` message array into a Brevo `SendSmtpEmail` and calls `sendTransacEmail()`
via the parent module's factory. `BrevoMail::format()` optionally runs the body through a configured text
filter (for non-HTML mail) and a theme wrapper (`brevo` template); `buildMessage()` parses to/cc/bcc,
sender/reply-to (including "Name <email>" forms), attachments (base64), extra headers, and allowed params
(templateId, params, tags, scheduledAt, batchId, messageVersions), and adds the `X-Sib-Sandbox: drop` header
in test mode. Queueing puts messages on the `brevo_send_mail` queue, drained on cron by the `CronSendMail`
queue worker. The settings form (`/admin/config/services/brevo/mailer/settings`, permission
`administer brevo`) toggles debug/test mode, the format filter, theme wrapping, and (with Mail System)
queueing, and validates that Mail System or Symfony Mailer is present and Brevo is the active
plugin/transport. When Symfony Mailer is installed the module auto-creates a `brevo` transport whose DSN
(`brevo+api://<api_key>@default`) is kept in sync with the Brevo API key via a config event subscriber, and
locks the DSN field in the transport edit form. A test-email form lets an admin send a trial message.

---

- Send all Drupal email through Brevo instead of PHP mail/SMTP.
- Use Brevo as a Mail System default (or per-module/per-key) mail plugin.
- Auto-configure a Symfony Mailer "brevo" transport from the Brevo API key.
- Queue outgoing emails and deliver them on cron (brevo_queue_mail / use_queue).
- Enable Brevo sandbox/test mode so mail is accepted but not delivered.
- Log every sent/queued message for debugging (debug mode).
- Apply a text-format filter (e.g. Convert line breaks) to plain-text mail bodies.
- Wrap HTML mail in a themeable `brevo` template (or a custom theme hook).
- Send a test email from the admin form to verify configuration.
- Deliver HTML mail with an auto-generated plain-text alternative (html2text).
- Attach files to Brevo messages (filepath or in-memory content, base64-encoded).
- Send with cc/bcc/reply-to parsed from headers or params.
- Pass Brevo template params, tags, scheduledAt, batchId via `$message['params']`.
- Keep the Symfony Mailer Brevo DSN in sync when the API key changes (config subscriber).
- Prevent manual edits to the managed Brevo DSN in the transport form.
- Route only specific mail keys through Brevo by selecting the mail plugin per key (Mail System).
- Restrict mailer configuration to the `administer brevo` permission.
- Warn admins when Brevo is installed but not set as the default mailer/transport.
- Send transactional messages that reference a Brevo template id.
- Retry failed queued sends automatically (queue worker throws on API failure).
