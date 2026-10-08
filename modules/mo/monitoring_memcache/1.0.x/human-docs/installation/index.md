# Installation

## Requirements

- **Drupal 10.3+ or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **Monitoring** module (`monitoring`) — the sensors this module adds run
  inside Monitoring.
- The **Memcache** module (`memcache`) — the sensors read Memcache statistics.
- One or more Memcache clusters configured in `$settings['memcache']['servers']`
  — the module reads this on install to discover which clusters to provision
  sensors for.

## Install with Composer

From the project root:

```bash
composer require drupal/monitoring_memcache -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Monitoring and
Memcache dependencies and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/monitoring_memcache -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Make sure your Memcache clusters are configured in settings *before* you enable
the module, so it can discover them:

```bash
drush en monitoring_memcache -y
```

On enable, the module provisions one sensor per metric per configured cluster.

## Verify it worked

1. Check **`/admin/reports/status`** — it reports any clusters that are configured
   but not yet provisioned, and any sensors pointing at clusters that no longer
   exist.
2. Open Monitoring's sensor list and confirm the Memcache sensors (memory usage,
   hit ratio, evictions, connectivity, uptime) appear for each of your clusters.

If you add or change clusters in `$settings['memcache']` later, re-provision the
sensors — either uninstall and re-enable the module, or run the discovery service
`MemcacheClusterDiscovery::ensureSensors()` (see the [overview page](../index.md)).
