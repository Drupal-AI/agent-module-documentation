# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Views** module (`views`) enabled — this is the only dependency, and it
  is part of Drupal core.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/other_view_filter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/other_view_filter -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en other_view_filter -y
```

That's all. There is no settings form to visit — the new **Other view result**
filter is now available inside the Views editor. See the
[overview](../index.md#how-to-use-it) for how to add it to a view.

There are no submodules.
