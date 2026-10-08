# Installation

## Requirements

- **Drupal 10.2, 11, or 12** (`core_version_requirement: ^10.2 || ^11 || ^12`).
- Core **Node**, **Block**, **System**, **User** and **Views**.
- **Search API** (`search_api`) and its **Database Search** submodule
  (`search_api_db`) — the database backend, so no external search server is
  needed.
- **Facets** (`facets`) and **Block Visibility Groups**
  (`block_visibility_groups`).
- [**Drutopia Core**](../../../drutopia_core/2.0.x/human-docs/index.md)
  (`drutopia_core`).

There are no third-party PHP-library requirements; Composer fetches the Drupal
projects for you.

## Install with Composer

From the project root:

```bash
composer require drupal/drutopia_search -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Search API,
Facets, Block Visibility Groups and Drutopia Core.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/drutopia_search -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en drutopia_search -y
```

This imports the `content` Search API index, the `search` results View, the three
facets and their facet source, and the search block visibility group.

## Index your content

The index is empty until you populate it. Index existing content from the Search
API UI (`/admin/config/search/search-api`) or with:

```bash
drush search-api:index content
```

## Verify it worked

Visit the search page (the path defined by the `search` View) and run a query —
results should appear alongside the content-type, date and topics facets. If the
page is empty, confirm the `content` index has finished indexing at
`/admin/config/search/search-api`.
