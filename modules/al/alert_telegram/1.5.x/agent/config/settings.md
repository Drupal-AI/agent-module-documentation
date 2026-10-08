<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration & install — alert_telegram

## Install / enable
- `drush en alert_telegram -y`. Declared dependency: core `block` (`alert_telegram.info.yml`). The module
  also uses `node` at runtime (`hook_entity_insert()` type-hints `NodeInterface`; the settings form uses
  `Drupal\node\Entity\NodeType`) though `node` is not listed as a dependency — enable Node too.
- `hook_schema()` (`alert_telegram.install`) creates two tables on install:
  - `alert_telegram_subscribers` — single column `chat_id` (varchar 255, primary key).
  - `alert_telegram_messages` — `id` (serial PK), `chat_id`, `message` (text), `message_type` (varchar 50),
    `created` (int). Update hooks `8101`/`8102` add `message_id` (int) and `first_name` (varchar 255).
    Run `drush updb` after updating.
- There is **no** `config/install` or `config/schema` directory: settings default to empty until saved, and
  the module provides no config schema.

## Settings form
`Form\AlertTelegramSettingsForm` (`ConfigFormBase`, form id `alert_telegram_settings_form`) at route
`alert_telegram.settings_form` → `/admin/config/services/alert-telegram`, gated by
`_permission: 'administer site configuration'`. It reads/writes the `alert_telegram.settings` config object.

Config keys (all stored on `alert_telegram.settings`):
- `telegram_bot_token` (textfield, required) — Bot API token from BotFather. Used by `TelegramClient` to build
  the API URL.
- `webhook_secret` (textfield, required) — shared secret embedded in the webhook path; compared in
  `WebhookController::handle()`.
- `telegram_bot_url` (textfield, required) — public `https://t.me/YourBot` link; rendered by the button block.
- `notification_emails` (textarea) — one email per line; recipients of new-message/new-content emails.
- `notify_content_types` — machine names of node types whose publish triggers a broadcast. NOTE: the current
  form build does **not** render a content-types widget (it loads roles into `$role_options` but never adds a
  form element and does not save `notify_content_types`); the key is only read by `hook_entity_insert()`. Set
  it via `drush config:set alert_telegram.settings notify_content_types.0 <bundle>` or config import if the
  UI does not expose it.

`submitForm()` saves `telegram_bot_token`, `webhook_secret`, `telegram_bot_url`, `notification_emails`.

## Routes & access
| Route | Path | Access | Notes |
|---|---|---|---|
| `alert_telegram.settings_form` | `/admin/config/services/alert-telegram` | `administer site configuration` | settings form |
| `alert_telegram.webhook` | `/alert-telegram/webhook/{secret}` (POST) | `_access: 'TRUE'` + in-controller secret check | Telegram calls this |
| `alert_telegram.messages_list` | `/admin/reports/telegram-messages` | `_custom_access` → `view telegram messages` | admin report |
| `alert_telegram.reply_form` | `/admin/reports/telegram-messages/{id}/reply` (GET,POST) | `_custom_access` → `view telegram messages` | modal reply form |
| `alert_telegram.delete_message` | `/admin/reports/telegram-messages/{id}/delete` | `administer site configuration` | deletes a row |

`Access\TelegramMessageAccessCheck::access()` grants when the account has `view telegram messages`.
`Access\WebhookAccessCheck` also exists but is unused — the webhook route uses `_access: 'TRUE'` and the
secret is validated inside the controller.

## Permissions (`alert_telegram.permissions.yml`, both `restrict access: TRUE`)
- `view telegram messages` — access the messages report and the reply form.
- `delete telegram messages` — controls whether the Delete link renders in the report (the delete route
  itself additionally requires `administer site configuration`).

## Menu links (`alert_telegram.links.menu.yml`)
- `alert_telegram.settings` under `system.admin_config_services`.
- `alert_telegram.messages` under `system.admin_reports`.
- `alert_telegram.help` under `system.admin_help` (help text lives in `alert_telegram_help()`).

## Telegram / BotFather wiring (from `alert_telegram_help()`)
1. Create a bot with BotFather (`/newbot`), copy the token into `telegram_bot_token`.
2. Register the webhook once (HTTPS required by Telegram):
   `https://api.telegram.org/bot<TOKEN>/setWebhook?url=https://yoursite/alert-telegram/webhook/<webhook_secret>`.
3. Optionally set the command menu via BotFather `/setcommands`:
   `ask`, `feedback`, `subscribe`, `unsubscribe`.
