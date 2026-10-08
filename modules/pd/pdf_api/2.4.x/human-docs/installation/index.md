# Installation

## Requirements

PDF API needs:

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- Four PHP PDF libraries, which Composer installs for you automatically — one per
  bundled backend:
  - **`dompdf/dompdf`** (`>=2.0.4`) — pure-PHP, no external binary.
  - **`mpdf/mpdf`** (`^8.2.0`).
  - **`tecnickcom/tcpdf`** (`^6.8 || ^6.7.5`).
  - **`mikehaertl/phpwkhtmltopdf`** (`^2.3`) — a wrapper around the external
    **`wkhtmltopdf`** binary, which must be installed on the server if you use that
    backend.

Because those libraries come in through Composer, install the module with Composer
rather than by downloading a zip — that is how the libraries reach your site. The
module has no other Drupal module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/pdf_api -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the four PDF
libraries and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/pdf_api -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en pdf_api -y
```

That's all that is needed for the four bundled backends. The Dompdf settings page
becomes available at `/admin/config/system/pdf-api` — see
[Configuration](../configuration/index.md).

## Optional submodule — puphpeteer

PDF API ships one optional submodule, **puphpeteer**, which adds a fifth backend
that renders PDFs with headless Chrome via Puppeteer. It is **not** enabled by
default because it needs Node.js and the Puppeteer library set up on the server.
Enable it only if you need that backend:

```bash
drush en puphpeteer -y
```

Its own documentation covers the extra Node.js/Puppeteer setup.
