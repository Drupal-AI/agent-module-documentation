# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9.0 || ^10.0 || ^11`).
- No contributed module dependencies beyond Drupal core.
- An account with a supported **PDF generator service** (Puppeteer as a managed
  service) — **Doppio.sh** (recommended) or **Browserless.io** — and its API key.

## Install with Composer

From the project root:

```bash
composer require drupal/page_to_pdf -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/page_to_pdf -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en page_to_pdf -y
```

The project's machine name is `page_to_pdf` even though its display name is
*Soapbox PDF*.

## Verify it worked

Complete the three configuration steps in [Configuration](../configuration/index.md)
— store the API key, add a PDF field to a content type, and enable Page to PDF on
that type — then save a node of that type and confirm a generated PDF is stored in
the field.
