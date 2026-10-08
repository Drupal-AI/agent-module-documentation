<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Telegram API for Drupal modules (telegram_api) — agent index

Developer-facing, **send-only** Telegram bot client. Version **2.0.2**, core `^10 || ^11`, requires `ext-curl`.

## What it actually is
- A single service, `telegram_api.service` (`Drupal\telegram_api\TelegramApiService`), that POSTs to the
  Telegram Bot API `sendMessage` endpoint over HTTPS (Guzzle, default TLS verification on).
- **No routes, no controller, no webhook receiver, no config form, no permissions, no `.module`/`.install`.**
  It does not receive Telegram updates or run bot commands — it only sends.
- Messages are described by a `Drupal\telegram_api\ValueObject\TelegramMessage` value object:
  `text`, `token`, `chatId`, optional `parseMode`, optional SOCKS5 `proxy`/`proxyServer`/`proxyLogin`/`proxyPass`,
  optional custom endpoint `url` (defaults to `https://api.telegram.org/bot{token}/sendMessage`).
- Two send paths: `sendToTelegramBot($message)` (synchronous, returns `TRUE` or an error string) and
  `queue($message)` (defers onto the `telegram_api_queue`, drained by `TelegramQueueWorker` on cron or
  `drush queue:run telegram_api_queue`, ~1 msg/sec).
- Submodule **`telegram_api_webform`** (needs `drupal/webform`): a `telegram_api_handler` WebformHandler that
  formats a submission as an HTML message (bold uppercased form title, per-field `<b>label:</b> value` lines,
  comma-separated `excluded_fields`) and sends it to a configured `token` + `chat_id`.

## Solution types
- [api/send.md](api/send.md) — send now vs. queue; the `TelegramMessage` value object; proxy and custom endpoint.
- [webform/handler.md](webform/handler.md) — the `telegram_api_webform` Telegram (API) submission handler.

## Deployment cautions (general good practice, not module bugs)
1. **The bot token is the credential.** Anyone with it can post as the bot and read what it sees. Prefer an
   environment variable behind a Key entity over exported config; rotate via BotFather.
2. **A group chat is not private.** Everyone in the group sees every message; groups accumulate members. A bot
   echoing form submissions publishes their contents (names, emails, free text) to everyone added since.
3. **Telegram is a third-party processor, usually outside the EU.** A notification carrying personal data is a
   transfer. Sending a link back to the submission on your own site is often safer than sending the content.
