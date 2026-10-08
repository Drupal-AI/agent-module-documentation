# Installation

## Requirements

- **Drupal 10, 11, or 12** (`core_version_requirement: ^10 || ^11 || ^12`).
- **Search API** (`search_api`).
- **Elasticsearch Connector** (`elasticsearch_connector`).
- A reachable **Elasticsearch** server, with a Search API index backed by it.

There are no additional PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/es_filter_analyser -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed and pull in the required search‑stack modules.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/es_filter_analyser -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en es_filter_analyser -y
```

Make sure `search_api` and `elasticsearch_connector` are enabled too (Drupal will
enable them as dependencies).

## Grant the permission

Under **People → Permissions**, grant **Administer ES filter/analyser**
(`administer es_filter_analyser`) to the roles that should manage filters and
analysers — normally administrators only.

## Verify it worked

Log in as a user with the permission and open the module's admin interface. You
should be able to create a **filter** and an **analyser** configuration entity. After
assigning an analyser and rebuilding your Elasticsearch index, confirm the analysis
is applied by checking search results or the index mapping.
