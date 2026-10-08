<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Installation

## Requirements

- **Drupal 8, 9 or 10** (`core_version_requirement: ^8 || ^9 || ^10`). This
  version does not target Drupal 11.
- The **`gambry/dialogflow-webhook`** PHP library (`^2.2.0`), which parses the
  Dialogflow request/response format. Composer installs it automatically with the
  command below — do not download it by hand.

## Install with Composer

Installing with Composer (rather than downloading the module) is important here,
because Composer also pulls in the required `gambry/dialogflow-webhook` library.
From the project root:

```bash
composer require drupal/api_ai_webhook -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the library and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/api_ai_webhook -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en api_ai_webhook -y
```

## Optional submodule

- **`chatbot_api_apiai`** — bridges the webhook into the Chatbot API
  intent/response framework, so you can answer Dialogflow intents through that
  framework instead of writing a raw event subscriber. Enable it only if you use
  Chatbot API:

  ```bash
  drush en chatbot_api_apiai -y
  ```

## Next step

The endpoint ships with authentication set to `none` (open). Before you expose it,
go to [Configuration](../configuration/index.md) and switch to `basic` or
`headers` authentication.
