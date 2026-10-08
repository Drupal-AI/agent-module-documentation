<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Telegram API is a developer-facing, send-only bot client: `telegram_api.service` POSTs a message to the Telegram Bot API `sendMessage` endpoint, either synchronously or deferred onto a cron-drained queue. A `telegram_api_webform` submodule adds a Webform handler that posts submissions to a chat.

---

This module does one thing and does it deliberately narrowly: it lets Drupal code send a text message to a Telegram chat through a bot. It is **send-only** — there is no webhook, no route, no controller, no config form, and no permission; it does not receive updates or run commands, so nothing external can call into it. You build a `TelegramMessage` value object (`text`, bot `token`, `chatId`, optional `parseMode`, optional SOCKS5 proxy, optional custom endpoint `url`) and hand it to `telegram_api.service`. `sendToTelegramBot()` sends immediately and returns `TRUE` on success or an error-message string on failure; `queue()` instead drops the message onto the `telegram_api_queue`, drained by a QueueWorker on cron (or `drush queue:run telegram_api_queue`) at roughly one message per second — the right choice when a request must not block on Telegram's network round-trip. The only turnkey feature is the `telegram_api_webform` submodule (requires `drupal/webform`): its **Telegram (API)** handler formats a submission as an HTML message and sends it to a token + chat_id you configure on the form. Everything else is glue you write. Version **2.0.2** on core `^10 || ^11`; requires `ext-curl`. Three operational cautions belong in any deployment. **The bot token is the credential** — anyone holding it can post as the bot and read what it sees, so keep it in an environment variable behind a Key entity rather than in exported config, and rotate it through BotFather. **A group chat is not private**: every member sees every message the bot posts and groups accumulate members over time, so a bot echoing form submissions is publishing whatever those submissions contain — names, emails, free text — to everyone since added. **Telegram is a third-party processor, usually outside the EU**, so a notification carrying personal data is a transfer; sending a link back to the submission on your own site is often the safer shape than sending the content itself.

---

- Send a one-off text notification to a Telegram chat from custom module code.
- Post a Webform submission to a team chat via the `telegram_api_webform` handler.
- Notify an operations channel when cron detects a problem.
- Alert a team of a new commerce order or payment event.
- Send new-user registration notices to a moderators' group.
- Defer a send onto the queue so a page request never blocks on Telegram.
- Batch-drain queued notifications on cron with `drush queue:run telegram_api_queue`.
- Route messages through a SOCKS5 proxy where `api.telegram.org` is blocked.
- Send to a self-hosted or custom Bot API endpoint instead of `api.telegram.org`.
- Format a message with HTML (`parse_mode: HTML`) — bold labels, line breaks.
- Exclude sensitive fields (e.g. a hidden token field) from a forwarded submission.
- Provide a reusable bot-send service to several modules on one site.
- Notify staff of a new booking or RSVP.
- Post a contact-form enquiry into a shared channel.
- Alert on a failed background job or import.
- Send a deployment or release notification.
- Notify a Telegram-first team that does not rely on email.
- Send a short "new submission — click to view" link instead of the raw data.
- Push a workflow-transition notice to reviewers.
- Fan out the same alert to multiple chats by sending several messages.
- Throttle high-volume alerts by queueing rather than sending inline.
