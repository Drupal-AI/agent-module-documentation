# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **Geofield** module (`geofield`) — this is the required dependency; the
  renderer and store locator both operate on geofield values.
- **Views REST export** (part of core's Views module) if you want to use the
  **store locator** block, which reads from a Views REST export data source.
- **Optional:** [Search API](https://www.drupal.org/project/search_api) and
  [Facets](https://www.drupal.org/project/facets) if you want search and facet
  filtering on the store locator. Any tool that speeds up display (such as
  Elasticsearch or Solr) is optional too.

## Install with Composer

From the project root:

```bash
composer require drupal/openlayers6 -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. Note that the Geofield module is a Drupal dependency, so
you may need to require it as well if Composer does not pull it in automatically:
`composer require drupal/geofield`.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/openlayers6 -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en openlayers6 -y
```

Drupal enables Geofield automatically as a dependency if it is present.

## Verify it worked

Add (or reuse) a **Geofield** field on a content type, then go to that type's
**Manage display** and confirm an OpenLayers 6 format is available for the field.
Set it, give a piece of content a location value, and view the content — you
should see an interactive OpenLayers map with a marker at that location. If you
plan to use the store locator, place its block from **Structure → Block layout**
and confirm it renders your markers.
