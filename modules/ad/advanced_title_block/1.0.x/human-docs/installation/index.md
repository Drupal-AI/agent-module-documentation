# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Drupal core's **Block** (`block`) and **Image** (`image`) modules. Both are part
  of core, and Drupal enables them automatically as dependencies.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/advanced_title_block -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/advanced_title_block -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en advanced_title_block -y
```

Once enabled, the **Advanced Page Title Block** is available to place under
**Structure → Block layout**. All of its options are set in the block's own
configuration form — see the [overview](../index.md#how-to-use-it) for how to
place and configure it.
