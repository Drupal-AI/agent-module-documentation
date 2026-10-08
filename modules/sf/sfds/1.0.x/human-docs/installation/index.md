# Installation

## Requirements

- **Drupal 10.2, or 11** (`core_version_requirement: ^10.2||^11`).
- No other contrib modules, PHP libraries or third-party Composer packages are
  required.

## Install with Composer

From the project root:

```bash
composer require drupal/sfds -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Note:** at the time of writing the released version is an alpha
> (`1.0.0-alpha3`). If Composer won't pick it up under your stability settings, you
> can request the dev branch explicitly:
> `composer require 'drupal/sfds:1.0.x-dev@dev'`.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/sfds -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sfds -y
```

You can also enable it from the **Extend** page (`/admin/modules`).

## After enabling

There is no central configuration page. Turn on sharing from an individual field's
**storage settings**, where a new **Shared field display settings** section appears.
See the "How to use it" section of the [main guide](../index.md).
