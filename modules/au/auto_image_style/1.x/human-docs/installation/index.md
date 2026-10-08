# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- Core's **Responsive Image** module (`responsive_image`) enabled — the only
  dependency, enabled automatically.

There are no third-party Composer library requirements. Note the packaged release
is a **dev** version — test it before relying on it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/auto_image_style -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/auto_image_style -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en auto_image_style -y
```

After enabling, make sure you have an image style for each orientation and map
them so the right crop is applied per shape — see the "How to use it" section of
the [overview](../index.md).
