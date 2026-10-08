# Installation

## Requirements

Search API Location builds on Search API and a geometry library:

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- The **Search API** module, version `^1.28` (`drupal/search_api`), enabled — it's
  a dependency.
- The **geoPHP** PHP library `itamair/geophp: ^1.2`, pulled in automatically by
  Composer when you require the module below.
- A geofield to index — typically provided by the contrib
  [Geofield](https://www.drupal.org/project/geofield) module — and a **search
  backend that supports spatial data types**. Search API Solr is the known-good
  backend; the default database backend does **not** support spatial search.

## Install with Composer

From the project root:

```bash
composer require drupal/search_api_location -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — and pulls in the required Search API module and the
geoPHP library.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/search_api_location -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en search_api_location -y
```

This makes the two spatial data types available to assign to geofields on your
Search API indexes. The base module has no settings form; see
[Configuration](../configuration/index.md).

## Submodules — enable only what you need

Search API Location ships three optional submodules. Enable them individually with
`drush en`:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Search API Location Views** | `search_api_location_views` | A proximity filter, contextual argument, and sort for Views, so you can build a "within X km" distance search. Uses the `location` data type. |
| **Facets Map Widget** | `facets_map_widget` | An interactive Leaflet **heatmap facet** that clusters results geographically. Uses the `rpt` data type. |
| **Search API Location Geocoder** | `search_api_location_geocoder` | A *geocode* Location Input so users can type a street address that gets converted to coordinates. |

For example, to add the Views proximity search:

```bash
drush en search_api_location_views -y
```

## Verify it worked

Go to **Configuration → Search and metadata → Search API**
(`/admin/config/search/search-api`), open one of your indexes, and on its
**Fields** page add a geofield. In its **Type** dropdown you should now see
**Latitude/longitude** and **Recursive Prefix Tree** as options. See
[Configuration](../configuration/index.md) for the full workflow.
