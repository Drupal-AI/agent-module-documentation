# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Action** module (`action`), which Drupal enables automatically as a
  dependency.
- To run the action from a listing you will want a View with **bulk operations**
  enabled (core Views bulk operations, or the Views Bulk Operations contrib
  module).
- No third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/bulk_copy_fields -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. Note this is an **alpha** release (`8.x-1.0-alpha6`).

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/bulk_copy_fields -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en bulk_copy_fields -y
```

Once enabled, the copy-field-values action is available from a Views bulk
operation — see [How to use it](../index.md#how-to-use-it). Because it writes to
content in bulk with no undo, test it on a copy of your site first.
