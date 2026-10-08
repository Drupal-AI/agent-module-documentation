# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No module dependencies beyond Drupal core, and no third‑party Composer or PHP
  libraries.

For good printed output you should also have a **print stylesheet**
(`@media print`) in your theme — Area Print decides *what* prints, but your
stylesheet decides *how it looks*. See
[How to use it](../index.md#how-to-use-it).

## Install with Composer

From the project root:

```bash
composer require drupal/area_print -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/area_print -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en area_print -y
```

The module adds no admin settings page; you wire its print control into the
region you want printable, as described in
[How to use it](../index.md#how-to-use-it). This is a beta release
(2.0.0‑beta4) — test it, including across browsers, before using it on a live
site.

This module has no submodules.
