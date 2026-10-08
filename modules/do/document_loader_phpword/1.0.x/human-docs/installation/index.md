# Installation

## Requirements

- **Drupal 10.4, 11, or 12** (`core_version_requirement: ^10.4 || ^11 || ^12`).
- The **Document Loader** (`document_loader`) module — the framework this plugin
  extends.
- The **`phpoffice/phpword`** PHP library — installed automatically when you require
  this module with Composer.

## Install with Composer

From the project root:

```bash
composer require drupal/document_loader_phpword -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the required
`phpoffice/phpword` library and Document Loader, and update any shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/document_loader_phpword -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en document_loader_phpword -y
```

This also enables **Document Loader** if it is not already on.

## Verify it worked

Visit **Configuration → Media → Document Loader**
(`/admin/config/media/document-loader`) — **PHPWord** should now appear as an
available loader. Try loading a sample `.docx` or `.rtf` file from the Document
Loader test tool to confirm extraction works.
