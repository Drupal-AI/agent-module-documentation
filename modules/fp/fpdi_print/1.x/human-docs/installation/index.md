# Installation

## Requirements

- **Drupal 9.3, 10, 11, or 12** (`core_version_requirement: ^9.3 || ^10 || ^11 || ^12`).
- Core's **Views** module (enabled by default on most sites), since you configure PDF
  printing from a View.
- The **FPDI** and **TCPDF** PHP libraries — you do **not** install these separately;
  requiring the module with Composer adds them to your project's `vendor/` directory
  automatically.

## Install with Composer

From the project root:

```bash
composer require drupal/fpdi_print -W
```

This pulls the module together with the `tcpdf` and `fpdi` libraries into `vendor/`.
The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/fpdi_print -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en fpdi_print -y
```

## Verify it worked

Two quick checks:

1. Visit **`/fpdi-print/validate`** — this helper page confirms the module is active
   and lets you validate a PDF template and a YAML position block.
2. Edit a View and add a global area to its header or footer; the **Pdf Print
   (global)** area should be available to add.

Then follow "How to use it" on the [overview page](../index.md) to point a View at a
PDF 1.4 template. Remember that the data placed on generated PDFs comes from the
view, so confirm the view's field access and serve the resulting PDFs with
appropriate access control.
