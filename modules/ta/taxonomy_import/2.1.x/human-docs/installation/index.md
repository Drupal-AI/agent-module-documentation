# Installation

## Requirements

Taxonomy Import is lightweight. It needs:

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Taxonomy** module (it is what provides vocabularies and terms — enable
  it if it is not already on).

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/taxonomy_import -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/taxonomy_import -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en taxonomy_import -y
```

That is all it takes. The import and settings forms appear under **Configuration →
Content authoring**. There are no submodules.

## Verify it worked

Log in as an administrator and visit
`/admin/config/content/taxonomy_import/import`. You should see the import form with
a vocabulary selector and a file upload field. If you want to tune the upload
limits first, see [Configuration](../configuration/index.md).
