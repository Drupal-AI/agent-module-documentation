# Installation

## Requirements

Sync Files needs:

- **Drupal 8.8, 9, 10 or 11** (`core_version_requirement: ^8.8||^9||^10||^11`).
- A **source site** whose files are reachable from this environment over HTTP or
  HTTPS — the module fetches files by URL.

There are no third-party module, Composer or PHP library dependencies listed.

## Install with Composer

From the project root:

```bash
composer require drupal/sync_files -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/sync_files -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sync_files -y
```

## Verify it worked

After enabling, open the Sync Files settings page (see
[Configuration](../configuration/index.md)), enter your source server address,
and run a sync. A file that exists on the source but was missing locally should
appear in your file system afterwards.
