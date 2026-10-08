# Installation

## Requirements

- **Drupal 8.8, 9, or 10** (`core_version_requirement: ^8.8 || ^9 || ^10`).
- Permission for PHP to change the memory limit at runtime on your web server —
  the module applies limits via `ini_set('memory_limit', …)`, which has no effect
  if your PHP build or host disallows it.
- No third-party Composer or PHP libraries, and no other contrib dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/role_memory_limit -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/role_memory_limit -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en role_memory_limit -y
```

## Verify it worked

Log in as an administrator and go to **Configuration → System → Role memory limit**
(`/admin/config/system/role-memory-limit`). If the form loads and lists your roles,
the module is ready — continue to [Configuration](../configuration/index.md) to set
the limits.
