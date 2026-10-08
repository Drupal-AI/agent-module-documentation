<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Sparkpost routes Drupal's outgoing mail through the SparkPost transactional email API instead of the local PHP `mail()` function, via a core Mail plugin.

---

The module registers a Drupal Mail plugin, `sparkpost_mail`, that implements `MailInterface`: for every message it builds a SparkPost *transmissions* payload — from address/name (taken from module config), HTML body, an auto-generated plaintext part, subject, recipients parsed from `to`/`Cc`/`Bcc`, base64-encoded attachments filtered to a small MIME whitelist, a whitelisted set of `Reply-To`/`Return-Path`/`Cc`/`X-*` headers, and `options.transactional = true` — then posts it through the `sparkpost/sparkpost` v2 PHP SDK, which sends over Drupal's `http_client` (so normal TLS verification applies). The `hook_sparkpost_mail_alter()` hook lets other modules rewrite that payload before it leaves. Configuration lives at `/admin/config/services/sparkpost` behind the `administer sparkpost` permission: API key, host (US `api.sparkpost.com` or EU `api.eu.sparkpost.com`), from address/name, an optional input format applied to the body, a debug toggle (exceptions to watchdog), and an async toggle. With async on, the plugin serialises a `MessageWrapper` into the `sparkpost_send` queue and returns immediately; the queue is drained on cron (unless "skip cron" is set) or by `drush queue:run sparkpost_send`. A test-mail form at `/admin/config/services/sparkpost/test` sends a sample message (optionally with the Druplicon attached) using a config override that forces the `sparkpost_mail` plugin just for that one key. To make SparkPost the *actual* mail backend site-wide you still wire it up — either set `system.mail` `interface.default` to `sparkpost_mail`, or select the plugin in the Mailsystem module. The bundled **sparkpost_requeue** submodule listens for send failures (`hook_sparkpost_mailsend_error`) and re-queues the message up to `max_retries` times with a `minimum_time` gap between attempts. This is an **alpha** (3.0.0-alpha2) with no security-advisory coverage; the API key is a live sending credential, so treat it accordingly (environment variable / settings.php override rather than committed config).

---

- Deliver password-reset and account-activation mail reliably through SparkPost.
- Replace PHP `mail()` with an authenticated transactional provider.
- Register the `sparkpost_mail` Mail plugin as the Drupal mail backend.
- Send order confirmations and receipts from a Commerce site.
- Send Drupal mail from shared hosting where local SMTP is unreliable.
- Route all outgoing mail through an approved external provider.
- Queue outgoing mail (`async`) and drain it on cron or via Drush for throughput.
- Process the `sparkpost_send` queue manually with `drush queue:run sparkpost_send`.
- Skip cron processing of the mail queue and run it on your own schedule.
- Send test email from the admin UI to verify API key and from-address setup.
- Send a message with a file attachment (image/PDF/zip/text) through the API.
- Apply a Drupal text format to message bodies before sending.
- Use the SparkPost EU region (`api.eu.sparkpost.com`) for EU-hosted accounts.
- Rewrite the outbound SparkPost payload with `hook_sparkpost_mail_alter()` (e.g. set reply-to, add options).
- Automatically retry failed sends with the sparkpost_requeue submodule.
- Cap retry attempts and enforce a minimum delay between requeue attempts.
- Log send exceptions to watchdog via the debug toggle for diagnosis.
- Set the from name and from address centrally for all site mail.
- Add Cc/Bcc recipients that SparkPost folds into the transmission recipient list.
- Select the Sparkpost plugin per-module or per-key using the Mailsystem module.
- Move the API key out of committed config into settings.php / an environment variable.
- Diagnose a missing email by checking the SparkPost transmission response and logs.
