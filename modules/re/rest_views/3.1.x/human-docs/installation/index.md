# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- **PHP 8** or newer (`php: ^8`).
- Core's **Views** module (`views`) and core's **REST** (`rest`) module, both
  enabled. Drupal pulls them in automatically as dependencies. You'll typically also
  want the **Serialization** module (part of REST's stack) so JSON output works.

There are no third-party Composer library requirements.

Optional companions the module suggests (not required):

- **Entity Reference Revisions** (`drupal/entity_reference_revisions`) — needed by
  the `rest_views_revisions` submodule to export Paragraphs and other reference
  revisions.
- **Search API** (`drupal/search_api`) — needed by the `rest_views_search_api`
  submodule to export Search API index fields.

## Install with Composer

From the project root:

```bash
composer require drupal/rest_views -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/rest_views -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en rest_views -y
```

The serializable field handlers and export formatters become available inside the
Views UI immediately.

## Optional submodules — enable only what you need

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **REST Views Geo** | `rest_views_geo` | Export geolocation latitude/longitude as structured data. |
| **REST Views Revisions** | `rest_views_revisions` | Export entity reference revisions (Paragraphs) as nested data. Requires Entity Reference Revisions. |
| **REST Views Search API** | `rest_views_search_api` | Export Search API index fields. Requires Search API. |

Enable them individually, for example:

```bash
drush en rest_views_revisions -y
```

## Next step

There is no configuration page — you set everything up per field inside a REST
Export view. See the "How to use it" section on the [overview page](../index.md).
