# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **Purge** module suite — specifically the **Core Tags Queuer**
  (`purge_queuer_coretags`) and the **Late Runtime Processor**
  (`purge_processor_lateruntime`) submodules, both hard dependencies that Drupal
  enables for you.
- An **Akamai-fronted GovCMS environment** that provides the required environment
  variables (see [Configuration](../configuration/index.md)). The module is
  intended for the GovCMS platform.

## Install with Composer

From the project root:

```bash
composer require drupal/govcms_akamai_purge -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, including the Purge submodules.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/govcms_akamai_purge -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en govcms_akamai_purge -y
```

This also enables the required Purge queuer and processor submodules.

## Verify it worked

On a properly configured GovCMS environment, cacheable responses gain an
`Edge-Cache-Tag` header and a purger appears in the Purge admin
(**Configuration → Development → Performance → Purge**,
`/admin/config/development/performance/purge`). See
[Configuration](../configuration/index.md) for the environment variables that must
be present for purging to work.
