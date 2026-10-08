# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- The contrib **Purge** module, version 3 or newer (`drupal/purge:>=3`), which
  Composer pulls in for you.
- **At least one enabled purger** that supports a URL‑oriented invalidation type —
  `url`, `wildcardurl`, `path`, or `wildcardpath` — plus **at least one purge
  processor**. Without these, Purge File has nothing to send invalidations to and
  the status report will flag an error.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/purge_file -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, including the Purge module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/purge_file -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en purge_file -y
```

Purge itself is a framework — you still need to configure a purger and a processor
in Purge (at `/admin/config/development/performance/purge`) for a real external
cache before file invalidations go anywhere. Then set up Purge File's own options
in [Configuration](../configuration/index.md).

This module has no submodules.
