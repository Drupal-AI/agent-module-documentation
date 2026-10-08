# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- The **Search API Solr** module (`search_api_solr`), which in turn requires the
  **Search API** module — Hosted Solr is a connector plugin for it and cannot work
  without it.
- A **Hosted Solr account** at hosted‑solr.com, from which you'll copy the host and
  your username/password when configuring the server.

Search API Solr brings its own PHP/Solarium dependencies, which Composer installs
for you. Hosted Solr itself adds no extra third‑party libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/hosted_solr -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Search API and
Search API Solr (if not already present) and update any shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/hosted_solr -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en hosted_solr -y
```

This enables Search API and Search API Solr as dependencies if they aren't already
on.

## Verify it worked

Go to **Configuration → Search and metadata → Search API**
(`/admin/config/search/search-api`) and start adding a **server** with the **Solr**
backend. In the connector list you should now see **Hosted Solr**. Choosing it and
entering your host and credentials, then saving and pinging the server, confirms
the connection — see "How to use it" in the [overview](../index.md).
