# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- Core's **CKEditor 5** module (`ckeditor5`) enabled — this is the only
  dependency.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/ckeditor5_colgroup -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ckeditor5_colgroup -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ckeditor5_colgroup -y
```

There is nothing to configure and no button to add — the module simply preserves
`<colgroup>`/`<col>` markup so you can add it via Source editing.

## Verify it worked

In a CKEditor 5 text format with **Source editing** enabled, create a table, open
Source editing, and add a `<colgroup>` with `<col>` elements. Save and reopen the
content — with this module enabled, the markup should still be present rather than
stripped out.
