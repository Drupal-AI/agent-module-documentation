# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- Core **Field** (`field`), **Media** (`media`), and **System** (`system`)
  modules — Drupal enables these automatically as dependencies.
- **Pano2VR** or **Object2VR** (from Garden Gnome Software) to create and export
  the package archives you will upload.
- No third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/garden_gnome_package -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/garden_gnome_package -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en garden_gnome_package -y
```

## Verify it worked

Go to **Configuration → Media → Garden Gnome Package**
(`/admin/config/media/garden_gnome_package`) and confirm the settings form loads.
Then add a **Garden Gnome Package** field to a content type via **Manage fields**,
upload a real Pano2VR/Object2VR package to a test node, and confirm the interactive
viewer renders on the page.

> Before letting anyone upload packages, review the **security note** on the
> [overview page](../index.md) and limit package‑upload access to trusted editors.
