# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- Core's **Block** module (`block`) — Drupal enables it automatically as a
  dependency.
- A **Telegram bot** and its token (created via Telegram's BotFather), plus the
  chat or channel ID you want alerts sent to.

There are no third-party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/alert_telegram -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/alert_telegram -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en alert_telegram -y
```

## Next steps

Once enabled, configure the bot token and target chat, and grant the module's
permission — see [Configuration](../configuration/index.md). Store the bot token
as a secret; do not paste it into a form that ends up committed to version
control.
