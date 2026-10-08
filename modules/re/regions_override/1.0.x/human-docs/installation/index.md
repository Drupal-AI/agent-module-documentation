# Installation

## Requirements

Regions Override needs:

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).

There are no other module, Composer, or PHP library dependencies. It pairs
naturally with core's **Layout Builder**, but that is not required.

> **Note:** version 1.0.x is currently an alpha release. Test it on a non-production
> environment before rolling it out.

## Install with Composer

From the project root:

```bash
composer require drupal/regions_override -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/regions_override -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en regions_override -y
```

If the override options don't appear right away, clear the cache
(`drush cr`).

## Verify it worked

Go to **People → Permissions** and confirm the Regions Override permission appears,
then open a theme's settings (**Appearance → Settings**) and check for the region
groupings. Follow [Configuration](../configuration/index.md) for the full setup.
