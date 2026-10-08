# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- No contrib module dependencies and no third-party Composer or PHP library
  requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/autocomplete_extras -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/autocomplete_extras -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en autocomplete_extras -y
```

Once enabled, adjust the per-field autocomplete options in **Manage form
display**, as described on the [overview page](../index.md). There is no separate
site-wide configuration screen.
