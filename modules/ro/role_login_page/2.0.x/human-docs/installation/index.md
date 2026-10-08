# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- No third-party Composer or PHP libraries, and no other contrib dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/role_login_page -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/role_login_page -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en role_login_page -y
```

## Verify it worked

Log in as an administrator and go to **Configuration → Role login settings → Role
login settings list** (the `role_login_page.settings_list` route). If the list page
loads, the module is ready — continue to [Configuration](../configuration/index.md)
to add your first login page.
