<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# TelegramClient service — alert_telegram

Service id **`alert_telegram.telegram_client`** → `Service\TelegramClient`
(`alert_telegram.services.yml`, arguments `@http_client`, `@config.factory`, `@logger.factory`).

## Construction
`__construct(ClientInterface $http_client, ConfigFactoryInterface $config_factory, LoggerChannelFactoryInterface $logger_factory)`:
- Reads `telegram_bot_token` from `alert_telegram.settings`.
- **Throws `\Exception('Telegram bot token is not configured.')`** (and logs an error) if the token is empty —
  so every consumer must guarantee the token is set, or wrap `\Drupal::service('alert_telegram.telegram_client')`
  resolution in a try/catch. `WebhookController`, `MessageActionsController` and `ReplyForm` inject it directly,
  so those routes error out until a token is configured.
- Builds `$this->apiUrl = 'https://api.telegram.org/bot' . $token . '/'` (host hardcoded, not configurable).
  Uses the injected Drupal `@http_client` Guzzle client with its default options.

## sendMessage()
```
sendMessage($chat_id, $message, $reply_to_message_id = NULL): array|null
```
- POSTs `['json' => ['chat_id' => $chat_id, 'text' => $message, ('reply_to_message_id' => …)]]` to
  `{apiUrl}sendMessage`. Messages are sent as plain text (no `parse_mode`), so message bodies are not
  HTML/Markdown-parsed by Telegram.
- Decodes the JSON response; if `ok` is false, logs the Telegram `description`.
- On any `\Exception`, logs the error and returns `NULL`; otherwise returns the decoded response array.

## Callers
- `Controller\WebhookController::handle()` — command replies and acknowledgements.
- `alert_telegram_entity_insert()` (`alert_telegram.module`) — broadcasts to every row of
  `alert_telegram_subscribers` on publish of a `notify_content_types` node.
- `Controller\MessageActionsController::sendReply()` (note: this method is **not routed** — dead code; the
  reply route maps to `Form\ReplyForm`).
- `Form\ReplyForm::submitForm()` — admin reply, passing the stored `chat_id`.

## Usage sketch
```php
try {
  $client = \Drupal::service('alert_telegram.telegram_client');
  $client->sendMessage($chat_id, 'Hello', $reply_to_message_id);
}
catch (\Exception $e) {
  // Token not configured.
}
```
