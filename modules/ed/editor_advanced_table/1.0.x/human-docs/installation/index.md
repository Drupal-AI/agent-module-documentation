# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **CKEditor 5** module (`ckeditor5`) enabled — this is the only
  dependency, and it ships with Drupal core.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/editor_advanced_table -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/editor_advanced_table -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en editor_advanced_table -y
```

## Verify it worked

The module adds no admin page, so verification happens inside a text format. Go
to **Configuration → Content authoring → Text formats and editors**, configure a
CKEditor 5 format, and confirm an **Advanced table** tab appears in the CKEditor 5
plugin settings. Enable the attributes you want, save, then edit a table in that
format — its properties dialog should now offer ID, direction, and CSS classes.
