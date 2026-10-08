# Installation

## Requirements

- **Drupal 8.8, 9, or 10** (`core_version_requirement: ^8.8 || ^9 || ^10`).
- Core's **Media** module (`media`).

This module requires no modules outside of Drupal core. There are no third-party
Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/media_title_length -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/media_title_length -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_title_length -y
```

## Verify it worked

Go to **Configuration → Media → Media Title Length settings** (`/admin/mtl/config`)
and confirm the settings form loads. Setting a new length there and saving is what
actually applies the change — see [Configuration](../configuration/index.md).
