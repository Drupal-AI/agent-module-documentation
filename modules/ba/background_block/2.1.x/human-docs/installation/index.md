# Installation

## Requirements

- **Drupal 8.9, 9, 10 or 11** (`core_version_requirement: ^8.9 || ^9 || ^10 || ^11`).
- Core's **Block** module (`block`) — Drupal enables it automatically as a dependency.

There are no third‑party Composer or PHP library requirements declared.

## Install with Composer

From the project root:

```bash
composer require drupal/background_block -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/background_block -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en background_block -y
```

There's no settings page to visit — the background‑colour option appears on each
block's own configuration form. See the *How to use it* section on the
[overview page](../index.md). Grant the module's permission to the roles that configure
blocks.
