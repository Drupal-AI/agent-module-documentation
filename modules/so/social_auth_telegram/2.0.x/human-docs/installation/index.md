# Installation

## Requirements

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ^9.5 || ^10 || ^11`).
- **Social Auth** (`social_auth`) — the framework this plugin builds on. Composer
  installs it automatically.
- A **Telegram** account, so you can create a bot with @BotFather.

There are no third-party Composer or PHP library requirements of its own.

## Install with Composer

From the project root:

```bash
composer require drupal/social_auth_telegram -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and it pulls in Social Auth for you.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/social_auth_telegram -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en social_auth_telegram -y
```

The Composer package name (`drupal/social_auth_telegram`) and the module machine
name (`social_auth_telegram`) match.

## Verify it worked

After enabling, follow [Configuration](../configuration/index.md) to create a
Telegram bot, authorise your domain, and enter the bot token. Then render the
Telegram login link (via the `social_auth_telegram_link` theme) on a page and
confirm the Telegram login widget appears.
