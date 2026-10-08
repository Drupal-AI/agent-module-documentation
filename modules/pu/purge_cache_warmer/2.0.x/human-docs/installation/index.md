# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`). Earlier releases of this
  module declared `core: 8.x` and cannot be installed on Drupal 9 or later — the
  2.x series is Drupal 11 only.
- The **Purge** module (`purge`), set up and working.
- The **URLs queuer** module (`purge_queuer_url`), which maintains the traffic
  registry the warmer reads from. Both are pulled in automatically as
  dependencies.
- At least one purger already configured, since the warmer runs *after* the
  others in the pipeline.

## Install with Composer

From the project root:

```bash
composer require drupal/purge_cache_warmer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and pulls in Purge and the URLs queuer.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/purge_cache_warmer -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en purge_cache_warmer -y
```

Enabling it does not activate warming on its own — you still have to add the
Cache Warmer to your purger list and move it to the end of the execution order.
See "How to use it" in the [overview](../index.md) for the full pipeline setup.

## Verify it worked

1. Go to **Configuration → Development → Performance → Purge**
   (`/admin/config/development/performance/purge`).
2. Confirm **Cache Warmer** appears in your list of purgers and is **last** in
   the execution order.
3. Edit a page that has already been requested (so it is in the traffic
   registry), let the purge queue process, and confirm a fresh request lands in
   your web server's access log for that URL shortly afterward.
