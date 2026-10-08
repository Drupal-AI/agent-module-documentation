<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Sparkpost (sparkpost) — agent index

Sends Drupal's outgoing mail through the **SparkPost** transactional email API. Ships a core
Mail plugin (`@Mail` id `sparkpost_mail`, implements `MailInterface`) that builds a SparkPost
*transmissions* payload and posts it via the `sparkpost/sparkpost` v2 PHP SDK over Drupal's
`http_client`. Config + a test-send form at `/admin/config/services/sparkpost`, behind the
`administer sparkpost` permission. Core `^10 || ^11`. Version **3.0.0-alpha2** — an **alpha**,
**not** covered by the security advisory policy; it carries every password reset on the site.

**This module is not the active mailer until you wire it up.** It only registers the plugin.
Make it live by setting `system.mail` `interface.default` to `sparkpost_mail`, or by selecting
the plugin in the **Mailsystem** module (optional dependency). The settings form warns you when
neither is pointed at Sparkpost.

- **Set the API key, host, from-address, format, async/queue** → [configure/settings.md](configure/settings.md)
- **What the Mail plugin sends: the transmissions payload, headers, attachments, alter hook, the SDK/HTTP client** → [api/mail-plugin.md](api/mail-plugin.md)
- **Async queue sending + the sparkpost_requeue retry submodule** → [submodules/requeue.md](submodules/requeue.md)

Key facts:
- Config object `sparkpost.settings`: `api_key`, `api_hostname` (`api.sparkpost.com` /
  `api.eu.sparkpost.com`), `sender`, `sender_name`, `format`, `debug`, `async`, `skip_cron`.
- One permission: `administer sparkpost`. Two routes, both admin-gated. **No inbound webhook /
  bounce / event-callback route exists** — the module is outbound-only.
- Sync send by default; with `async` on, a `MessageWrapper` is serialised into the
  `sparkpost_send` queue (QueueWorker `sparkpost_send`, cron time 60s) and drained on cron or by
  `drush queue:run sparkpost_send`. `skip_cron` removes it from cron.
- Composer: `sparkpost/sparkpost:^2.0` + `php-http/guzzle7-adapter:^1.0`. No Drush commands, no
  services beyond `sparkpost.client` / `sparkpost.message_wrapper` / `sparkpost.test_mail_system_override`.
- Extension hooks: `hook_sparkpost_mail_alter()`, `hook_sparkpost_mailsend_success()`,
  `hook_sparkpost_mailsend_error()` (the last drives sparkpost_requeue).
- Test-send form (`/admin/config/services/sparkpost/test`) is gated by a custom access check:
  requires an API key to be set **and** the `administer sparkpost` permission.

Peers: SendGrid, Mailgun, Postmark, SMTP, azure_mailer (same category).
