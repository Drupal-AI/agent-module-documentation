# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- No other module dependencies, and no third‑party Composer packages or PHP
  libraries.
- A Discord server whose **widget** feature is enabled (see Configuration) and
  whose **Server ID** you can copy.

## Install with Composer

From the project root:

```bash
composer require drupal/discord_widget -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/discord_widget -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en discord_widget -y
```

The module provides only a block plugin — enabling it does not change anything
visible until you place the block.

## Verify it worked

Go to **Structure → Block layout**, place the **Discord Widget** block in a region,
enter your Server ID (see [Configuration](../configuration/index.md)), and view a
front‑end page. You should see Discord's live server widget rendered where you
placed the block.
