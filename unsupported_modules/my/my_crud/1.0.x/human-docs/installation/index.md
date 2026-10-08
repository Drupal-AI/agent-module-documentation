# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- No other modules, PHP extensions, or third‑party libraries are required.

## Install with Composer

Note that the Composer package name differs from the module's machine name — the
project is published as `basic_crud_operation_in_drupal_sites`, while the module
you enable is `my_crud`. From the project root:

```bash
composer require drupal/basic_crud_operation_in_drupal_sites -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/basic_crud_operation_in_drupal_sites -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en my_crud -y
```

Enabling the module runs its `hook_schema` and creates the `my_crud` table
(`id`, `name`, `age`) in your database.

## Verify it worked

Visit **`/my_crud`** while logged in. You should see the (initially empty)
records table. As user 1 you can then open `/my_crud/form/data` to add a record
and watch it appear in the listing. Because this is example code, keep it on a
development site rather than a production one.
