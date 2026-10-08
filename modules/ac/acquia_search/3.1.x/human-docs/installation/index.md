# Installation

## Requirements

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ^9.5 || ^10 || ^11`).
- **Acquia Connector** (`drupal/acquia_connector`, `^4.0`) — this is what
  connects your site to its Acquia subscription and provides the credentials
  Acquia Search signs requests with.
- **Search API Solr** (`drupal/search_api_solr`, `^4.3.1`) and core's **Views** —
  Acquia Search is a thin layer on top of these.
- PHP extensions **curl**, **json**, and **zip**.
- Several PHP libraries (`acquia/http-hmac-php`, Guzzle, and friends), which
  Composer pulls in automatically.
- A **valid Acquia subscription** and **network access to Acquia** for a live
  index. Without these the module still installs and configures, but cannot reach
  Solr.

## Install with Composer

From the project root:

```bash
composer require drupal/acquia_search -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Acquia Connector,
Search API Solr, and the required libraries, updating shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/acquia_search -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en acquia_search -y
```

Drupal enables Acquia Connector, Search API Solr, and Views as dependencies. On
install, the module creates its default Search API server (*Acquia Search*).

## Optional submodule

- **`acquia_search_defaults`** — provides a turnkey demo index and a ready-made
  search view, so you can see Acquia Search working end-to-end without building an
  index by hand:

```bash
drush en acquia_search_defaults -y
```

## Next steps

Connect your Acquia subscription through Acquia Connector, then see
[Configuration](../configuration/index.md) for core selection and read-only mode.
