# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **CKEditor 5** module (`ckeditor5`) enabled — this is the only
  dependency, and Drupal enables it automatically when you turn on CKEditor
  Bootstrap Grid.
- Your site's front‑end theme should provide **Bootstrap 5 CSS** so the grids
  actually render as columns for visitors. Inside the editor the module can load
  Bootstrap from a CDN for preview purposes, but on the rendered page the styling
  comes from your theme.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/ckeditor_bs_grid -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ckeditor_bs_grid -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ckeditor_bs_grid -y
```

Or enable **CKEditor Bootstrap Grid** on the **Extend** page (`/admin/modules`).

Enabling the module doesn't add the button anywhere yet — you turn it on per text
format. See [How to use it](../index.md#how-to-use-it) for that, and
[Configuration](../configuration/index.md) for the site‑wide layout catalogue.

CKEditor Bootstrap Grid has no submodules.
