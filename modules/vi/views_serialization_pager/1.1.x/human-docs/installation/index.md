# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- Core's **Serialization** (`serialization`) and **Views** (`views`) modules —
  both required and enabled as dependencies. You will also want core's **RESTful
  Web Services** enabled so REST Export displays are available.
- There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/views_serialization_pager -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/views_serialization_pager -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en views_serialization_pager -y
```

## After enabling

There is no configuration form. The new **Serialization with Pager** format
appears automatically in the Views UI on REST Export displays — see the
[main guide](../index.md) for how to switch a view to it.
