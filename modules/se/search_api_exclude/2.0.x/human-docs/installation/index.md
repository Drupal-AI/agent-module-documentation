# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- The **Search API** module (`drupal/search_api`, `^1.3`), which Composer installs
  as a dependency. You will also need at least one Search API **index** set up (with
  a server/backend) for the exclusion to have somewhere to apply.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/search_api_exclude -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Search API and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/search_api_exclude -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en search_api_exclude -y
```

Search API is enabled as a dependency. There are no sub‑modules.

## Next step

Enabling the module doesn't exclude anything on its own — you have to enable
exclusion per content type, flag the nodes, and add the processor to your index.
Those three steps are covered in [How to use it](../index.md#how-to-use-it). Don't
forget to **reindex** afterwards so the changes reach your search backend.
