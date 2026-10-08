# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Views** module (`views`) enabled — the only hard dependency, and Drupal
  enables it automatically as a dependency when you turn on this module.
- **Search API** (optional) — if it is installed, its `search_api_text` and
  `search_api_fulltext` exposed filters gain autocomplete too. It is not required.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/views_autocomplete_filters -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/views_autocomplete_filters -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en views_autocomplete_filters -y
```

There is no settings page and no configuration to do here — the module simply
makes a **Use Autocomplete** option available on eligible exposed filters inside
the Views UI. See the [overview](../index.md#how-to-use-it) for how to turn it on
for a filter. There are no submodules.
