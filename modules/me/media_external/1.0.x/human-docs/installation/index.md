# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Media** (`media`) and **Media Library** (`media_library`) modules —
  Media External builds on both, and they are enabled as dependencies.
- The contrib **Imagecache External** module (`drupal/imagecache_external ^3.0`)
  — pulled in automatically by Composer and used to apply image styles to the
  remote images.
- A **provider API key** for each stock provider you want to use (Pexels and/or
  Unsplash). These are free to obtain from the providers' developer sites and go
  in `settings.php` — see [Configuration](../configuration/index.md).

## Install with Composer

From the project root:

```bash
composer require drupal/media_external -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and pulls in `drupal/imagecache_external` for you.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/media_external -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_external -y
```

Drupal enables `media`, `media_library`, and `imagecache_external` alongside it
if they are not already on.

## After enabling

The module ships no submodules and no permissions of its own. Before editors can
import anything you must:

1. Add your provider API key(s) to `settings.php`.
2. Create a media type on the **External media** source.

Both steps are covered in [Configuration](../configuration/index.md).
