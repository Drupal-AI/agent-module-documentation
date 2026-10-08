# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Layout Discovery** module (`layout_discovery`) enabled — this is the
  only dependency, and Drupal enables it automatically when you turn on this
  module. (Layout Discovery is also what Layout Builder and Display Suite build
  on, so it is usually already enabled.)

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/layout_disable -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/layout_disable -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en layout_disable -y
```

Enabling the module changes nothing until you actually disable a layout on its
settings form. Continue to [Configuration](../configuration/index.md).
