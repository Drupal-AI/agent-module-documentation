# Installation

## Requirements

Search API needs **Drupal 10.3+ or 11** (`^10.3 || ^11`). The core module itself
has no other contrib dependencies — it is a framework. On its own, though, it can
neither store nor query anything: you also need a **backend**. You have two easy
choices:

- **Database Search** (`search_api_db`) — a submodule that ships *inside* Search
  API. It stores the index in your site's regular database, so it needs no extra
  services and is the fastest way to get a working search. It is great for small
  and medium sites but is not recommended for very large ones.
- **Apache Solr** (`search_api_solr`) — a separate, more powerful backend for
  large sites and advanced relevance. It is **not** bundled; you install it as its
  own module (`composer require drupal/search_api_solr`) and it requires a running
  Solr server.

This guide uses the bundled Database backend so you can build search with zero
extra infrastructure.

Optional companion modules (each installed separately) extend Search API:

- **Facets** (`drupal/facets`) — adds faceted (filter-by-category) search.
- **Search API Autocomplete** (`drupal/search_api_autocomplete`) — adds
  autocomplete suggestions to search boxes.

## Install with Composer

From the project root:

```bash
composer require drupal/search_api -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update related packages as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/search_api -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module and a backend

Enable Search API together with the bundled Database Search submodule so you have a
working backend from the start:

```bash
drush en search_api search_api_db -y
```

If you plan to use Solr instead, require and enable that module separately:

```bash
composer require drupal/search_api_solr -W
drush en search_api_solr -y
```

## Verify it worked

Log in as an administrator and go to **Configuration → Search and metadata →
Search API** (`/admin/config/search/search-api`). You should see the overview page
with **+ Add server** and **+ Add index** buttons:

![The Search API overview page after installation](../images/overview.png)

If the page loads and those buttons are present, the module is installed correctly.
Next, review how the pieces fit together in [Configuration](../configuration/index.md),
then [create your first server and index](../creating-a-server-and-index/index.md).
