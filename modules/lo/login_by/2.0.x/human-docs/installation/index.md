# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- No third‑party libraries and no other module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/login_by -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/login_by -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en login_by -y
```

## Verify it worked

Go to **Configuration → User interface → Login By**
(`/admin/config/user-interface/login_by`). If the settings form loads, the module
is installed. Choose your accepted identifier (see
[Configuration](../configuration/index.md)), save, then confirm the login form
behaves as expected — for example, that you can sign in with an email address if
you enabled email login.
