# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **CKEditor 5** module (`ckeditor5`) and core's **Layout Discovery**
  module (`layout_discovery`) — both are required dependencies and Drupal
  enables them automatically.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/ckeditor_layouts -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ckeditor_layouts -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ckeditor_layouts -y
```

The module ships no submodules and has no standalone settings page. To start
using it, add the **Insert layout** button to a CKEditor 5 text format's toolbar
— see the [overview](../index.md#how-to-use-it) for the full walkthrough.
