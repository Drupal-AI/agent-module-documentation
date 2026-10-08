# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- A **Telegram bot** created with BotFather, giving you a **bot token** to
  authenticate with. Treat that token as a secret.
- The module builds on the `php-telegram-bot/core` library as its base bot API;
  Composer resolves its dependencies with the command below.

## Install with Composer

From the project root:

```bash
composer require drupal/telega -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/telega -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en telega -y
```

## Store the bot token securely

Before wiring up a bot, get its token from BotFather and store it as a **secret** —
an environment variable, ideally referenced through a **Key** entity — rather than
placing it in committed configuration. The token grants full control of the bot, so
anyone who obtains it can post as your bot and read what it can see.

## Grant permissions

Telega provides its own permissions. Visit **People → Permissions** and assign them
to the roles that should manage the integration.

## Next steps

Telega is a developer toolkit — see the [main guide](../index.md#how-to-use-it) for
how to start from the bundled Demo or Generic bot and point it at your own command
classes. If you expose a webhook for Telegram to push updates, verify those inbound
requests genuinely come from Telegram.
