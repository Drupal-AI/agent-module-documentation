# Installation

## Requirements

- **Drupal 10.1 or newer, including Drupal 11** (`core_version_requirement:
  ^10.1 || ^11`).
- Core's **Block** module (part of a standard install) to place the StoryMaps
  block.
- No third-party Composer or PHP library dependencies. The StoryMap itself is
  loaded in the browser from Esri/ArcGIS, so no library needs to be installed
  locally.

## Install with Composer

From the project root:

```bash
composer require drupal/storymaps -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/storymaps -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en storymaps -y
```

## Verify it worked

After enabling, go to **Configuration → Web services → ArcGIS StoryMaps**
(`/admin/config/services/arcgis-storymaps`) and confirm the settings page loads.
Enter a Story ID (see [Configuration](../configuration/index.md)), place the block,
and check that the StoryMap renders on the page. Because the embed loads from Esri,
make sure the browser can reach ArcGIS and that this fits your privacy/consent
policy.
