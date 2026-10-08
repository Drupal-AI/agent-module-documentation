# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- The **Gin Toolbar** module (`gin_toolbar`) — this is a declared dependency, and it
  in turn relies on the **Gin** admin theme. Drupal enables `gin_toolbar` for you
  when you turn on Sector Tonic; make sure the Gin theme is installed and available.

There are no third-party PHP library or Composer requirements beyond that.

## Install with Composer

From the project root:

```bash
composer require drupal/sector_tonic -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. (The module's own project page mentions
`composer install drupal/sector_tonic`, but `composer require` is the correct command
to add it to a site.)

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/sector_tonic -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sector_tonic -y
```

You can also enable it from **Extend** (`/admin/modules`) in the UI. Enabling it sets
Gin as the admin theme and brings in the Gin Toolbar (and Gin Login where available).

## Verify it worked

Log in as an administrator and open any admin page. You should see the Gin admin
theme and its toolbar in place, with Sector Tonic's editorial refinements applied.
There is no settings form to visit — the module works out of the box.
