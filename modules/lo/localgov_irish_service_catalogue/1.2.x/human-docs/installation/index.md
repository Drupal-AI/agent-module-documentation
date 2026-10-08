# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- The following contrib modules, which Composer pulls in as dependencies:
  - **Search API** (`search_api`) — powers the catalogue's searchable index.
  - **Facets** (`facets`) — provides the filters on the catalogue listings.
  - **Migrate Plus** (`migrate_plus`) — supports importing catalogue content.

This module is part of the **LocalGov Drupal** distribution and expects to run on a
LocalGov Drupal site (its listings and content model build on the distribution's
conventions).

## Install with Composer

From the project root:

```bash
composer require drupal/localgov_irish_service_catalogue -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies —
including Search API, Facets and Migrate Plus — as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/localgov_irish_service_catalogue -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en localgov_irish_service_catalogue -y
```

Enabling the module installs its content types, Views, facets and migrations, and
turns on its dependencies if they are not already active.

## Verify it worked

- Under **People → Permissions** (`/admin/people/permissions`), confirm the module's
  permissions are listed, and grant them to the appropriate roles.
- Under **Content → Add content** (`/node/add`), confirm the service-catalogue
  content types are available.
- Under **Configuration → Search and metadata → Search API**, confirm the catalogue's
  search index is present, and index your content so the faceted listings return
  results.
