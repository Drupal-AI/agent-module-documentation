# Installation

## Requirements

### Drupal / PHP

- **Drupal 11.4 or newer, or Drupal 12** (`core_version_requirement: ^11.4 || ^12`).
- Core's **File** module (`file`), enabled automatically as a dependency.
- The PHP **mbstring** extension (`ext-mbstring`) — used to safely truncate
  extracted text. Most Drupal-ready PHP builds already include it.
- For the command-line backends, the Composer package
  **`symfony/process`** (declared as a suggestion) is required — the CLI
  extractors won't appear until it is installed.

### External extraction tools (pick the one you'll use)

Each extractor backend needs its underlying tool present on the server, and the
backend only shows up in the settings form when its requirement is met:

| Backend | What you need to install |
|---------|--------------------------|
| **pdftotext** | The `pdftotext` binary (from Poppler utils). PDFs only. |
| **Apache Tika (CLI)** | A Java runtime plus the Tika JAR file. Broad format coverage. |
| **Tika server** | A running Apache Tika JAX-RS server reachable over HTTP. |
| **docconv** | The docconv `docd` binary. |
| **Python pdf2txt** | Python with pdfminer's `pdf2txt.py` script. PDFs only. |
| **Search API Solr** | The [Search API Solr](https://www.drupal.org/project/search_api_solr) module and a configured Solr server with the extract handler. |

You only need whichever one you intend to use. The Tika server and Search API
Solr backends talk to a service over the network and do **not** need
`symfony/process`.

## Install with Composer

From the project root:

```bash
composer require drupal/file_extractor -W
```

If you plan to use a command-line backend (pdftotext, Tika CLI, docconv, Python),
also require Symfony Process:

```bash
composer require symfony/process
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/file_extractor -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix. Remember that the
> external tools (pdftotext, Java/Tika, etc.) must be installed **inside** the
> container that serves the site.

## Enable the module

```bash
drush en file_extractor -y
```

## What to do next

Nothing is extracted until you choose and configure an extraction method. Go to
**Configuration → Media → File Extractor** and follow
[Configuration](../configuration/index.md), then use the built-in **Test** form
to confirm your chosen backend works before wiring the formatter or Search API to
it.
