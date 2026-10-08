# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **Search API** module (`drupal/search_api`, `^1`), installed automatically
  as a dependency. You also need a working Search API index and server (for
  example a database or Solr backend) for the extracted text to be searchable.
- An external **text‑extraction tool** for the extractor you choose — for
  example Apache Tika, `pdftotext`, a Python `pdf2txt` script, or `docconv` must
  be installed and reachable on the server. The Solr extractor instead reuses a
  Search API Solr backend.

There are no submodules.

## Install with Composer

From the project root:

```bash
composer require drupal/search_api_attachments -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Search API and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/search_api_attachments -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en search_api_attachments -y
```

Once enabled, configure a text extractor at **Configuration → Search → Search API
Attachments**, then enable the **File attachments** processor on your index — see
[Configuration](../configuration/index.md).
