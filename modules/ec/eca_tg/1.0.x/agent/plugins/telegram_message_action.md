<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Send Telegram message — ECA action (`eca_telegram_send_message`)

Class `Drupal\eca_tg\Plugin\Action\TelegramMessageAction`
(`src/Plugin/Action/TelegramMessageAction.php`). Extends `Drupal\eca\Plugin\Action\ConfigurableActionBase`,
implements `ContainerFactoryPluginInterface`.

- `@Action` id **`eca_telegram_send_message`**, label *"Send Telegram message"*, description
  *"Sends a message via Telegram bot."*
- Injected services (`create()`): `http_client_factory` → `$httpClientFactory`, `token` → `$token`,
  `logger.factory` → `$loggerFactory`.

## Install / enable

`drush en eca_tg` (pulls in `eca`). Then add the action to an ECA model in the modeller (BPMN.io /
Camunda). There is no admin settings form and no route — configure everything on the action.

## Configuration fields

`defaultConfiguration()` keys (all default `''`) and `buildConfigurationForm()` widgets:

| Key | Widget | Required | Purpose |
|---|---|---|---|
| `bot_token` | textfield | yes | Telegram bot token; goes into the API URL path. |
| `chat_id` | textfield | yes | Target chat/channel id (sent as `chat_id`). |
| `thread_id` | textfield | no | Optional forum topic id → `message_thread_id`. |
| `message` | textarea | yes | Message body; **tokens** supported. |
| `image` | textfield | no | Image path/URL or token; if non-empty switches to `sendPhoto`. |
| `buttons_yaml` | textarea | no | Inline keyboard as YAML list of `{text, callback_data}`. |

`buttons_yaml` carries `#eca_token_replacement => TRUE`. `submitConfigurationForm()` stores each
field back into `$this->configuration`.

## Validation (`validateConfigurationForm()`)

If `buttons_yaml` is non-empty it is `Yaml::decode()`d; must be an array; every entry must have a
non-empty `text` and `callback_data`, else a form error. Invalid YAML → form error.

## Send logic (`execute($entity = NULL)`)

1. Reads `bot_token`, `chat_id`, `thread_id` from config; runs `image`, `message`, `buttons_yaml`
   through `token->replace($value, ['node' => $entity])`.
2. Chooses endpoint: image present → `https://api.telegram.org/bot{bot_token}/sendPhoto`, else
   `.../sendMessage`.
3. Builds a `$query` with `chat_id` and `parse_mode => 'HTML'`; adds `message_thread_id` when
   `thread_id` set; for an image adds `photo` + `caption`, otherwise `text`.
4. If buttons are set: `Yaml::decode()`, collect `{text, callback_data}` into one row, and set
   `reply_markup => Json::encode(['inline_keyboard' => [$row]])` (a single row of buttons). Parse
   errors here are logged to channel `eca_tg`, not thrown.
5. Sends `$client->post($url, [HEADERS => ['Content-Type' => 'application/json'], QUERY => $query])`
   using `$this->httpClientFactory->fromOptions()` (a standard Guzzle client). A non-200 response
   raises an exception; the outer `try/catch` logs any failure to the `eca_tg` logger channel.

## Notes for agents

- The client is created with `fromOptions()` and **no custom options**, so Guzzle's default TLS
  verification is in effect (HTTPS to `api.telegram.org`).
- All parameters (including `text`/`caption` and `chat_id`) are transmitted as **URL query**
  parameters on a POST, not as a JSON/form body, despite the `Content-Type: application/json`
  header.
- Messages use `parse_mode: HTML`; content is Telegram-side rendered, so HTML-special characters in
  token-expanded text are interpreted by Telegram.
- `image`/`photo` is passed to Telegram's `sendPhoto`; Telegram's servers fetch the URL — the Drupal
  site does not fetch it.
- The bundled model `eca.eca.eca_tg_default` has no events; wire your own event → this action.
