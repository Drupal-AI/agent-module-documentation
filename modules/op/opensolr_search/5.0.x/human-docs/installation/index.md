# Installation

## Requirements

- **Drupal 10.1 or newer, Drupal 11, or Drupal 12** (`core_version_requirement:
  ^10.1 || ^11 || ^12`).
- **PHP 8.1 or newer** (declared by the module).
- Core's **Node** module (`node`) — the only dependency; enabled automatically.
- An **Opensolr account** and API credentials from
  [opensolr.com](https://opensolr.com/) — the hosted service that does the actual
  indexing and searching. You will enter these during
  [configuration](../configuration/index.md).
- **Outbound HTTPS access** from your site to the Opensolr service (for the Data
  Ingestion API and the management API), and — if you use the crawler — Opensolr
  must be able to reach your public pages over HTTPS.

There are no third-party Composer or PHP library requirements beyond Drupal core.

## Install with Composer

From the project root:

```bash
composer require drupal/opensolr_search -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/opensolr_search -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en opensolr_search -y
```

Enabling creates the module's analytics tables (query log, click log, and the
ingestion-job queue) and installs the default configuration.

The module ships one permission, **Administer Opensolr Search**
(`administer opensolr search`), which is marked *restrict access* because it
controls the Opensolr credentials and destructive index-management actions
(create, reset, and delete the hosted index). Review it at **People → Permissions**
(`/admin/people/permissions`) after enabling, and grant it only to trusted roles.

## Verify it worked

Go to **Configuration → Search and metadata → Opensolr**
(`/admin/config/search/opensolr`). You should see the settings page with its ten
tabs. Enter your Opensolr credentials on the **Settings** tab (see
[Configuration](../configuration/index.md)), then use the crawler or ingestion
path to index some content and run a search at `/opensolr-search` to confirm
results come back.
