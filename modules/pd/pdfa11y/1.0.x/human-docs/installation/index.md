# Installation

## Requirements

- **PHP 8.1 or newer** (`php: >=8.1`).
- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- Core's **Media** module (`media`) and **File** module (`file`) — PDFa11y checks
  PDFs uploaded through media forms.
- The **`smalot/pdfparser` ^2.0** PHP library, which parses the PDFs. Composer
  installs it automatically as a dependency.

## Install with Composer

From the project root:

```bash
composer require drupal/pdfa11y -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
as needed, and it pulls in the `smalot/pdfparser` library for you — there is no
separate download step.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/pdfa11y -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en pdfa11y media file -y
```

## Verify it worked

Open **Configuration → Media → PDFa11y** (`/admin/config/media/pdf-accessibility`).
If the settings form loads, the module is installed. Complete the setup in
[Configuration](../configuration/index.md), then upload a PDF through a media form
and open its **Accessibility** tab to see the check results.
