# Installation

## Requirements

Telegram integration needs:

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8||^9||^10||^11`).

It lists no other module dependencies and has no third-party PHP or library
requirements. To actually connect to Telegram you will need a **Telegram bot** and
its token, plus the channel or chat you want to post to — see
[Configuration](../configuration/index.md).

## Install with Composer

From the project root:

```bash
composer require drupal/tg_integration -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/tg_integration -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en tg_integration -y
```

## Next step

The module does nothing until you connect it to Telegram. Go on to
[Configuration](../configuration/index.md) to add your bot token and channel and
decide what gets cross-posted.
