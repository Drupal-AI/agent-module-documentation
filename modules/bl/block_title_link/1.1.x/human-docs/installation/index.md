# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Block** module (`block`) enabled — this is the only dependency and is part
  of the standard install. (The module also uses core's Link widget for URL
  validation, which is available with core.)

There are no third‑party Composer or PHP library requirements, and no permissions of
its own — it inherits the standard **administer blocks** permission.

## Install with Composer

From the project root:

```bash
composer require drupal/block_title_link -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/block_title_link -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en block_title_link -y
```

There are no submodules and no configuration form. Once enabled, edit any block and
you'll find the **Block Title Link Settings** section in its advanced options — see
the [main guide](../index.md#how-to-use-it).
