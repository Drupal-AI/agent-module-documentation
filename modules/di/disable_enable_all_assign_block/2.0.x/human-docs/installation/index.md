# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- Core's **Block** module (`block`) enabled — this is the only dependency, and it is
  part of core.

There are no PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/disable_enable_all_assign_block -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/disable_enable_all_assign_block -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en disable_enable_all_assign_block -y
```

## Verify it worked

Visit `/admin/config/disable_enable_all_assign_block` (you'll need the **Administer
site configuration** permission). You should see the module's page with the region
options for your default theme. See [Configuration](../configuration/index.md) for
how to use the toggle.
