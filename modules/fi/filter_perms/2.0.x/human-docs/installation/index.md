# Installation

## Requirements

- **Drupal 10.3, 11, or 12** (`core_version_requirement: ^10.3 || ^11 || ^12`).
- Core's **User** module (`user`) — a hard dependency, and always enabled on a
  Drupal site.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/filter_perms -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/filter_perms -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en filter_perms -y
```

There is no configuration form and no new permission — the module reuses core's
*Administer permissions*. Once enabled, the **Permission Filters** section
appears at the top of the permissions page. See the [overview](../index.md) for
how to use it.
