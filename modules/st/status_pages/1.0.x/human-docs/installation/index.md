# Installation

## Requirements

Status Pages needs only **Drupal 9, 10, or 11** (`core_version_requirement:
^9 || ^10 || ^11`). There are no additional modules, third-party Composer packages,
or PHP libraries required.

## Install with Composer

From the project root:

```bash
composer require drupal/status_pages -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/status_pages -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en status_pages -y
```

## After installing

Two quick steps finish the setup:

1. Configure the page texts at `/admin/config/system/status-pages-settings`.
2. On **Basic site settings** (`/admin/config/system/site-information`), set the
   403 and 404 pages to `/page-403` and `/page-404`.

See [Configuration](../configuration/index.md).
