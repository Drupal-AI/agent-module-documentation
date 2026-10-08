# Installation

## Requirements

- **Drupal 8.9, 9, 10, or 11** (`core_version_requirement: ^8.9 || ^9 || ^10 || ^11`).
- Core's **User** and **Views** modules, both part of a standard Drupal install.
  Drupal enables them automatically as dependencies.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/legal -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/legal -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en legal -y
```

You can also enable it from **Extend** (`/admin/modules`).

## What happens next

Enabling the module adds the admin pages and the public `/legal` page, but no terms
exist yet, so nothing appears on the registration form until you enter your T&C
text. Head to [Configuration](../configuration/index.md) to write your terms and
choose how they are displayed. If you are migrating from a Drupal 7 Legal site, the
module bundles migrations that can bring your old terms and acceptance records
across.
