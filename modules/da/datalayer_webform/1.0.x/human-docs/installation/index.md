# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- The **[Webform](https://www.drupal.org/project/webform)** module
  (`drupal/webform ^6.0 || ^5.0`) — Composer pulls this in for you.
- The **[Datalayer](https://www.drupal.org/project/datalayer)** module, which
  provides and initializes the browser‑side `dataLayer` array. Enable it too, or the
  event has nothing to push into.

## Install with Composer

From the project root:

```bash
composer require drupal/datalayer_webform -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update Webform and any other
shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/datalayer_webform -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en datalayer_webform -y
```

Make sure both **Datalayer** and **Webform** are enabled as well (Webform is a hard
dependency, so Drupal enables it automatically; enable **Datalayer** yourself if it
isn't already):

```bash
drush en datalayer webform -y
```

There are no submodules. Next, open a webform and add the handler — see
[Configuration](../configuration/index.md).
