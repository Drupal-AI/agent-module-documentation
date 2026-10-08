# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- Core's **Node**, **Taxonomy**, **File**, and **Path alias** modules — Drupal
  enables these automatically as dependencies.
- Access to the **Drupal 7 source site** (to run the export script) and, if you
  want to bring managed files across, a copy of the D7 `files` directory.

## Install with Composer

From the project root:

```bash
composer require drupal/d7_import -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/d7_import -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en d7_import -y
```

## Verify it worked

Go to **Content → D7 Import** (`/admin/content/d7-import`) and confirm the import
form loads. Before you can import anything you first need to export your content
from the D7 site — that, and the correct import order, are covered in
[Configuration](../configuration/index.md).
