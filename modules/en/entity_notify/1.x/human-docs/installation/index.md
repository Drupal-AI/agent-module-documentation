# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Telegram API** module (`telegram_api`) — provides the Telegram delivery
  channel. Composer installs it automatically when you require Entity Notify. Even
  if you only plan to use email notifications, this dependency is installed.
- No third-party PHP or JavaScript libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_notify -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install Telegram API and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_notify -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_notify -y
```

Drupal enables Telegram API at the same time if it isn't already on.

## Verify it worked

After enabling, open the [Configuration](../configuration/index.md) page, choose an
entity type to watch and a recipient, then create a test entity of that type and
confirm a notification arrives. If you plan to use Telegram, set up the bot in the
Telegram API module first (see Configuration).
