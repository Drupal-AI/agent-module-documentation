# Installation

## Requirements

- **Drupal 10.4 or 11.1** (`core_version_requirement: ^10.4 || ^11.1`).
- Core's **Field** (`field`) and **System** (`system`) modules — hard
  dependencies, present on any standard Drupal site. Core's **Field UI** lets you
  pick the formatters on *Manage display*.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/formatter_suite -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/formatter_suite -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en formatter_suite -y
```

There are no submodules. Once enabled, the new formatters appear in the **Format**
options on any field's *Manage display* tab (and in Views) — see
[How to use it](../index.md#how-to-use-it).
