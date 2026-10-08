# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- The contrib **[Search API](https://www.drupal.org/project/search_api)** module
  (`search_api`) — this module adds processors to a Search API index, so you need
  a working Search API setup (a server and at least one index) first.
- No third-party Composer or PHP library requirements.
- The **Statistics** processor additionally needs core's **Statistics** module
  enabled (it reads view counts from there).
- For **Solr** backends, the bundled `search_api_sort_priority_solr` submodule so
  the weight fields index as single-valued Solr fields.

## Install with Composer

From the project root:

```bash
composer require drupal/search_api_sort_priority -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/search_api_sort_priority -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en search_api_sort_priority -y
```

## Submodule — Solr support

If your Search API index runs on **Apache Solr**, also enable the Solr submodule so
the generated weight fields sort correctly on that backend:

```bash
drush en search_api_sort_priority_solr -y
```

Sites using the database backend do not need it.

## Next steps

There is no settings page of the module's own. Head to
[Configuration](../configuration/index.md) to enable a processor on your Search API
index, set the priority weights, and sort your results on the new weight field.
