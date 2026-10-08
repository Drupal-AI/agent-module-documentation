# Installation

## Requirements

- **Drupal 8 or 9** (`core_version_requirement: ^8 || ^9`; the Composer
  constraint allows up to ^10).
- Core's **Field** module (`field`) — enabled by default in a standard install;
  it is the only dependency.
- A **Bootstrap‑style front‑end theme** to actually apply the classes the module
  stores (not a hard requirement to install, but the module is only useful with
  one).

There are no third‑party Composer or PHP library requirements.

## Install with Composer

Note the misspelled package name (`boostrap`, missing a **t**) — it must be typed
exactly:

```bash
composer require drupal/boostrap_layout_classes -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/boostrap_layout_classes -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en boostrap_layout_classes -y
```

There are no submodules. Once enabled, choose its widget and formatter on a
field — see the [overview](../index.md#how-to-use-it).
