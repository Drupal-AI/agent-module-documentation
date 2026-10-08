# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Field** (`field`) and **Views** (`views`) modules, both part of core.
  Views is enabled on the standard profile; if it is off, Drupal enables it as a
  dependency.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_reference_views_select -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/entity_reference_views_select -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_reference_views_select -y
```

That is all the setup there is. The two widgets are now available in the widget
dropdown on any bundle's **Manage form display**. This module has no submodules,
no permissions, and no settings page — see the module overview for how to assign
the widgets to a field.
