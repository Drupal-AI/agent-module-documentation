# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No hard module dependencies and no third-party PHP libraries. Endpoints use
  Drupal's core REST framework and routing.

There are no additional PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/miniorange_custom_api -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/miniorange_custom_api -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en miniorange_custom_api -y
```

## Verify it worked

Log in as an administrator and open the module's admin pages (under the miniOrange
section of the admin menu). You should be able to start defining a custom API
endpoint. Before exposing any real data, read
[Configuration](../configuration/index.md) — especially the access and
authentication guidance.
