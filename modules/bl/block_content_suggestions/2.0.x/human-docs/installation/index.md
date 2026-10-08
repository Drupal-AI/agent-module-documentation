# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- **PHP 8.3 or newer**.
- Core's **Block Content** module (`block_content`) — a hard dependency, enabled
  automatically when you turn this module on.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/block_content_suggestions -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/block_content_suggestions -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en block_content_suggestions -y
```

There are no submodules and no configuration. Once enabled, the content‑block
template suggestions become available — add matching Twig files in your theme and
rebuild the cache. See [How to use it](../index.md#how-to-use-it).
