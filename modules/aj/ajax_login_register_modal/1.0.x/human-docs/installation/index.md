# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement:
  ^8.8 || ^9 || ^10 || ^11`).
- No other modules — it has no dependencies. It uses core's user login,
  registration and password-reset forms.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/ajax_login_register_modal -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ajax_login_register_modal -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ajax_login_register_modal -y
```

## Set permissions

The module provides its own permission(s). After enabling, visit **People →
Permissions** (`/admin/people/permissions`) and grant them to the roles that
should be able to use the modal login/registration behavior.
