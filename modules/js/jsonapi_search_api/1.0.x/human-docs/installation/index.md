<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Installation

## Requirements

- **Drupal 9.1, 10, or 11** (`core_version_requirement: ^9.1 || ^10 || ^11`).
- Core's **JSON:API** module (`jsonapi`) enabled.
- **JSON:API Resources** (`drupal/jsonapi_resources: ^1.0@beta`) — the framework this
  module builds its resource on.
- **Search API** (`drupal/search_api: ^1.0`), with at least one index that has a
  server and is enabled.

Composer pulls in the contrib dependencies, and Drupal enables `jsonapi`,
`jsonapi_resources`, and `search_api` as dependencies when you enable this module.

Optional: the **Facets** module (`drupal/facets`) if you want to use the facets
submodule.

## Install with Composer

From the project root:

```bash
composer require drupal/jsonapi_search_api -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies (including JSON:API Resources and Search API) as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/jsonapi_search_api -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en jsonapi_search_api -y
```

This also enables the required JSON:API, JSON:API Resources, and Search API modules if
they were not already on. There is no configuration form.

## Optional submodule — facets

The module ships one submodule:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **JSON:API Search API Facets** | `jsonapi_search_api_facets` | Adds facet data to the search response's `meta.facets`, so a decoupled client can build faceted search UIs. Requires the [Facets](https://www.drupal.org/project/facets) module. |

```bash
drush en jsonapi_search_api_facets -y
```

## Verify it worked

Make sure you have a Search API index that has a server and is **enabled**, then
rebuild caches (`drush cr`). Request `/jsonapi/index/<your-index-id>` — you should get
a JSON:API collection document of the index's results. See
[How to use it](../index.md#how-to-use-it) on the overview page for the query
parameters.
