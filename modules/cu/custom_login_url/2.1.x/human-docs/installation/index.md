# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **User** module (`user`), which is always enabled — the only dependency.

There are no third-party libraries and no Composer dependencies of its own.

## Install with Composer

From the project root:

```bash
composer require drupal/custom_login_url -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/custom_login_url -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en custom_login_url -y
```

## After enabling

Enabling the module alone changes nothing — the default path pattern is the
unchanged `/user/`. You must set your secret path in `settings.php` and rebuild the
route cache. Head to [Configuration](../configuration/index.md).
