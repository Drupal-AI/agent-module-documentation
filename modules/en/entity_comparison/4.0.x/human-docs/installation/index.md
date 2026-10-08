# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).

There are no other module dependencies and no third‑party Composer or PHP library
requirements. (The module uses core's Field, Views, and Block subsystems, all part
of a standard Drupal install.)

## Install with Composer

From the project root:

```bash
composer require drupal/entity_comparison -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/entity_comparison -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_comparison -y
```

Enabling the module adds the **Entity comparison** admin section but creates no
comparison yet. Head to [Configuration](../configuration/index.md) to create your
first one.

> **Tip:** each time you add a new comparison, rebuild caches (`drush cr`) so its
> page route and generated permission become available.

## Verify it worked

Go to **Structure → Entity comparison**
(`/admin/structure/entity_comparison`). If the (initially empty) comparison list
page loads with an **Add** button, the module is installed correctly.
