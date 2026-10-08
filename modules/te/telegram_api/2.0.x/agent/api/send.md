<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Sending via `telegram_api.service`

Service id `telegram_api.service`, class `Drupal\telegram_api\TelegramApiService` (autowired). Also
resolvable by class name via `Drupal\telegram_api\TelegramApiService`.

## The value object

`Drupal\telegram_api\ValueObject\TelegramMessage` (final, promoted constructor):

```php
new TelegramMessage(
  string $text,
  string $token,
  string $chatId,
  bool $proxy = FALSE,
  ?string $proxyServer = NULL,
  ?string $proxyLogin = NULL,
  ?string $proxyPass = NULL,
  ?string $url = NULL,        // defaults to https://api.telegram.org/bot{token}/sendMessage
  ?string $parseMode = NULL,  // e.g. 'HTML' or 'MarkdownV2'
);
```

If `$url` is omitted it is built from the token. If `$url` does NOT contain `api.telegram.org`, the token is
also added to the POST body as a `token` form field (custom/self-hosted Bot API relay support).

## Send now

```php
use Drupal\telegram_api\ValueObject\TelegramMessage;

$message = new TelegramMessage(
  text: 'Hello from Drupal!',
  token: '618218965:AAG...',   // from a Key entity / env var, not a literal
  chatId: '12345678',
);

$result = \Drupal::service('telegram_api.service')?->sendToTelegramBot($message);
if ($result !== TRUE) {
  // $result is the error message string.
  \Drupal::logger('my_module')->error($result);
}
```

`sendToTelegramBot()` POSTs `form_params` (`chat_id`, `text`, `disable_web_page_preview` = TRUE, plus
`parse_mode` if set) with a 10-second timeout. Returns `TRUE` on HTTP 200, otherwise a string
(non-200 message, or the Guzzle exception message).

## Queue (deferred send)

```php
\Drupal::service('telegram_api.service')?->queue($message);
```

`queue()` serialises the message fields onto the `telegram_api_queue`. `TelegramQueueWorker`
(`@QueueWorker` id `telegram_api_queue`, `cron = {"time" = 60}`) drains it on cron, calling
`sendToTelegramBot()` and `sleep(1)` between items. Force a drain with
`drush queue:run telegram_api_queue`. Use this when a request must not block on Telegram's round-trip.

## Proxy

Set `proxy: TRUE` with `proxyServer` (and optional `proxyLogin`/`proxyPass`). With credentials the client
builds a `socks5h://login:pass@server` proxy URL; otherwise `proxyServer` is used as-is. Useful where
`api.telegram.org` is network-blocked.
