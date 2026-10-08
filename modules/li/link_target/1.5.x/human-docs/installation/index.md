# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Link** module (`link`), which ships with Drupal. Enable it if it isn't
  already on — Composer/Drush handle it as a dependency.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/link_target -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/link_target -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en link_target -y
```

There is no configuration page and no permissions to grant. To start using it,
switch a Link field to the **Link with target** widget on its *Manage form display*
tab — see the [main guide](../index.md#how-to-use-it).
