# Installation

## Requirements

- **Drupal 9 or newer** (`core_version_requirement: >=9`, `drupal/core: >=9`).
- **PHP 7.4 or newer**.
- Core's **Field** and **Field UI** modules (part of core) if you want to assign
  the widget through the UI. The control only makes sense for **integer** fields.

There are no third‑party Composer packages or other module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/unlimited_number -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/unlimited_number -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en unlimited_number -y
```

Once enabled, the **Unlimited or Number** widget becomes available on integer
fields' **Manage form display**, and the `#type => unlimited_number` render
element is available to custom forms. See
[How to use it](../index.md#how-to-use-it) on the overview page.

There are no submodules.
