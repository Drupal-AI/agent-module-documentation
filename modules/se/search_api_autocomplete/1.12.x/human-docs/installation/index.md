# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- The **Search API** module (`drupal/search_api`, `^1.0`).
- For server-side term suggestions, a search backend that **supports
  autocomplete** (such as Solr via Search API Solr). The *Live results* suggester
  works with any backend.

No third‑party Composer packages or PHP extensions are required.

## Install with Composer

From the project root:

```bash
composer require drupal/search_api_autocomplete -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Search API and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/search_api_autocomplete -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en search_api_autocomplete -y
```

Search API is enabled automatically as a dependency.

## Verify it worked

Go to **Configuration → Search and metadata → Search API**
(`/admin/config/search/search-api`), open one of your indexes, and look for an
**Autocomplete** tab. If it's there, the module is installed and you can enable
autocomplete for the searches on that index (see the "How to use it" section on the
[overview page](../index.md)).
