# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Purge** module at **`^3.4`** (`drupal/purge`), set up and working, with a
  **purger** that can invalidate by **URL or path**. Purge is pulled in
  automatically as a dependency.
- Awareness of the registry-growth caution on large sites — see the warning in
  the [overview](../index.md).

## Install with Composer

From the project root:

```bash
composer require drupal/purge_queuer_url -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/purge_queuer_url -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en purge_queuer_url -y
```

After enabling, set a long page-cache lifetime and train the traffic registry as
described in "How to use it" in the [overview](../index.md) — the module is only
accurate once the registry has learned which URLs carry which cache tags.

## Verify it worked

1. Complete the training crawl (`wget … --spider`) from the overview.
2. Edit any already-visited page, then run `drush p-queue-browse` — you should see
   one or more URLs added to the Purge queue.
3. Confirm your URL/path-capable purger processes those queued URLs against your
   CDN or reverse proxy.
