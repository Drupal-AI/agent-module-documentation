# Installation

## Requirements

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ^9.5 || ^10 || ^11`).
- The **Document OCR** (`document_ocr`) module — this add-on plugs into its
  transformer pipeline.
- An **AI21 Studio account and API key** (see [Configuration](../configuration/index.md)).
- A working **private filesystem** in Drupal (`private://`), because the AI21
  credentials are read from a JSON file stored there.

## Install with Composer

From the project root:

```bash
composer require drupal/document_ocr_ai21 -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install Document OCR (if not
already present) and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/document_ocr_ai21 -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en document_ocr_ai21 -y
```

This also enables **Document OCR** if it is not already on.

## Verify it worked

Go to **Configuration → Structure → Document OCR**
(`/admin/config/structure/document-ocr`). When you add a transformer to a mapping,
the AI21 **Summarize** and **Segmentation** transformer plugins should now be
available as choices. Before running them, set up your credentials file as described
in [Configuration](../configuration/index.md).
