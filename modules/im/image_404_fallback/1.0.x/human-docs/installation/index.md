# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3||^11`).

There are no third-party Composer or library requirements.

> **Note:** this module is not currently covered by Drupal's security advisory
> policy. Weigh that as you would for any not-covered contrib module before using it
> on a production site.

## Install with Composer

From the project root:

```bash
composer require drupal/image_404_fallback -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/image_404_fallback -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en image_404_fallback -y
```

That is all it takes — the module works immediately using its built-in default
placeholder image. There is no required configuration.

## Verify it worked

Request an image URL that does not exist on your site (for example, an image path
you know has been deleted). Instead of a 404 or a broken-image icon, you should see
the fallback placeholder returned. To use your own image instead of the built-in
default, see [Configuration](../configuration/index.md).
