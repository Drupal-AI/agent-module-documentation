# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- The **Search API** module (`search_api`, `drupal/search_api ^1.0`) — this is the
  one hard dependency. Composer installs it for you, and Drupal enables it as a
  dependency when you turn this module on. You should already have at least one
  Search API index (and a search, such as a Views search or a Search API Page) set
  up before autocomplete has anything to attach to.
- For **server-side** suggestions (the *Server* suggester), a search backend that
  supports autocomplete — most commonly **Solr**. The *Live results* suggester
  works with any backend, so you can use autocomplete even on the database backend.

There are no third‑party Composer or PHP library requirements.

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

Enabling the module doesn't change any of your searches on its own — it adds an
**Autocomplete** tab to each Search API index, where you switch autocomplete on
per search. Head to [Configuration](../configuration/index.md) next.

## Verify it worked

Log in as an administrator and go to **Configuration → Search and metadata →
Search API**. Open one of your indexes; you should now see an **Autocomplete** tab
alongside the other index tabs. If it's there, the module is installed and ready
to configure.
