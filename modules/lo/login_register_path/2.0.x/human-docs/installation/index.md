# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- No third‑party libraries and no other module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/login_register_path -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/login_register_path -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en login_register_path -y
```

## Verify it worked

Go to **Configuration → User interface → Login Register Path**
(`/admin/config/user-interface/login-register-path`). Set a custom login and/or
register path (see [Configuration](../configuration/index.md)), save, then visit the
new path to confirm the login or register form appears there.
