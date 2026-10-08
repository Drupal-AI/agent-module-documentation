# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- Core's **Media** module (`media`) — the only dependency, since the formatter
  extends core's Media Thumbnail formatter. Drupal enables it automatically as a
  dependency.
- No third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/media_thumbnail_url_formatter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/media_thumbnail_url_formatter -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_thumbnail_url_formatter -y
```

Once enabled, the **Thumbnail URL** format becomes available on the **Manage
display** tab for any media reference field. See
[How to use it](../index.md#how-to-use-it) on the overview page.
