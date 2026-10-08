# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **System** module (`system`), which is always present. There are no
  other module dependencies.

There are no third-party Composer packages or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/pages_restriction -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/pages_restriction -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en pages_restriction -y
```

Nothing is restricted until you configure at least one restricted/target page
pair. Head to [Configuration](../configuration/index.md) to set up your rules.

## Permission

Pages Restriction Access adds no permission of its own. The settings form is
gated by core's **Administer site configuration**
(`administer site configuration`) permission, which administrators already have.

This module ships no submodules.
