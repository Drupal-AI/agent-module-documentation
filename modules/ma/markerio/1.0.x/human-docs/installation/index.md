# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- A **Marker.io account** with a project and an active subscription — you'll need
  the project's key to configure the module.

There are no other Drupal module dependencies and no third‑party PHP libraries;
the widget's JavaScript is served by Marker.io.

## Install with Composer

From the project root:

```bash
composer require drupal/markerio -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/markerio -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en markerio -y
```

Once enabled, head to [Configuration](../configuration/index.md) to enter your
project key and grant the permissions — the widget won't load until both are in
place.
