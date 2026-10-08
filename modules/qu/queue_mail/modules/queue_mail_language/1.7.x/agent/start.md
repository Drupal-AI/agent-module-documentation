<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Queue Mail Language — agent index

Companion submodule of **Queue Mail**. Makes queued mail send in each mail's own language
instead of the cron/default language. No config, no UI, no permissions — enabling it is the
entire configuration. Requires `language` and `queue_mail`.

- **How it works: worker-class swap, language-aware worker, negotiator service** →
  [api/language-support.md](api/language-support.md)

Key facts:
- `hook_queue_info_alter()` sets the `queue_mail` queue worker class to
  **`LanguageAwareSendMailQueueWorker`** (extends the parent `SendMailQueueWorker`).
- Service **`queue_mail.language_negotiator`** = `QueueMailLanguageNegotiator` (extends core
  `LanguageNegotiator`) — forces negotiation to the mail's langcode during send.
- Auto-installed by the parent's `queue_mail_update_8003()`.
