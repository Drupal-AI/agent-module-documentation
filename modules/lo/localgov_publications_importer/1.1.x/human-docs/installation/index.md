# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Paragraphs** module (`paragraphs`) and **LocalGov Publications**
  (`localgov_publications`) — the importer builds LocalGov HTML publications, so
  that module must be present.
- A **LocalGov Drupal** site (LocalGov Publications expects the distribution).
- For the **optional AI submodule**: the Drupal **AI** module plus at least one AI
  **provider** module (for example the OpenAI provider), and the **Key** module to
  store the provider's API key. See "Optional: the AI submodule" below.

## Install with Composer

From the project root:

```bash
composer require drupal/localgov_publications_importer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install Paragraphs,
LocalGov Publications and shared dependencies alongside it.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/localgov_publications_importer -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en localgov_publications_importer -y
```

## Optional: the AI submodule

To let an LLM clean up the extracted text (producing better headings and lists),
enable the bundled submodule and set up an AI provider:

```bash
drush en localgov_publications_importer_ai -y
```

You will then need to install the Drupal **AI** module and an AI **provider**
module, and configure a provider and API key — the [Configuration](../configuration/index.md)
page walks through this and the cost/privacy implications of sending document text
to an external AI service.

## Verify it worked

Go to **Content → Imports** (`/admin/content/imports`). You should see the imports
listing with an **Import Publication** upload form linked from the top. Upload a
small PDF, then run `drush lpii` (or wait for cron); once processing finishes, the
listing should show a link to the new publication.
