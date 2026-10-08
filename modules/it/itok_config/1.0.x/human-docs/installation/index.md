# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Image** module (`image`), which is part of a standard Drupal install.

> **Note:** this module is **abandoned/obsolete**. The maintainer recommends
> [Image Derivative Token](https://www.drupal.org/project/image_derivative_token)
> for new work. Install Itok Config only if you have an existing reason to.

## Install with Composer

From the project root:

```bash
composer require drupal/itok_config -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/itok_config -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en itok_config -y
```

## Verify it worked

Go to **Configuration → Media → Image styles** (`/admin/config/media/image-styles`)
and click **Edit** on any image style. The edit form should now include an option to
disable the `itok` token for that style — see [Configuration](../configuration/index.md).
