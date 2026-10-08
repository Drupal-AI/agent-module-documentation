# Installation

## Requirements

- **Drupal 10.4+ or 11.1+** (`core_version_requirement: ^10.4 || ^11.1`). These are
  the core versions that bundle CKEditor 5 v44.0.0, which contains the bookmark
  plugin this module exposes — older cores do not ship it.
- Core's **CKEditor 5** module (`ckeditor5`) enabled. Drupal enables it
  automatically as a dependency when you turn on this module.

There are no third‑party Composer packages or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/ckeditor5_bookmark -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ckeditor5_bookmark -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ckeditor5_bookmark -y
```

## After enabling

Enabling the module does **not** put the button on any toolbar by itself — it just
makes the button available. Finish the setup by adding the **Bookmark** button to
each text format that should have it, at **Configuration → Content authoring → Text
formats and editors** (`/admin/config/content/formats`). See the
[overview](../index.md) for the step‑by‑step.
