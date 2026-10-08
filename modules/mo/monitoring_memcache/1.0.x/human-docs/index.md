# Monitoring Memcache — manual setup guide

**Monitoring Memcache** (`monitoring_memcache`) adds a set of
[Monitoring](https://www.drupal.org/project/monitoring) sensors that report on the
health of your Memcache clusters, so cache health can be alerted on alongside the
rest of your site's sensors. If you run Memcache and already use Monitoring, this
gives your operations team early warning of memory pressure, poor hit ratios,
evictions, connectivity loss, or a restarted server.

For each Memcache cluster you have configured, the module provisions sensors for
several metrics: **memory usage** (warn at 80%, critical at 95% by default),
**hit ratio** (warn below 85%, critical below 70%), **evictions** (a cumulative
counter), **connectivity** (turns critical when fewer servers respond than are
configured), and **uptime** (a drop signals a server restart). It discovers your
clusters automatically from your Memcache settings.

There is **no settings form of its own** — the sensors are created on install by
reading `$settings['memcache']['servers']`, and you then tune thresholds and
labels through the normal Monitoring sensor screens. It depends on the Monitoring
and Memcache modules and works on Drupal 10.3+ or 11.

This guide is written for a **human**. If you want terse, token‑cheap references
for an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module. Sensors are provisioned
automatically; how to tune and re-provision them is described below.

## How it works and how to use it

- **On install**, the module reads `$settings['memcache']['servers']`, works out
  the distinct cluster names, and creates one Monitoring sensor per metric per
  cluster. Existing sensor configuration is preserved when re-provisioning, so any
  edits you make to thresholds or labels are not overwritten.
- **Tune the sensors** through Monitoring's own sensor administration — adjust
  thresholds, labels and how the results are surfaced there.
- **Where results appear:** the sensor data is admin/monitoring-facing. If you
  expose Monitoring results externally (for example via a status endpoint), gate
  that access appropriately — this module itself adds no public endpoint and no
  access-control role.
- **Diagnostics:** the status report at **`/admin/reports/status`** flags two
  situations — clusters configured in Memcache settings but not yet provisioned
  with sensors, and sensors referencing clusters that no longer exist.
- **After changing `$settings['memcache']`**, re-provision the sensors either by
  uninstalling and re-enabling the module, or by running the discovery service
  (`MemcacheClusterDiscovery::ensureSensors()`), for example via `drush php:eval`
  or a small update hook.

> **Note:** at the time of writing this is an alpha release (`1.0.0-alpha2`).
> The `monitoring.settings:disable_sensor_autocreate` toggle is honoured — when it
> is on, the install hook creates no sensors and the "missing sensors" warning is
> downgraded to informational.
