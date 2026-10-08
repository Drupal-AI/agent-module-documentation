# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Editor** (`editor`) and **Filter** (`filter`) modules — both are part of Drupal
  core and are enabled automatically as dependencies.
- A **Bootstrap-based theme** (or one that provides the Bootstrap `table-*` CSS classes) for
  the styling to actually show. The filter adds the classes; your theme supplies the look.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/table_bs_filter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host machine —
> `ddev composer require drupal/table_bs_filter -W`, `ddev drush …`. Inside the container
> (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en table_bs_filter -y
```

Enabling the module registers the filter but does not turn it on anywhere. Next, enable and
tune it on a text format — see **How to use it** in the [overview](../index.md).
