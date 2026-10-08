# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- Core's **User** and **Node** modules (both part of a standard install) — you need
  at least one node to hold your terms text.
- No third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/terms_of_use -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/terms_of_use -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en terms_of_use -y
```

Enabling the module does not change the registration form yet — you must point it at
a terms node and set the labels first. See
[Configuration](../configuration/index.md) for the full setup checklist.
