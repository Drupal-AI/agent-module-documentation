# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- Core's **Media** module (`media`) — this is a declared dependency and Drupal
  enables it automatically.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/telegram_media_type -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/telegram_media_type -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en telegram_media_type -y
```

Enabling the module makes the Telegram media source available, but it does **not**
create a media type for you. Continue with
[Configuration](../configuration/index.md) to create the Telegram media type —
that is the step that actually lets editors add Telegram media.

## Verify it worked

After creating the media type (next page), go to `/media/add/telegram`. You should
see a form for a new Telegram media item where you can paste a Telegram URL.
