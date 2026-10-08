<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Webform telegram notice adds a Webform handler that sends each submission's field values to a Telegram group or chat through the Telegram Bot API.
---
Site teams often want form submissions pushed to a chat channel rather than only email. This module registers a `TelegramNoticeHandler` Webform handler that, on submit, assembles the webform label and each non-empty submitted field (resolving taxonomy term names for `webform_term_select` elements) into an HTML message and calls `https://api.telegram.org/bot<token>/sendMessage` with the configured `chat_id`. Fields listed in the handler's "Exception fields" (comma-separated machine names) are stripped before sending. The Telegram bot token and target group/chat ID are set once, globally, at `/admin/config/telegram/adminsettings` (`WebformTelegramNoticeConfigForm`), gated by the module's own `webform telegram notice` permission; the handler summary masks the token when displayed.

The outbound call uses Drupal's HTTP client over **HTTPS** (`https://api.telegram.org`) with default TLS verification — there is no `verify => false` and no cleartext transport, so the token and payload are protected in transit. Two things to note operationally: the bot token is stored in **plaintext config** (`webform_telegram_notice.settings`) via a standard `ConfigFormBase` textfield rather than a Key entity, so it appears in config exports/backups and should be treated as a secret; and because the token/chat are global, all webforms using the handler post to the same Telegram destination. The handler sends the message on `submitForm` (a `RESULTS_PROCESSED` handler) and logs term-lookup errors to the `webform_telegram_notice` channel.
---
- Send webform submissions to a Telegram group as chat messages
- Notify a team channel instantly when a contact form is submitted
- Configure the Telegram bot token globally at `/admin/config/telegram/adminsettings`
- Configure the target Telegram group/chat ID globally
- Attach the "Telegram notice handler" to a specific webform's handlers
- Exclude sensitive fields from the Telegram message via "Exception fields"
- Include the webform title (uppercased) as the message heading
- Resolve taxonomy term names for `webform_term_select` fields in the message
- Format messages as Telegram HTML (bold field labels)
- Route multiple webforms' submissions to a single Telegram destination
- Verify the masked token/chat summary shown on the handler
- Restrict who can set the bot credentials via the `webform telegram notice` permission
- Get a Telegram bot token from @BotFather and wire it in
- Discover a group chat ID via the bot `getUpdates` endpoint
- Send only selected fields by excluding the rest
- Use TLS-protected delivery to the Telegram Bot API
- Troubleshoot delivery failures via the `webform_telegram_notice` logger channel
