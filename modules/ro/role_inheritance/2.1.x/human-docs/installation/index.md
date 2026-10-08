# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No third-party Composer or PHP libraries, and no other contrib module
  dependencies — it builds on core's user/permission system.

## Install with Composer

From the project root:

```bash
composer require drupal/role_inheritance -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/role_inheritance -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en role_inheritance -y
```

## Verify it worked

Log in as an administrator and open the Role Inheritance configuration form (the
`role_inheritance.config_role_inheritance` route). If it loads and lists your
roles, the module is ready — continue to [Configuration](../configuration/index.md)
to define the inheritance relationships.
