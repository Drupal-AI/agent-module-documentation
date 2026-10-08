# Installation

## Requirements

- **Drupal 8 or newer** (`core_version_requirement: >=8`); the 2.2.x line targets
  current Drupal 10/11.
- A number of **dependent modules**, which Composer and Drush pull in for you:
  `key_auth`, `rest`, `serialization`, core `jsonapi`, `eva`, `options`, and
  `field_ui`, plus **Admin Toolbar Extra Tools** (`admin_toolbar_tools`) for the
  toolbar status indicator.

There are no extra PHP libraries to install, but because of the dependency list this
is a heavier install than a stand-alone utility module — expect Composer to add
several packages.

## Install with Composer

From the project root:

```bash
composer require drupal/site -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — important here, since Site depends on several other
contributed modules.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/site -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en site -y
```

Drush enables the dependencies automatically. If you enable through the UI at
**Extend** (`/admin/modules`) instead, tick Site and confirm when Drupal offers to
turn on the required modules.

## Verify it worked

Log in as an administrator. You should see a **site-status indicator in the admin
toolbar**, and visiting **`/admin/site/about`** should show the Site entity's status
page with the collected properties (Drupal version, PHP version, install time, and so
on). From there, continue to [Configuration](../configuration/index.md) to choose your
state handlers and, optionally, set up remote reporting.
