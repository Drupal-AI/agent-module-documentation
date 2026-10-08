# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`; Composer
  requires `drupal/core: ^10.1 || ^11.0`).
- Core's **Views** module (`views`) enabled — this is the only module dependency,
  and it's part of core. Drupal enables it automatically if needed.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/config_views -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/config_views -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en config_views -y
```

There are no submodules. Note that enabling the module installs several ready-made
Views, some of which **take over core admin listing pages** immediately (for
example Content types and Image styles). If you'd rather keep core's original
lists, you can disable those Views at **Structure → Views**. After enabling, the
**Configuration** group appears in the **Add view** wizard — see the
[main page](../index.md) for how to build and enable config-entity Views.
