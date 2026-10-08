# Installation

> **Before you install:** this module is **obsolete** — its functionality is now
> part of the Feeds module itself (Drupal.org issue #2907721). On current Feeds
> releases you can use the built‑in logging and skip this module. The notes below
> are for the standalone module if you still need it.

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- The **Feeds** module (`feeds`).
- **A patch applied to Feeds.** This module relies on a hook that Feeds only
  invokes once patched. The patch differs by branch:
  - For 8.x‑1.x: `https://www.drupal.org/files/issues/2907721.patch`
  - For 2.x: the corresponding patch from the same issue for the 2.x branch.

Apply the patch to Feeds (for example via `composer-patches`) **before** enabling
this module.

## Install with Composer

From the project root:

```bash
composer require drupal/feeds_log -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Feeds and update
any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/feeds_log -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en feeds_log -y
```

## Verify it worked

Open a feed and look for the new **Unimported items** tab on the Feeds view. If it
appears (and the required Feeds patch is applied), the module is working and will
record skipped records on the next import.
