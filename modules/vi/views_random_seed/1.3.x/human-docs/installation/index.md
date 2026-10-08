# Installation

## Requirements

Views random seed is lightweight and has no third-party libraries:

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Views** module (`views`) enabled — this is the core module the sort
  plugs into. It's part of Drupal core and is enabled on virtually every site.

There are no Composer or PHP library requirements. It works on MySQL/MariaDB and
PostgreSQL, and supports Search API views.

## Install with Composer

From the project root:

```bash
composer require drupal/views_random_seed -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/views_random_seed -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en views_random_seed -y
```

That's all it takes. The **Random seed** sort criterion is now available to add
to any view. See the [overview](../index.md#how-to-use-it) for how to add and
configure it inside the Views UI.
