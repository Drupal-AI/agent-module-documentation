# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Toolbar** (`toolbar`) and **User** (`user`) modules — Drupal enables
  these automatically as dependencies.
- *Optional:* [Admin Toolbar](https://www.drupal.org/project/admin_toolbar) and/or
  Gin Toolbar — Admin Menu Swap integrates with them (menu depth, active trail) if
  they are present, but neither is required.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/amswap -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/amswap -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en amswap -y
```

Enabling the module changes nothing on its own — until you create at least one
role‑menu pair, every role keeps the default administration menu. Head to
[Configuration](../configuration/index.md) to set up your pairs.

## Verify it worked

Visit `/admin/config/amswap` as a user with the **Administer amswap** permission.
You should see the **Admin Menu Swap** configuration form with a first role‑menu
pair ready to fill in.
