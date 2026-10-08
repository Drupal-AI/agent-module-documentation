# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- Core's **File** module (`file`) — enabled in a standard install.
- PHP's Zip support must be available on the server (the module writes zip
  archives with `\ZipArchive`).

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/download_all_files -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/download_all_files -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en download_all_files -y
```

## Verify it worked

On a content type with a core File or Image field, set the field's display format
to **Table of files with download all link** (see the "How to use it" section of
the [overview](../index.md)). View an entity that has several files attached and
click the **Download All** link — you should receive a single zip containing the
files.
