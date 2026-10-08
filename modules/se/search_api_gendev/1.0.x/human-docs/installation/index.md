# Installation

## Requirements

Search API generic devel needs:

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- **Search API** (`search_api`).
- The **Devel** module (`devel`) — this module adds a tab to Devel's entity tab
  group, so Devel must be installed.

There are no third-party Composer or PHP library requirements. Because it depends
on Devel, treat it as a **development/staging-only** tool rather than something to
enable on production.

## Install with Composer

From the project root:

```bash
composer require drupal/search_api_gendev -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. The Composer package name (`drupal/search_api_gendev`)
matches the module's machine name (`search_api_gendev`). Devel is often installed
as a development dependency, e.g. `composer require drupal/devel --dev`.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/search_api_gendev -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en search_api_gendev -y
```

This also enables the Search API and Devel dependencies if they are not already on.

## Verify it worked

Visit an entity that is tracked by a Search API index (such as a node) and open its
**Devel** tab group. You should see a new Search API tab showing the indexed data
for that entity, along with buttons to reindex it or delete its index item.
