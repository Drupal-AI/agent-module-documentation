# Installation

> **Before you install:** this module is **obsolete and unsupported** — its
> functionality has been merged into **Search API Solr**. Prefer that for new
> sites. The steps below are for reference and existing installations.

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- The **Search API** module (`search_api`) and the **Search API Solr** module
  (`search_api_solr`) — these are required dependencies, and you need a working
  Apache Solr backend and index for the logs to be written to.

There are no additional PHP or library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/solrlog -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Search API and
Search API Solr and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/solrlog -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en solrlog -y
```

You will need your Solr server and index configured through Search API Solr first
(**Configuration → Search and metadata → Search API**) so there is a Solr backend
for the log entries to be indexed into.

## Verify it worked

Log in as a user with permission to view the log, then visit
`/admin/reports/solrlog`. You should see the **"Recent log messages (solr)"**
report listing events drawn from Solr.
