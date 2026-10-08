# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Drupal's core menu system, which is always present. There are no third-party
  Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/advanced_menu_condition -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/advanced_menu_condition -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en advanced_menu_condition -y
```

Once enabled, the new menu-trail condition is available immediately in every
block and Layout Builder visibility form. There is no configuration page to
visit — see the [overview](../index.md#how-to-use-it) for how to apply the
condition to a block.
