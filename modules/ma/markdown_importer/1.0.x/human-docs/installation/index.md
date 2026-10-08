# Installation

## Requirements

- **Drupal 10 or 11** and **PHP 8.2 or later**.
- Core's **Filter** module (`filter`), part of a standard Drupal install.
- The CommonMark parser libraries, installed via Composer (see below).

## Install with Composer

From the project root, require the module:

```bash
composer require drupal/markdown_importer -W
```

The module uses the `league/commonmark` parser (plus its heading‑permalinks and
attributes extensions). If they are not already present, install them with
Composer:

```bash
composer require league/commonmark league/commonmark-ext-heading-permalinks league/commonmark-ext-attributes
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/markdown_importer -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en markdown_importer -y
```

## Verify it worked

Go to **Configuration → Web services → Import Markdown**
(`/admin/config/services/import-markdown`). You should see the import form, ready
for a repository URL. See [Configuration](../configuration/index.md) to run your
first import.
