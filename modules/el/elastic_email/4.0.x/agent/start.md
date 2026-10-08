<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Elastic Email (elastic_email) — agent index

**Sends Drupal outgoing mail through the Elastic Email HTTP API via a Mailsystem plugin.**

- **Version:** 4.0.x
- **Core:** ^10 | ^11
- **Depends on:** mailsystem
- **Configure route:** `elastic_email.admin_settings` → `/admin/config/system/elastic_email/settings`
- **Other routes:** `elastic_email.dashboard`, `elastic_email.send_test` (needs valid settings), `elastic_email.view_email/{msgId}` and `/content`
- **Config object:** `elastic_email.settings` (keys: `username`, `api_key`, `queue_enabled`, `log_success`, `credit_low_threshold`, `use_default_channel`, `default_channel`, `use_reply_to`, `reply_to_email`, `reply_to_name`)
- **Services:** `elastic_email.api` (`ElasticEmailManager` — `sendEmail`, `getEmailView`, `getAccountInfo`, `getChannels`), `init_subscriber`
- **Plugins:** Mail plugin `elastic_email_mailsystem`; QueueWorker `ElasticEmailProcessQueue`
- **Security:** all routes permission-gated by `administer site configuration`; no anonymous or mutating endpoints; API key stored in clear config (treat exports as secret); TLS via SDK default client.

See [configure/elastic-email.md](configure/elastic-email.md)
