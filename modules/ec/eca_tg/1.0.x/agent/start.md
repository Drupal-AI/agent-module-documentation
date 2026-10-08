<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ECA Telegram (eca_tg) — agent index

One **ECA action plugin** that sends a message to Telegram via the Telegram Bot HTTP API. Package
`ECA`. Depends only on `eca`. Core `^10 || ^11`. License GPL-2.0-or-later. Version 1.0.2.

- **The action plugin — every config field, the send logic, photo/thread/buttons, tokens** →
  [plugins/telegram_message_action.md](plugins/telegram_message_action.md)

## What it actually is

- One plugin: `TelegramMessageAction` (id **`eca_telegram_send_message`**, label *"Send Telegram
  message"*), in `src/Plugin/Action/TelegramMessageAction.php`, extending ECA's
  `ConfigurableActionBase` and implementing `ContainerFactoryPluginInterface`.
- **No** routes, permissions, services, hooks, `.module`, `.install`, `.schema`, or settings form.
  It ships one config file: `config/install/eca.eca.eca_tg_default.yml` — an **empty** default ECA
  model (`eca_tg_default`, modeller `bpmn_io`, `events: {}`) as a starting point.
- All configuration lives inside the ECA action instance (bot token, chat id, thread id, message,
  image, buttons YAML). No composer.json ships, so no non-Drupal Composer requirements.

## Mechanism (from source)

- `execute($entity)` builds the API URL as `https://api.telegram.org/bot{token}/sendPhoto` when an
  image is set, else `.../sendMessage`. It sends via the core **`http_client_factory`** Guzzle
  client (`$this->httpClientFactory->fromOptions()->post(...)`), passing `chat_id`, `parse_mode:
  HTML`, and `text` (or `photo`+`caption`) as **query** parameters; adds `message_thread_id` when a
  thread id is set and `reply_markup` (an inline keyboard) when buttons are supplied.
- `message`, `image`, and `buttons_yaml` are run through the core **`token`** service
  (`$this->token->replace(..., ['node' => $entity])`) before sending.
- `buttons_yaml` is parsed with `Drupal\Component\Serialization\Yaml`; each button needs `text` +
  `callback_data`. `validateConfigurationForm()` enforces that on save; the inline keyboard is
  JSON-encoded into `reply_markup`.
- Errors are caught and written to the `eca_tg` logger channel; a non-200 response is treated as a
  failure.

## Config fields (`defaultConfiguration()` / `buildConfigurationForm()`)

`bot_token` (required), `chat_id` (required), `thread_id` (optional), `message` (required, tokens),
`image` (optional path/token → `sendPhoto`), `buttons_yaml` (optional inline keyboard). Details in
[plugins/telegram_message_action.md](plugins/telegram_message_action.md).
