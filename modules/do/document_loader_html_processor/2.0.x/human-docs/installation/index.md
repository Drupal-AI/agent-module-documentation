# Installation

## Requirements

- **Drupal 10.4 or 11** (`core_version_requirement: ^10.4 || ^11`), **PHP 8.1+**.
- **Document Loader** (`document_loader`) `^2.0` — the framework this plugs into.
- The **HTML Processor** (`html_processor`) module `^1.0` — the service this bridge
  exposes.

## Install with Composer

From the project root, install this module together with HTML Processor (Composer
also pulls in Document Loader):

```bash
composer require drupal/html_processor drupal/document_loader_html_processor -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require … -W`, `ddev drush …`. Inside the container
> (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en document_loader_html_processor -y
```

## Submodule — URL fetching (opt-in)

This package includes an optional submodule,
**`document_loader_html_processor_url`**, which is **disabled by default**. Enable it
only if you want the server to fetch a URL and run the returned HTML through the
pipeline:

```bash
drush en document_loader_html_processor_url -y
```

## Verify it worked

Visit **Configuration → Media → Document Loader**
(`/admin/config/media/document-loader`). The HTML Processor plugin should appear in
the list of available loaders. There is nothing further to configure through the UI
— processing options are supplied in code.
