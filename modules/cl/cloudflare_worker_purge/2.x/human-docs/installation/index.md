# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **Purge** module — this module sends invalidations through Purge's pipeline.
- A **Cloudflare account** with a deployed **Worker** for cache‑tag purging (for
  example the Cache Tag Worker) and an API token for it.

> **This module is obsolete and unsupported.** For new sites, prefer the actively
> maintained [Cloudflare Purger](../../cloudflare_purger/1.0.x/human-docs/index.md)
> instead. Only use this module if you specifically need Worker‑based cache‑tag
> purging without a Cloudflare Enterprise account.

## Install with Composer

From the project root:

```bash
composer require drupal/cloudflare_worker_purge -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/cloudflare_worker_purge -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cloudflare_worker_purge -y
```

Make sure the **Purge** module is enabled too.

## Verify it worked

Confirm the module is active with
`drush pm:list --status=enabled | grep cloudflare_worker_purge`, then configure it
within the Purge module and deploy your Cloudflare Worker as described in the
[overview](../index.md#how-to-set-it-up). Remember your Worker must read the
**`X-Cache-Tag`** header, since Cloudflare strips the original `Cache-Tag` header
before the Worker receives it.
