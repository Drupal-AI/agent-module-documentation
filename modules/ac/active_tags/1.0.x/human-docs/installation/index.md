# Installation

## Requirements

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ^9.5 || ^10 || ^11`).
- Core's **Field** (`field`) and **Taxonomy** (`taxonomy`) modules — both are
  dependencies. Field is enabled on standard installs; Drupal enables both
  automatically as dependencies when you turn on Active Tags.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/active_tags -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/active_tags -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en active_tags -y
```

There is no configuration form. To use the widget, switch a free-tagging field to
the **Active Tags** widget under **Manage form display** — see the
[main guide](../index.md#how-to-use-it) for the steps.
