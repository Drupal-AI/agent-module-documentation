# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- No other module dependencies, and no third‑party Composer or PHP library
  requirements. The module carries essentially no config or schema overhead.

## Install with Composer

From the project root:

```bash
composer require drupal/null_user -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/null_user -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en null_user -y
```

That is all — there is no configuration step. The `NullUser` class is now
available for your custom code to use.

## Verify it worked

There is no UI to check, since the module is a utility class. Confirm it is
enabled (`drush pml --status=enabled | grep null_user`), then use the class from
code as shown on the [overview page](../index.md) — for example, verify that
`(new \Drupal\null_user\NullUser())->id()` returns `NULL` and
`hasPermission('any permission')` returns `FALSE`.
