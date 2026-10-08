<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Alert Telegram (alert_telegram) — agent index

Two-way **Telegram bot integration**: pushes new-content notifications to Telegram subscribers and to admin
email, and ingests user questions/feedback via a webhook that admins read and reply to inside Drupal.
Version **1.5.2**. Core `^10 || ^11`. Package `Custom`. Depends on core `block` (and functionally on `node`).
No config schema, no Drush commands, no plugin types; ships one Block plugin.

## What it provides
- **Service** `alert_telegram.telegram_client` → `Service\TelegramClient` — wraps the Telegram Bot API;
  `sendMessage($chat_id, $message, $reply_to_message_id = NULL)` POSTs JSON to
  `https://api.telegram.org/bot<token>/sendMessage`. See `agent/api/telegram-client.md`.
- **Webhook** `POST /alert-telegram/webhook/{secret}` → `Controller\WebhookController::handle()` — dispatches
  the bot slash-commands, stores messages/subscribers, notifies admins. See `agent/webhook/commands.md`.
- **Settings form** `alert_telegram.settings_form` at `/admin/config/services/alert-telegram` writing
  `alert_telegram.settings` (bot token, webhook secret, bot URL, notification emails, content types).
  See `agent/config/settings.md`.
- **Admin messages UI** `/admin/reports/telegram-messages` (list) + `{id}/reply` (modal form) + `{id}/delete`.
- **Block** `telegram_button_block` → `Plugin\Block\TelegramButtonBlock` renders a link to the bot.
  See `agent/blocks/telegram-button.md`.
- **Content trigger** `hook_entity_insert()` in `alert_telegram.module` — on publish of a configured node
  type, messages every subscriber and emails the notification addresses.
- **Permissions** (`alert_telegram.permissions.yml`): `view telegram messages`, `delete telegram messages`.
- **Database** (`alert_telegram.install`): tables `alert_telegram_subscribers` (chat_id) and
  `alert_telegram_messages` (id, chat_id, message, message_type, created, message_id, first_name).

## Solution docs
- `agent/config/settings.md` — install, config keys, routes, permissions, webhook/BotFather setup.
- `agent/api/telegram-client.md` — the TelegramClient service and `sendMessage()`.
- `agent/webhook/commands.md` — webhook controller, bot commands, subscribe/message/reply/delete flow.
- `agent/blocks/telegram-button.md` — the Telegram Button block, theme hook, CSS library.
