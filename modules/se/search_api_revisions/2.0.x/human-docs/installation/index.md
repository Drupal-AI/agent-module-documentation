# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **Search API** module (`search_api`) — Drupal will enable it as a
  dependency if it is not already on.

There are no third-party Composer packages or PHP library requirements.

Note that this release (2.0.x) is an alpha and is *not* covered by Drupal's
security advisory policy, so weigh that before relying on it for a production
site.

## Install with Composer

From the project root:

```bash
composer require drupal/search_api_revisions -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/search_api_revisions -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en search_api_revisions -y
```

## Verify it worked

Go to **Configuration → Search and metadata → Search API**
(`/admin/config/search/search-api`) and start adding or editing an index. In the
list of available datasources you should now see the revisions datasource
alongside the standard content datasource. If it appears, the module is ready to
use.
