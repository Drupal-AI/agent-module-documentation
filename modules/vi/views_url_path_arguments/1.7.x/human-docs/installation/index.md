# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Path Alias** (`path_alias`) and **Views** (`views`) modules — both
  ship with Drupal and are enabled automatically as dependencies.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/views_url_path_arguments -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/views_url_path_arguments -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en views_url_path_arguments -y
```

Nothing appears in the admin menu — the module simply makes two new options
available on Views contextual filters. See the main guide for how to select them
on a view.
