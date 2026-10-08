# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core **Block** (`block`), **System** (`system`), and **Toolbar** (`toolbar`)
  modules — all enabled automatically as dependencies. The Toolbar module is what
  carries the "Place block" button.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/block_place -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/block_place -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en block_place -y
```

## That's the whole setup

There is nothing to configure and no permission to add — the feature uses core's
**Administer blocks** permission. Browse to a front-end page as a user who has it and
you'll see the **Place block** button in the admin toolbar. See the
[overview](../index.md#how-to-use-it) for how to use it.
