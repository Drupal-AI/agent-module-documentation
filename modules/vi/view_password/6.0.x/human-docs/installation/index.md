# Installation

## Requirements

View Password is lightweight:

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- No dependencies outside Drupal core, and no third‑party PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/view_password -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from your
> host machine — `ddev composer require drupal/view_password -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en view_password -y
```

The moment it's enabled, the default user login form gets the show/hide eye toggle
next to its password field. To add the toggle to other forms, continue to
[Configuration](../configuration/index.md).
