# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).

There are no module dependencies and no external library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/bartik_admin -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/bartik_admin -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en bartik_admin -y
```

There is no site-wide configuration screen. To switch an account to the Bartik
admin theme, visit **`/user/{user}/bartik-admin`** for that user and opt in — see
[How to use it](../index.md#where-it-lives--how-to-use-it). The route is
restricted to the `administrator` role plus a custom access check.
