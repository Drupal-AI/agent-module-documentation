# Installation

## Requirements

- **Drupal 9.3 or 10** (`core_version_requirement: ^9.3 || ^10`).
- Core's **Block** module (`block`) enabled — Drupal pulls it in as a dependency.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/alter_blocks_element_markup -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/alter_blocks_element_markup -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en alter_blocks_element_markup -y
```

Once enabled, the wrapper/markup options appear on each block's configuration form
under **Structure → Block layout** — see
[How to use it](../index.md#how-to-use-it).
