# Installation

## Requirements

- **Drupal 10.2, 11, or 12** (`core_version_requirement: ^10.2 || ^11 || ^12`).
- Core **Node**, **Media** and **Taxonomy**.
- **Facets** (`facets`), **Paragraphs** (`paragraphs`), **Pathauto**
  (`pathauto`), **Search API** (`search_api`) and **Video Embed Field**
  (`video_embed_field`).
- [**Drutopia Core**](../../../drutopia_core/2.0.x/human-docs/index.md)
  (`drutopia_core`). The display/search stack also draws in Drutopia SEO, Display
  Suite, Field Group and Focal Point.

There are no third-party PHP-library requirements; Composer fetches the Drupal
projects for you.

## Install with Composer

From the project root:

```bash
composer require drupal/drutopia_resource -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the media,
facets, search and Drutopia projects it needs.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/drutopia_resource -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en drutopia_resource -y
```

This imports the `resource` content type, its fields and displays, the
`resource_type` vocabulary, the Search API index and facets, the resources
listing view, the block visibility group, the Pathauto pattern and Rabbit Hole
settings.

## Verify it worked

Visit **Structure → Content types** (`/admin/structure/types`) and confirm the
**Resource** type is listed. Adding a resource (`/node/add/resource`) should show
the file, link, video and resource-type fields. Then index content in Search API
(`/admin/config/search/search-api`, or `drush search-api:index`) and confirm the
resources listing filters by topic and type.
