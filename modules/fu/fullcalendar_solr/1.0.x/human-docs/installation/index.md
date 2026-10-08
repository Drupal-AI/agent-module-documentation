# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Views** module (`views`).
- The **Search API** module (`search_api`) — a required dependency.
- A Search API **backend that supports the `search_api_facets` option** (for example
  Search API Solr). The module uses facets to build the list of years that have
  results.

There are no third‑party Composer or PHP library requirements, but see the note
about the FullCalendar JavaScript library in the [main guide](../index.md).

## Install with Composer

From the project root:

```bash
composer require drupal/fullcalendar_solr -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/fullcalendar_solr -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en fullcalendar_solr -y
```

Drupal will enable the Views and Search API dependencies at the same time.

## Verify it worked

Add a new View on a Search API index and check the **Format** options — you should
see **FullCalendar Solr** available as a display format. From there, follow the
step-by-step in the [main guide](../index.md) to build the year calendar (remember
the page path must end in `year`).
