# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Node** (`node`) and **Field** (`field`) modules — Drupal enables these
  automatically as dependencies when you turn on Round Linking.
- Core's **Views** module is used for the setup (it is part of standard Drupal
  installs).

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/round_linking -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/round_linking -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en round_linking -y
```

## Verify it worked

Go to **Structure → Views** and edit a View. When you add a handler, the Round
Linking option provided by this module should be available. If it appears, the
module is installed correctly — see "How to use it" on the
[overview page](../index.md) to build your circular linking block.
