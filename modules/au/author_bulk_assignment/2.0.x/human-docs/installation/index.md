# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Views** module (`views`) enabled — this is the only dependency, since
  the feature is delivered as a Views bulk operation. Drupal enables it
  automatically as a dependency.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/author_bulk_assignment -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/author_bulk_assignment -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en author_bulk_assignment -y
```

Once enabled, the bulk operation becomes available on Views of content. See
[Configuration](../configuration/index.md) for the permissions to grant and how
to run it.
