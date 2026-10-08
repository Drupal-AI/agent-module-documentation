# Installation

## Requirements

- **Drupal 10.3, 11, or 12** (`core_version_requirement: ^10.3 || ^11 || ^12`).
- Core's **Block** module (enabled on standard installs) so you have blocks to
  configure.
- No other Drupal modules are required. It works with core system menu blocks out
  of the box, and also recognizes blocks from the contrib **Menu Block** module
  if you use it.

## Install with Composer

From the project root:

```bash
composer require drupal/menu_block_title -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/menu_block_title -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en menu_block_title -y
```

Once enabled, the **"Block title as menu link parent"** checkbox appears on the
configuration form of any menu block. See the [overview](../index.md) for how to
turn it on for a block.
