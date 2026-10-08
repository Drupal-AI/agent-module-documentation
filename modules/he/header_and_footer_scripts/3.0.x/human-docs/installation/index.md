# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- **PHP 7.4 or newer** (`^7.4 || ^8.0 || ^8.1 || ^8.2 || ^8.3`).

There are no other module dependencies and no third-party Composer or PHP library
requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/header_and_footer_scripts -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/header_and_footer_scripts -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en header_and_footer_scripts -y
```

## Grant the permission

Because the module injects arbitrary scripts site-wide, the three forms are gated by
the restricted **"Add Scripts all over the site"** permission. Grant it only to
trusted administrator roles at **People → Permissions**
(`/admin/people/permissions`, filter for Header and Footer Scripts). Then head to
[Configuration](../configuration/index.md) to add your scripts.
