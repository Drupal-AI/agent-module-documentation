<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webform telegram notice (webform_telegram_notice) — agent index

**A Webform handler that posts submitted form data to a Telegram group/chat via the Telegram Bot API.**

- **Version:** 1.0.x (installed 1.0.0-rc1)
- **Core:** ^9.4 || ^10 || ^11
- **Depends on:** `webform`
- **Configure route:** `webform_telegram_notice.admin_settings_form` → `/admin/config/telegram/adminsettings` (permission: `webform telegram notice`)
- **Settings (`webform_telegram_notice.settings`):** `token` (bot token), `id_chat` (group/chat ID), `exception` (comma-separated field machine names to omit)
- **Handler:** `TelegramNoticeHandler` (`@WebformHandler id=telegram_notice_handler`, cardinality single, RESULTS_PROCESSED); adds via a webform's Handlers tab
- **Send path:** `submitForm()` → `\Drupal::httpClient()->get("https://api.telegram.org/bot<token>/sendMessage", [chat_id, text(html), parse_mode])`

**Security:** Admin settings route gated by the `webform telegram notice` permission; no anonymous or inbound-callback endpoints. Telegram API call is HTTPS with default TLS verification (no `verify => false`, no cleartext). Note: the bot token is stored in **plaintext config** (`webform_telegram_notice.settings`), not a Key entity — it appears in config exports; treat as a secret. Token/chat are global, so all handlers post to the same destination.

See [configure/setup.md](configure/setup.md)
