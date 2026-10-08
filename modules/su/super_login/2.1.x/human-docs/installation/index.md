# Installation

## Requirements

Super Login is self-contained:

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- No third-party Composer or PHP library requirements, and no other contrib
  modules. It only alters core's user forms, so core's **User** module (always
  present) is all it needs.

## Install with Composer

From the project root:

```bash
composer require drupal/super_login -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/super_login -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en super_login -y
```

The module takes effect immediately: reload `/user/login` and you should already
see its tidied-up form (the login/reset tabs removed, wider inputs). Head to the
settings form to customise it — see [Configuration](../configuration/index.md).

## Verify it worked

Log in as an administrator and open **Configuration → People → Super Login
Settings** (`/admin/config/people/super_login/settings`). If the settings form
loads, the module is installed and ready to configure.
