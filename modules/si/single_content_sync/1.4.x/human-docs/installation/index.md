# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- **PHP 7.4 or newer** (`php: >=7.4`).
- The PHP **DOM** (`ext-dom`) and **Zip** (`ext-zip`) extensions — DOM is used to
  process HTML/formatted‑text fields, and Zip is needed to build and read the
  `.zip` bundles with assets. Most Drupal‑ready PHP installs already have both.
- Core's **File** module (`file`) — the only Drupal module dependency, enabled
  automatically.

## Install with Composer

From the project root:

```bash
composer require drupal/single_content_sync -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/single_content_sync -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en single_content_sync -y
```

This module ships **no submodules**. Out of the box it enables exporting for
nodes, media, taxonomy terms, block content, and menu link content — you can
adjust that on the settings form.

## Verify it worked

- Go to **Configuration → Content → Single Content Sync**
  (`/admin/config/content/single-content-sync`) and confirm the settings form
  loads.
- Open any node and confirm it now has an **Export** tab.
- Check that **Content → Import** (`/admin/content/import`) is available.

Next, see [Configuration](../configuration/index.md) for the settings and
permissions.
