# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Views** module (`views`), which is enabled on any standard Drupal site
  and is the only dependency.
- **Optional:** the [Search API](https://www.drupal.org/project/search_api)
  module if you want the OR behavior on Search API views — the same checkbox
  applies there.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/views_contextual_filters_or -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/views_contextual_filters_or -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en views_contextual_filters_or -y
```

There are no submodules and no module‑level configuration. Once enabled, the
**Contextual filters OR** checkbox appears in every View display's Query settings
— see the [overview](../index.md) for how to switch it on.
