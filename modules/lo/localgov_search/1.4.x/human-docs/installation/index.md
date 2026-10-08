# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Node** (`node`) and **Views** (`views`) modules.
- The **Search API** module (`search_api`).
- **LocalGov Core** (`localgov_core`).

Search API and LocalGov Core are contributed modules; Composer will pull them in
as dependencies. LocalGov Search is designed for a LocalGov Drupal site, so in
practice you will already have the LocalGov distribution's modules present.

## Install with Composer

From the project root:

```bash
composer require drupal/localgov_search -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies — including Search API and LocalGov Core — as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/localgov_search -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en localgov_search -y
```

Enabling it installs the `localgov_sitewide_search` index and view, plus the
search block. On a LocalGov Base or Scarfolk theme it also places the search
block for you.

## Choose a search backend

LocalGov Search defines the index but **not** the server that stores it, so you
must provide a backend before search will return results:

- **Simple database backend** — enable the bundled submodule, which sets up a
  database-backed Search API server:

  ```bash
  drush en localgov_search_db -y
  ```

- **Apache Solr** — leave the submodule off, and instead attach the
  `localgov_sitewide_search` index to a Solr server you configure through Search
  API.

After enabling a backend, index your content from **Configuration → Search and
metadata → Search API**, or with:

```bash
drush search-api:index localgov_sitewide_search
```
