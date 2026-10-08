# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- A **Telegram bot** created with BotFather, giving you a **bot token**, and the
  **chat ID** of the destination chat or group. Treat the token as a secret.
- The **Webform** module if you plan to use the `telegram_api_webform` submodule to
  forward form submissions.

There are no other contributed‑module dependencies declared for the base module.

## Install with Composer

From the project root:

```bash
composer require drupal/telegram_api -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/telegram_api -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en telegram_api -y
```

To forward Webform submissions to a Telegram chat, also enable the submodule:

```bash
drush en telegram_api_webform -y
```

## Store the bot token securely

Get your bot token from BotFather and store it as a **secret** — an environment
variable, ideally referenced through a **Key** entity — rather than committing it to
configuration or code. Anyone with the token can post as your bot and read what it
can see; rotating it means talking to BotFather.

## A word on what you send

Because messages go to Telegram, a third‑party service, and because group chats are
seen by everyone in the group (and groups gain members over time), avoid sending
personal data into a chat by default. For form submissions in particular, consider
sending a **link** to the submission rather than its contents. See the
[main guide](../index.md) for the security points in full.

## Verify it worked

Add the `telegram_api_webform` handler to a test Webform (or call the
`telegram_api.service` from code) and submit a test message. It should appear in the
chat whose ID you configured. If you queued the message instead, run
`drush queue:run telegram_api_queue` and confirm it is delivered.
