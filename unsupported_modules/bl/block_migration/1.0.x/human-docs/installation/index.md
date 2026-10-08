# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Block content** module (`block_content`).
- The **Single Content Sync** module (`single_content_sync`), which Composer pulls
  in as a dependency and which provides the underlying export/import framework.

There are no third-party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/block_migration -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in and update the
required dependencies, including Single Content Sync.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/block_migration -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en block_migration -y
```

Enabling Block Migration also enables Single Content Sync if it isn't already on.
After enabling, grant the module's permission to the appropriate roles, then
export and import blocks — see [How to use it](../index.md#how-to-use-it).
