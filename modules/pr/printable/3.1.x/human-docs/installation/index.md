# Installation

## Requirements

- **Drupal 9.4, 10, or 11** (`core_version_requirement: ^9.4 || ^10 || ^11`).
- The **PDF API** module (`drupal/pdf_api` `^2.4.0`) — required for PDF output.
- The **`wa72/htmlpagedom`** PHP library (`^1.3 || ^2.0 || ^3.0`), used to process
  the print HTML — pulled in automatically by Composer.
- Core's **Path alias** module (`path_alias`), enabled automatically as a
  dependency.
- For PDF output only: a **PDF toolkit** — wkhtmltopdf, TCPDF, mPDF, or dompdf —
  configured through PDF API (some toolkits need a system binary installed).

## Install with Composer

From the project root:

```bash
composer require drupal/printable -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in PDF API, the
htmlpagedom library, and any shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/printable -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en printable -y
```

This gives you the printer‑friendly HTML format. Print links and printable pages
are available immediately (subject to configuration and permissions).

## Submodule — printable_pdf (for PDF output)

PDF output lives in the **printable_pdf** submodule (`printable_pdf`). Enable it —
plus a configured PDF toolkit — only if you want downloadable PDFs:

```bash
drush en printable_pdf -y
```

Without this submodule and a selected PDF toolkit, the PDF format is unavailable
and PDF links are suppressed. See [Configuration](../configuration/index.md#pdf-output)
for choosing a toolkit.

## Next steps

Head to [Configuration](../configuration/index.md) to choose which entity types
are printable, place the Print/PDF links, and grant the viewing permission.
