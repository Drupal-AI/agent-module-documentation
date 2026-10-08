# Installation

## Requirements

- **Drupal 10.1 or newer, Drupal 11, or Drupal 12** (`core_version_requirement:
  ^10.1 || ^11 || ^12`).
- **PHP 8.1 or newer**.
- Core's **Node** module (`node`) — the only dependency; enabled automatically.
- An **Opensolr account** and API credentials from
  [opensolr.com](https://opensolr.com/) — the hosted service that does the actual
  indexing and searching. You will enter these during
  [configuration](../configuration/index.md).
- **Outbound HTTPS access** from your site to the Opensolr service (for the Data
  Ingestion API), and — if you use the crawler — Opensolr must be able to reach
  your public pages over HTTPS.

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

The module ships its own permission, **Administer Opensolr Search** (restrict
access). Review it at **People → Permissions**
(`/admin/people/permissions`) after enabling, so that only trusted roles can
change the Opensolr settings, credentials, and index.

## Verify it worked

Go to **Configuration → Search and metadata → Opensolr**
(`/admin/config/search/opensolr`). You should see the settings page with its ten
tabs. Enter your Opensolr credentials on the **Settings** tab (see
[Configuration](../configuration/index.md)), then use the crawler or ingestion
path to index some content and run a search at `/opensolr-search` to confirm
results come back.
