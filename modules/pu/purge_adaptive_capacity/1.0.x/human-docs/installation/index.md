# Installation

## Requirements

- **Drupal 10.3+, 11, or 12** (`core_version_requirement: ^10.3 || ^11 || ^12`).
- The **Purge** module (`purge`) — this module extends Purge's capacity tracker,
  so Purge must be installed and configured with a working purger and queue.

There are no third‑party Composer or PHP library requirements. Note this module
has *not-covered* security advisory coverage.

## Install with Composer

From the project root:

```bash
composer require drupal/purge_adaptive_capacity -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install and update the
Purge dependency as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/purge_adaptive_capacity -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en purge_adaptive_capacity -y
```

Make sure Purge itself is already set up with a purger and queue — this module
only adjusts how many queued items are processed, it doesn't purge anything on its
own.

## Verify it worked

Go to **Configuration → Development → Performance → Purge adaptive capacity**
(`/admin/config/development/performance/purge-adaptive-capacity`). You should see
the settings form with **minimum items**, **maximum items**, and **queue
high‑watermark** fields. Set them to suit your traffic and save — see the
[overview](../index.md) for how the scaling works.
