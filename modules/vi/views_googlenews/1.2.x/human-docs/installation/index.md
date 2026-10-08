# Installation

## Requirements

Views Google News is lightweight. It needs:

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Views** module (`views`) enabled — this is the only dependency, and
  Views ships with Drupal core (it is usually already on).

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require md-systems/views_googlenews -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require md-systems/views_googlenews -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en views_googlenews -y
```

If Views is not already enabled, Drupal turns it on automatically as a
dependency.

That is all the setup the module needs. There is no configuration form — the
next step is to build a View, add a Feed display, and pick the "Google News Feed"
format, as described in the [overview](../index.md#how-to-use-it).
