# Installation

## Requirements

- **Drupal 10, 11, or 12** (`core_version_requirement: ^10 || ^11 || ^12`).
- **PHP 8.1** or newer.
- The **Basket** online-store module (`basket`) — this is the store the
  integration plugs into. It is *not* a Drupal Commerce module.
- Core **Views** (`views`), which Drupal enables by default.

There are no extra third-party Composer libraries to install.

## Install with Composer

From the project root, require the project by its drupal.org name:

```bash
composer require drupal/basket_novaposhta -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/basket_novaposhta -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Watch the name change here — the project is `basket_novaposhta` but the module you
enable is `novaposhta`:

```bash
drush en novaposhta -y
```

Make sure the `basket` module is present and enabled first, since Nova Poshta
depends on it.

## After enabling

Head to [Configuration](../configuration/index.md) to enter your Nova Poshta API
credentials, then run the shipped console command(s) to download the city and
warehouse reference data (`drush list | grep -i novaposhta` lists them).
