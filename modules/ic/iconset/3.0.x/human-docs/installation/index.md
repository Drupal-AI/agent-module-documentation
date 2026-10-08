# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).

There are no third‑party Composer or PHP library requirements. To have icons to
organize, you will need SVG or SVG‑font icon assets available to the site (for
example a Font Awesome sprite under `/libraries`), declared to Iconset through a
`*.iconset.yml` file or the `iconset_custom` submodule.

## Install with Composer

From the project root:

```bash
composer require drupal/iconset -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/iconset -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en iconset -y
```

## Submodules — enable only what you need

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Iconset Custom** | `iconset_custom` | Declare icon sets through the admin UI instead of a YAML file. |
| **Iconset Embed** | `iconset_embed` | Place icons inside embedded content. |
| **Iconset Menu** | `iconset_menu` | Add icons to menu links. |

For example, to add menu‑icon support:

```bash
drush en iconset_menu -y
```

Each submodule requires the base Iconset module, which is already present once
you have installed it above.

## Verify it worked

After enabling the module, visit the Iconset settings page under
**Configuration** (Media group) and confirm any icon sets you have declared are
listed. If you enabled `iconset_menu`, edit a menu link and check that an icon
selector appears. See [Configuration](../configuration/index.md) for the details.
