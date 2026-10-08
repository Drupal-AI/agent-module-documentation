# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Image** module (`image`) enabled — the only dependency, and Drupal enables
  it automatically.
- No third-party PHP or Composer libraries.

Optional integrations, each active only if the relevant module is installed:

- **Focal Point** — focal-point-aware crops.
- **Crop / Image Widget Crop** — per-formatter crop types.
- **Automated Crop** — smart cropping of generated styles.
- **ImageAPI Optimize WebP** — serve WebP through that pipeline instead of core GD.
- **Apache** users can optionally add the shipped `.htaccess` rewrite
  (`htaccess.prepend.txt`) to serve already-generated derivatives straight from disk.

## Install with Composer

From the project root:

```bash
composer require drupal/drimage -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/drimage -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en drimage -y
```

Once enabled, review the global settings and then switch an image field to the Drimage
formatter — see [Configuration](../configuration/index.md).
