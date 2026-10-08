# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No contrib module dependencies and no third-party Composer or PHP library
  requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/autocomplete_4xx -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/autocomplete_4xx -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en autocomplete_4xx -y
```

Once enabled, use the autocomplete field to select content for your 4xx error
pages, as described on the [overview page](../index.md). There is no separate
configuration screen.
