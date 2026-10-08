# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **PHP 5.6 or newer** (`php_requirement: >=5.6.0`) — effectively any PHP version
  your supported Drupal core already runs on.
- No contrib dependencies — it uses only Drupal core's user registration form.

## Install with Composer

From the project root:

```bash
composer require drupal/reg_confirm_email -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/reg_confirm_email -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en reg_confirm_email -y
```

Enabling the module does **not** turn the confirm field on by default — you must
tick it on the account settings page. See [Configuration](../configuration/index.md).
