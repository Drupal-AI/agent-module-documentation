# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- A working **Search API** setup to add the mapping field to. The module has no
  hard module dependencies declared of its own, but it exists to extend Search
  API and has been tested alongside Search API, Search API Solr, and the Facet
  API.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/search_api_mapping -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/search_api_mapping -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en search_api_mapping -y
```

## Verify it worked

Edit a Search API index and open its **Fields** tab. When you add a field, a value
mapping option should now be available, letting you define source-to-target value
pairs that are written into a new, facet-compatible index field.
