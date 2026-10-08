# Installation

## Requirements

LocalGov Directories has a fairly rich dependency set because it stitches
together content types, Search API, and the Facets module. It needs:

- **Drupal 10.2+ or 11** (`core_version_requirement: ^10.2 || ^11`).
- A number of contributed modules, all pulled in automatically by Composer:
  **Facets**, **Leaflet**, **Pathauto**, **Search API**, **Search API
  Autocomplete**, **Search API Location**, **LocalGov Core**, and **LocalGov
  Geo**.
- Several core modules that Drupal enables as dependencies: **Address**,
  **Block**, **Image**, **Link**, **Media**, **Node**, **Path**, **Telephone**,
  and **Views**.

There are no extra PHP-library requirements beyond the Composer packages above.

## Install with Composer

From the project root:

```bash
composer require drupal/localgov_directories -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Facets, Leaflet,
Search API and the rest, and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/localgov_directories -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

The base module on its own gives you channels and facets but **no search backend
and no entry types**, so a channel page would be empty. Enable a backend
submodule and at least one entry type at the same time:

```bash
drush en localgov_directories localgov_directories_db localgov_directories_page -y
drush cr
```

- `localgov_directories_db` ships the Search API **database** server and index —
  this is the easiest backend to start with.
- To use **Solr** or another backend instead, disable `localgov_directories_db`
  first, then point the `localgov_directories_index_default` index at your own
  server.

## Submodules

The module ships several optional submodules. The most useful when getting
started:

| Submodule | What it adds |
|-----------|--------------|
| `localgov_directories_db` | The bundled Search API **database** server and index. Enable one search backend. |
| `localgov_directories_page` | A ready-made **page** entry type. |
| `localgov_directories_venue` | A **venue** entry type. |
| `localgov_directories_org` | An **organisation** entry type. |
| `localgov_directories_promo_page` | A **promo page** entry type. |
| `localgov_directories_location` | Adds **location / proximity search** (pulls in Leaflet and Search API Location); enables the map and "near me" displays. |
| `localgov_directories_or` / `localgov_directories_venue_or` | Publish venue data in **Open Referral** format (experimental). |

Enable whichever entry types and integrations your site needs, then continue to
[Configuration](../configuration/index.md).
