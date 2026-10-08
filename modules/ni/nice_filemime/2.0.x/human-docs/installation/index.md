# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- To use the **field formatter**, core's **Views** (for listing files); to use the
  **facet processor**, the **Facets** (and Search API) modules. These are only
  needed for the surfaces you actually use.

There are no third‑party PHP library requirements and no other module
dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/nice_filemime -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/nice_filemime -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en nice_filemime -y
```

## Verify it worked

Edit a View that outputs a file's MIME type and confirm that **Nice Filemime**
appears as a formatter option on that field; set it, and the raw MIME string
should render as a friendly label (for example "Word document"). If you use
Facets, check that the **Nice Filemime** processor is available on your file‑type
facet. See "How to use it" in the [overview](../index.md).
