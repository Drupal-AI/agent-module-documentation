<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Telegram (API) Webform handler — `telegram_api_webform` submodule

Enable the `telegram_api_webform` submodule (requires `drupal/webform`). It adds a WebformHandler:

- Plugin id `telegram_api_handler`, label **Telegram (API)**, category **Telegram**.
- `cardinality = CARDINALITY_SINGLE` (one per webform), `results = RESULTS_PROCESSED`.
- Class `Drupal\telegram_api_webform\Plugin\WebformHandler\TelegramWebformHandler`.

## Configuration (per webform, under Emails / Handlers → Add handler → Telegram (API))

| Field | Key | Required | Notes |
|-------|-----|----------|-------|
| Telegram Bot Token | `token` | yes | Stored in the webform's exported config (plain `textfield`). |
| Chat ID | `chat_id` | yes | Target chat/channel/group id. |
| Excluded fields | `excluded_fields` | no | Comma-separated element keys to omit from the message. |

Config schema: `webform.handler.telegram_api_handler` (in
`config/schema/telegram_api_webform.schema.yml`).

## Behaviour on submit

On `submitForm()` the handler:
1. Returns early if `token` or `chat_id` is empty.
2. Builds an HTML message: first line is the uppercased webform label in `<b>…</b>`, then one
   `<b>label:</b> value` line per submitted element. Element titles come from the webform element
   `#title` (falling back to the key). Array values are `implode(', ', …)`. Empty values and any key
   in `excluded_fields` are skipped.
3. Sends via `telegram_api.service->sendToTelegramBot()` with `parseMode: 'HTML'`.
4. On failure logs the returned error string to the `telegram_api_webform` logger channel.

## Notes for agents

- Submission values are inserted into the HTML message without HTML-escaping; `parse_mode: HTML` is a
  Telegram-side rendering directive, so a submitted `<` can break/format the Telegram message but is not
  rendered in Drupal. Use `excluded_fields` to keep sensitive elements out of the chat.
- There is one handler per webform; to send to several chats, use several webforms or a custom handler.
