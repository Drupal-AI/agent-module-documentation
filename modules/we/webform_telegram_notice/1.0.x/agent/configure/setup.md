<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure — Webform telegram notice

## 1. Create a Telegram bot
Message **@BotFather**, `/newbot`, capture the **API token**. `/start` the bot.

## 2. Get the group/chat ID
Add the bot to your group, send `/start`, then open `https://api.telegram.org/bot<token>/getUpdates` and read `chat.id` (a group ID is typically negative, e.g. `-97…`).

## 3. Global settings
Route: `/admin/config/telegram/adminsettings` (form `WebformTelegramNoticeConfigForm`, permission `webform telegram notice`). Config object `webform_telegram_notice.settings`:
- `token` — bot API token (**required**; stored in plaintext config — treat as a secret, keep out of shared config exports)
- `id_chat` — target group/chat ID (**required**)
- `exception` — comma-separated webform element machine names to exclude from messages

Drush: `drush cget webform_telegram_notice.settings` (avoid printing the token in shared logs).

## 4. Attach the handler to a webform
`/admin/structure/webform/manage/<webform>/handlers` → **+ Add handler** → **Telegram notice handler** (`telegram_notice_handler`) → Save. Cardinality is single (one per webform).

## Runtime behavior
On submit, `TelegramNoticeHandler::submitForm()`:
1. Loads global `token` + `id_chat`; does nothing if either is empty.
2. Builds a message: uppercased webform label as heading, then `<b>Label:</b> value` per non-empty field.
3. Drops any field whose machine name is in `exception`.
4. For `webform_term_select` elements, replaces the tid with the taxonomy term name.
5. GETs `https://api.telegram.org/bot<token>/sendMessage` with `chat_id`, `text` (HTML), `parse_mode=html` over TLS.

## Notes
- All webforms using the handler share the same global token/chat — there is no per-handler destination.
- Delivery is best-effort on submit; failures are not retried (term-lookup errors are logged to `webform_telegram_notice`).
