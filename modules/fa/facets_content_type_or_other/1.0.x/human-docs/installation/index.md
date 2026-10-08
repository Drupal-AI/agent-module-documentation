# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Facets** module (`drupal/facets`) — this module provides a facet for it
  and cannot work without it. You will also need **Search API** in practice, since
  the facet is built on a Search API index. Composer pulls Facets in with the
  command below.

There are no third‑party PHP library requirements. This project is **not covered
by Drupal's security advisory policy**, so review it before relying on it in
production.

## Install with Composer

From the project root:

```bash
composer require drupal/facets_content_type_or_other -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, including the Facets module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/facets_content_type_or_other -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en facets_content_type_or_other -y
```

This also ensures the Facets module is enabled.

## Verify it worked

Go to **Configuration → Search and metadata → Content type or Other**
(`/admin/config/search/facets-content-type-or-other`) and confirm the settings
form loads. Then continue with [Configuration](../configuration/index.md) to add
the field to your index, create the facet, and set the sort order.
