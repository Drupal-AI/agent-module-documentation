Amazon SES provides a Drupal Mail plugin that sends site email through Amazon Simple Email Service (SES v2) via the AWS SDK, plus admin UI for managing verified sending identities, send throttling, an optional cron mail queue, and account statistics.

---

The module registers a `@Mail(id="amazon_ses_mail")` plugin (`AmazonSes`, extending core `PhpMail`);
selecting it as the site's mailer (directly or, more commonly, per-module via the Mail System module)
routes outgoing mail through SES. On send, the plugin optionally overrides the From address with the
configured `from_name`/`from_address`, hands the message to `MessageBuilder` (which builds a
Symfony Mime `Email`: parses To/Cc/Bcc, detects `text/plain`/`text/html`/`multipart/mixed` from
Content-Type, splits multipart bodies, and attaches files from `params['attachments']`), and then either
enqueues it (`amazon_ses_mail_queue` QueueWorker, run on cron) or sends immediately via
`AmazonSesHandler::send()`, which calls SES `sendEmail` with the raw MIME data and dispatches a
`MailSentEvent`. AWS credentials/region are **not** stored by this module — it depends on the separate
`aws` module (`aws.client_factory` builds the `sesv2` client from an `aws_profile`). The settings form
(`admin/config/system/amazon_ses/settings`, route `amazon_ses.settings_form`, permission
`administer amazon ses` which is `restrict access: true`) configures From address/name, override-from,
throttle + multiplier (rate-limit pacing using the account's `MaxSendRate`), and queue on/off. Sub-pages
manage **Verified Identities** (list/verify/delete email or domain identities with DKIM status via SES
`ListEmailIdentities`/`CreateEmailIdentity`/`DeleteEmailIdentity`), a **Test** email form, and a
**Statistics** page showing the 24-hour send quota/usage. `hook_requirements` errors if no From address
is set; several `hook_update_N` routines migrate legacy credential config into the `aws` module's profile
and clear the old stored `credentials`. Throttling calls `usleep()` between sends to stay under the SES
rate limit.

---

- Send all site email through Amazon SES instead of PHP `mail()`/SMTP.
- Route only specific modules' mail (e.g. `user`, `commerce`) through SES using Mail System.
- Set a verified From address and name for all outgoing mail.
- Force every message to use the configured From address (override-from) regardless of the sending module.
- Verify a new sending email identity from the admin UI (triggers SES `CreateEmailIdentity`).
- Verify and DKIM-sign a whole sending domain.
- Review which identities are verified and their DKIM status at a glance.
- Delete a verified identity you no longer send from.
- Send a test email to confirm SES connectivity and identity verification.
- View your account's 24-hour send quota, amount sent, and max send rate.
- Throttle sending to stay under the SES per-second rate limit during bulk runs.
- Set a throttling multiplier matching your number of parallel PHP workers.
- Queue outgoing email and send it in batches when cron runs (smooths spikes).
- Send transactional email (password resets, order receipts) reliably at scale.
- Send HTML email, plain-text email, or multipart alternative (both) based on the message Content-Type.
- Send email with file attachments (via the mail `params['attachments']` array).
- Deliver Cc and Bcc recipients parsed from message headers.
- Set a Reply-To address via the `reply-to` message key.
- React to each successful send by subscribing to the `MailSentEvent` (`amazon_ses.mail_sent`).
- Get a configuration error surfaced on the status report until a From address is configured.
- Keep AWS credentials out of this module's own config by delegating to the `aws` module's profile/Key.
- Migrate from an older amazon_ses release whose credentials lived in module config (update hooks move them into the aws profile).
