<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
ECA Telegram adds a "Send Telegram message" action to ECA so models can post a message to a Telegram chat via a bot.

---

ECA Telegram is a small integration for the ECA (Event-Condition-Action) framework. It ships one
configurable ECA action plugin, `TelegramMessageAction` (plugin id `eca_telegram_send_message`),
that calls the Telegram Bot HTTP API to deliver a message to a chat or channel. The action is added
to any ECA model in the modeller and configured inline: you supply the bot token, the target chat
id, and the message text (which supports Drupal tokens). Optionally it can send a photo instead of a
plain message (via `sendPhoto`), post into a specific forum topic/thread, and attach an inline
keyboard of buttons defined in YAML (each with `text` and `callback_data`). Messages are sent with
`parse_mode: HTML`. The module depends only on the `eca` module and adds no routes, permissions,
services, or settings form of its own — all configuration lives in the ECA action instance. It also
installs an empty default ECA model (`eca_tg_default`) as a starting point.

---

- Send a Telegram notification when a node is created or updated.
- Alert an editorial team's Telegram group when content moves to a review state.
- Post a channel announcement when an article is published.
- Notify administrators in Telegram when a webform submission arrives.
- Send an order/commerce event summary to a staff Telegram chat.
- Escalate a critical log/event condition to an on-call Telegram group.
- Deliver a per-user reminder message to a chat id derived from a token.
- Post an image (via `sendPhoto`) with a caption when a media item is added.
- Send a message into a specific Telegram forum topic using the thread id.
- Attach inline keyboard buttons (YAML `text` / `callback_data`) to a message.
- Build no-code Telegram automations entirely inside the ECA modeller.
- Include token-replaced content (e.g. `[node:title]`, `[node:url]`) in the message body.
- Broadcast site-status or cron-driven updates to a Telegram channel.
- Notify a moderator when a comment is posted.
- Send a confirmation ping to a chat after a scheduled task completes.
- Route different ECA events to different Telegram chats by configuring separate actions.
- Send a formatted HTML message (bold/links) using Telegram's HTML parse mode.
- Trigger a Telegram message from any ECA-supported event, condition, or successor chain.
- Provide interactive buttons for downstream Telegram bot workflows via `callback_data`.
- Send an image referenced by a token (path or URL) as the photo argument.
- Start from the bundled `eca_tg_default` model and add events/conditions around the action.
