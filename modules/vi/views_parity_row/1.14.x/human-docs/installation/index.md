# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Views** module (`views`) enabled — this is the only dependency, and
  it is part of core (enabled on any standard site). Drupal will enable it
  automatically if needed.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/views_parity_row -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/views_parity_row -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en views_parity_row -y
```

Once enabled, the new row plugin becomes available in the Views UI. There is no
configuration step here — you pick and configure the plugin inside each view's
**Format** settings, as described on the [main page](../index.md). There are no
submodules.
