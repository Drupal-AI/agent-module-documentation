# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- Core's **Views** module enabled (it is part of the standard install).
- No third-party Composer or PHP libraries.

The **Token** module (`drupal/token`) is an optional suggestion — it enables a
token browser on the fallback-value fields of the argument plugins, but is not
required.

## Install with Composer

From the project root:

```bash
composer require drupal/views_extras -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/views_extras -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en views_extras -y
```

Once enabled, the new contextual-filter default-value types and the **Extra Result
summary** area handler appear automatically inside the Views UI — there is no
further setup. See the [overview](../index.md#how-to-use-it) for how to use them.
