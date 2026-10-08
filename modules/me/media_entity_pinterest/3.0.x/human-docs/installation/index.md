# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Media** module (`media`) enabled — the only dependency, and Drupal
  enables it automatically when you turn on this module.

There are no Composer libraries to add. Note that when Pinterest content is
displayed, the page loads Pinterest's official `pinit.js` widget from Pinterest's
CDN (`https://assets.pinterest.com/js/pinit.js`) — this is an external, proprietary
script, so pages with a Pinterest embed make a call out to Pinterest.

## Install with Composer

From the project root:

```bash
composer require drupal/media_entity_pinterest -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/media_entity_pinterest -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_entity_pinterest -y
```

Drupal enables core Media automatically as a dependency.

## After enabling

Nothing appears until you create a media type that uses the Pinterest source. That's
the whole setup, and it's covered in [Configuration](../configuration/index.md).
