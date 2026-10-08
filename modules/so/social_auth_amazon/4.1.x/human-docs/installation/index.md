# Installation

## Requirements

Social Auth Amazon needs:

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ^9.5||^10||^11`).
- The **Social Auth** module (`social_auth`), which in turn builds on the Social
  API framework. Composer pulls this in for you.

There are no PHP extension or third‑party library requirements. Version 4.0.0 and
above implements the 4.x line of Social Auth, so make sure your Social Auth base
module is on a compatible 4.x release.

## Install with Composer

From the project root:

```bash
composer require drupal/social_auth_amazon -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install and update Social
Auth and the Social API dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/social_auth_amazon -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en social_auth_amazon -y
```

Drupal enables the Social Auth and Social API dependencies at the same time if
they are not already on.

## Next step

Login will not work until you register an Amazon application and enter its
credentials — continue to [Configuration](../configuration/index.md).
