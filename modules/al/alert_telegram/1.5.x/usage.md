<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Alert Telegram is a two-way Telegram bot integration: it notifies Telegram subscribers when new content is published and lets those users send questions/feedback that admins read and reply to from Drupal.

---

Alert Telegram connects a Drupal site to a Telegram bot (via the Telegram Bot API). Site visitors chat with the bot using slash commands (`/start`, `/ask`, `/feedback`, `/subscribe`, `/unsubscribe`); the bot delivers updates to a Drupal webhook endpoint (`/alert-telegram/webhook/{secret}`) that stores incoming questions/feedback and their chat IDs, emails configured administrators, and manages a subscriber list. When a node of a configured content type is published, `hook_entity_insert()` pushes a Telegram message to every subscriber and an email to the notification addresses. Admins view received messages at `/admin/reports/telegram-messages`, reply to any user through a modal form, and delete messages. A "Telegram Button" block renders a themed link to the bot. Configuration (bot token, webhook secret, bot URL, notification emails, content types) lives in `alert_telegram.settings`; the bot token authenticates outbound Bot API calls and the webhook secret guards the inbound endpoint.

---

- Send a Telegram message to all subscribers automatically when a node of a selected content type is published.
- Let anonymous Telegram users subscribe to site content notifications with `/subscribe` and opt out with `/unsubscribe`.
- Collect user questions from Telegram via the `/ask` command and store them in Drupal.
- Collect user feedback from Telegram via the `/feedback` command.
- Email one or more site administrators whenever a new question/feedback message arrives.
- Review all received Telegram messages in a paginated, sortable admin report.
- Reply to a specific Telegram user directly from the Drupal admin UI via a modal reply form.
- Delete stored Telegram messages an admin no longer needs.
- Place a themed "Telegram Bot" button block that links visitors to your bot's `t.me` URL.
- Run a support/help desk channel for a community site over Telegram.
- Notify an editorial team on Telegram the moment an article goes live.
- Give operators a real-time alerting channel for newly published pages.
- Drive audience engagement by pushing new-content pings to a Telegram audience.
- Turn a Telegram bot into a lightweight feedback inbox for a small site.
- Provide a "message us on Telegram" call-to-action block on any page or region.
- Broadcast content updates without requiring users to visit or log into the site.
- Route the same new-content event to both Telegram subscribers and admin email.
- Set up bot slash-command menus (ask/feedback/subscribe/unsubscribe) through BotFather.
- Maintain a subscriber roster keyed by Telegram chat ID inside Drupal's database.
- Keep an audit trail of user questions/feedback with timestamps and message type.
- Reply-quote a user's original Telegram message when responding from Drupal.
- Integrate Telegram engagement into an existing Drupal content workflow with no external service.
