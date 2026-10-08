# Amazon SES — agent index

A Drupal Mail plugin (`amazon_ses_mail`) that sends mail through Amazon SES v2 via the AWS SDK, with
admin UI for verified identities, throttling, an optional cron queue, and statistics. Depends on the
`aws` module (which owns AWS credentials/region) and `aws/aws-sdk-php`. Config UI at
`admin/config/system/amazon_ses/settings` (`configure` = `amazon_ses.settings_form`), gated by the
`administer amazon ses` permission (restricted).

- **Settings keys, the identities/verify/test/statistics pages, enabling SES as the mailer, update hooks** →
  [configure/settings.md](configure/settings.md)
- **The Mail plugin, `MessageBuilder`, `AmazonSesHandler`, the queue worker, and `MailSentEvent`** →
  [api/services.md](api/services.md)
- **The single permission** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Mail plugin `@Mail(id="amazon_ses_mail")` (`src/Plugin/Mail/AmazonSes.php`) extends core `PhpMail`.
- Config object `amazon_ses.settings`: `from_address`, `from_name`, `override_from`, `throttle`, `multiplier`, `queue` (+ legacy `credentials` cleared by update hooks).
- Credentials/region come from the `aws` module (`aws.client_factory` → `sesv2` client), NOT stored here.
- Send path: `MessageBuilder::buildMessage()` → queue (`amazon_ses_mail_queue`, cron) or `AmazonSesHandler::send()` (SES `sendEmail` raw MIME) → dispatch `MailSentEvent`.
