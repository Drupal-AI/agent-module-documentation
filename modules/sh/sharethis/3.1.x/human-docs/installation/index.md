# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11.0`).
- No other module dependencies and no third-party Composer or PHP libraries.

One thing to be aware of: the share buttons are rendered by ShareThis's hosted
JavaScript, loaded from `sharethis.com`. The module needs the visitor's browser to
be able to reach that service for the live buttons to appear.

## Install with Composer

From the project root:

```bash
composer require drupal/sharethis -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/sharethis -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sharethis -y
```

Out of the box the module ships defaults that place share buttons on the **Article**
and **Page** content types. Log in as an administrator (or grant the *Administer
Sharethis* permission at `/admin/people/permissions`) and view an article to see
them. To change which content types, services, or placement mode are used, go to
[Configuration](../configuration/index.md).

There are no submodules to enable.
