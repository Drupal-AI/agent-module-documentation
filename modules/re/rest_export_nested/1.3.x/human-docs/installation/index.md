# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- Core's **REST** (`rest`) and **Views** (`views`) modules — Drupal enables these
  as dependencies.
- Optional but common: the contributed **Views Field View** (`views_field_view`)
  module, if you want to embed a child view's rows as nested JSON.

There are no third‑party Composer packages or PHP libraries to install.

## Install with Composer

From the project root:

```bash
composer require drupal/rest_export_nested -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/rest_export_nested -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en rest_export_nested -y
```

Enabling the module also enables core REST and Views if they aren't already on.
There is no configuration page — the **REST export nested** display becomes
available inside the Views UI. See the [overview](../index.md#how-to-use-it) for
building a nested feed.
