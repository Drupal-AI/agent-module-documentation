# Installation

## Requirements

- **Drupal 10.4 or 11** (`core_version_requirement: ^10.4 || ^11`).
- Core's **File** (`file`) module — ships with Drupal and is enabled automatically
  as a dependency.
- **At least one loader plugin module** so a Document Loader plugin is actually
  available (Document Loader itself is only the framework).

## Install with Composer

From the project root:

```bash
composer require drupal/document_loader -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/document_loader -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Install a loader plugin

Add whichever loader plugins match the document types you want to ingest, for
example:

```bash
# PDF files
composer require drupal/document_loader_pdfparser -W

# Word / ODT / RTF
composer require drupal/document_loader_phpword -W

# Remote web pages
composer require drupal/document_loader_webpage -W
```

Each of these has its own human-docs guide — see the recommended-modules table in
the [overview](../index.md).

## Enable the modules

```bash
drush en document_loader -y
# plus each loader plugin you installed, for example:
drush en document_loader_pdfparser -y
```

## Verify it worked

Visit **Configuration → Media → Document Loader**
(`/admin/config/media/document-loader`). You should see the settings page, and any
loader plugins you enabled should be listed as available. From there you can
[configure the mappings and test loading a document](../configuration/index.md).
