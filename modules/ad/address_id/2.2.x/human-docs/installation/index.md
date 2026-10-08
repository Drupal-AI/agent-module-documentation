# Installation

## Requirements

- **Drupal 9.1, 10, or 11** (`core_version_requirement: ^9.1 || ^10 || ^11`).
- The **Address** module (`address`) enabled — a required dependency, and the field
  this module extends. Composer pulls it in automatically.

There are no third-party Composer or PHP library requirements, and no external
services — the Indonesian province/city list is built into the module.

## Install with Composer

From the project root:

```bash
composer require drupal/address_id -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including the `address` dependency.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/address_id -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en address_id -y
```

That's the whole setup. There's no configuration page. Edit an entity with an
Address field, set the country to **Indonesia**, and the province and city selects
appear.
