# Installation

## Requirements

- **Drupal 9.3 or 10** (`core_version_requirement: ^9.3 || ^10`).
- Core's **System** module (always present).
- **Search API** (`search_api`) and **Search API Solr** (`search_api_solr`),
  which Botlog declares as dependencies — a working Solr-backed Search API is
  expected, because logged events are indexed there. Install and configure those
  before you rely on Botlog's search screens.

There are no third-party Composer or PHP library requirements from Botlog itself,
but Search API Solr has its own (a Solr server to connect to).

## Install with Composer

From the project root:

```bash
composer require drupal/botlog -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/botlog -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en botlog -y
```

Enabling Botlog pulls in `search_api` and `search_api_solr` as dependencies. You
still need to set up a Solr server and Search API index for the logging and
search features to work fully.

Once enabled, the admin screens appear under **Reports → Botlog**
(`/admin/reports/botlog/monitor`). To actually record events, call the
`botlog.helper` service from your own code — see the [overview](../index.md#how-to-use-it).
