# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **Purge** module (`purge`) — the framework this plugin slots into. Install
  and enable it (along with the Purge processors/queuers you want) so the purger has
  a pipeline to run in.
- An **Imperva account** with API credentials (an **API ID** and **API key**) that
  can purge your site's edge cache.

## Install with Composer

From the project root:

```bash
composer require drupal/imperva_cache_purger -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. This will pull in the Purge module if it is not already
present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/imperva_cache_purger -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en imperva_cache_purger -y
```

## Verify it worked

Go to **Configuration → Development → Performance → Purge**
(`/admin/config/development/performance/purge`). The **Imperva cache Purger**
should appear as an available purger you can add to the pipeline. After you add and
configure it (see [Configuration](../configuration/index.md)), change a piece of
content and confirm the corresponding page refreshes at the Imperva edge instead of
serving a stale copy. The Purge module's own documentation covers how to test
invalidation end‑to‑end.
