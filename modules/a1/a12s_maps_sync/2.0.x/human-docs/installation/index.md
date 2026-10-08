# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Content Translation** module (`content_translation`) enabled — this
  is a dependency, so Drupal enables it automatically, and it underpins the
  multilingual sync.
- Access to a **MaPS System** instance and valid **API credentials** for it.

There are no third-party Composer or PHP library requirements declared.

## Install with Composer

From the project root:

```bash
composer require drupal/a12s_maps_sync -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/a12s_maps_sync -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en a12s_maps_sync -y
```

Enabling it also enables Content Translation if it is not already on. Before the
sync can do anything you must give it your MaPS System connection details — see
[Configuration](../configuration/index.md), and store the credentials as
secrets.
