# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- A **file field** on the entity where you want to display structures.
- The **NGL Viewer** JavaScript library. By default the module loads it from a
  public CDN (`unpkg.com`), so nothing extra is needed to get started — but for
  privacy or supply-chain hardening you can host it locally (see Configuration).
- Optionally, the **Fallback Formatter** module if you want unrecognized formats to
  fall back to another formatter.

This is a **beta** (1.1.0-beta1) release.

## Install with Composer

From the project root:

```bash
composer require drupal/pdb_file_viewer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/pdb_file_viewer -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en pdb_file_viewer -y
```

## (Optional) Use a local copy of the NGL library

To avoid loading NGL from a third-party CDN:

1. Download `ngl.js` from `https://unpkg.com/ngl`.
2. Place it in the module's `libraries/` directory (as described on the module's
   settings page).
3. In the global settings, set the **library source** to **Local**.

## Verify it worked

Add a **file field** to a content type, and on its **Manage display** set the field
format to **PDB File Viewer**. Create a node, upload a `.pdb` (or other supported)
file, and view the node — you should see an interactive 3D molecular viewer. See
[Configuration](../configuration/index.md) for the display options.
