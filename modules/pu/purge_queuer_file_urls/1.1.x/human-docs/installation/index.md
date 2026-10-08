# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core **File** module (`file`) — enabled automatically as a dependency.
- The **Purge** module (`purge`), set up and working, with a **purger** that
  supports the file invalidation type you plan to use (e.g. `relativeurl` or
  `absoluteurl`). Purge is pulled in automatically as a dependency.

## Install with Composer

From the project root:

```bash
composer require drupal/purge_queuer_file_urls -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/purge_queuer_file_urls -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en purge_queuer_file_urls -y
```

Enabling the module makes its queuers available, but they still need to be added
and configured inside Purge. See "How to use it" in the
[overview](../index.md).

## Verify it worked

1. Go to **Configuration → Development → Performance → Purge**
   (`/admin/config/development/performance/purge`).
2. Confirm the **Files Queuer** (and **Image Styles Queuer**) appear in the list
   of queuers you can enable, and use the **configure** drop-down to pick your
   invalidation method.
3. Edit an entity that references a file, then check that the file's URL appears
   in the purge queue (for example with `drush p:queue-browse`).
