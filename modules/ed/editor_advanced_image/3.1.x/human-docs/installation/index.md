# Installation

## Requirements

- **Drupal 10.5 or 11.2** (`core_version_requirement: ^10.5 || ^11.2`).
- Core's **CKEditor 5** (`ckeditor5`) and **Text Editor** (`editor`) modules,
  which Drupal enables automatically as dependencies.
- Each text format you use it on must use CKEditor 5 and have the core **Image**
  CKEditor 5 plugin active on its toolbar — the advanced‑image plugin depends on
  it and will not load otherwise.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/editor_advanced_image -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/editor_advanced_image -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en editor_advanced_image -y
```

There are no submodules and no standalone settings page. Configuration is done
per text format — see the [overview](../index.md) for how to enable and configure
it on a CKEditor 5 format.
