# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- No module dependencies. The module bundles its own small CSS/JS and relies on
  core's jQuery, which core provides.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/password_eye -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/password_eye -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en password_eye -y
```

On install the module sets its one configuration value to `user_login_form`, so
the eye icon appears on the login form immediately. To enable it on other forms,
see [Configuration](../configuration/index.md).
