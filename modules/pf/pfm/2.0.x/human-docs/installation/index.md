# Installation

## Requirements

Permissions filtered by modules is a lightweight administration tool. It needs:

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8.0 || ^9.0 || ^10 || ^11`).

It has **no module dependencies** and no third-party Composer or PHP library requirements. The
**Permissions Dragcheck** module (`permissions_dragcheck`) is optional — if it's present, its
drag-to-check behavior is applied to the filtered grid automatically, but it isn't required.

## Install with Composer

From the project root:

```bash
composer require drupal/pfm -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/pfm -W`, `ddev drush …`. Inside the container
> (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en pfm -y
```

That's all it takes. A new **PFM Permissions** page appears under **People**
(`/admin/people/pfm-permissions`) for users with the *Administer permissions* permission. There
is no configuration step — the filtered page itself is the whole feature. See the
[overview](../index.md#how-to-use-it) for how to use the filters.

There are no submodules.
