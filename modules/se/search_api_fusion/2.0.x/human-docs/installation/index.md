# Installation

## Requirements

Search API Fusion needs:

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- **Search API Solr** (`search_api_solr`), which in turn requires **Search API** —
  Fusion is based on Apache Solr, so the Solr backend is the foundation this
  connector plugs into.
- A running **Lucidworks Fusion** instance, with a Fusion app and a search query
  profile to point at.

Optional feature modules, depending on what you want to use:

- **Search API Autocomplete** (`search_api_autocomplete`) — for autocompletion
  based on Fusion Query Pipelines.
- **Search API Spellcheck** (`search_api_spellcheck`) — for spell checking.
- **Facets** (`facets`) — for faceting.

There are no third-party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/search_api_fusion -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. The Composer package name (`drupal/search_api_fusion`)
matches the module's machine name (`search_api_fusion`).

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/search_api_fusion -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en search_api_fusion -y
```

This also enables the Search API Solr dependency if it is not already on. Enable
any of the optional feature modules the same way (`drush en
search_api_autocomplete -y`, and so on).

## Verify it worked

Go to **Configuration → Search and metadata → Search API**, click **Add server**,
choose the **Solr** backend, and confirm that **Fusion** appears as an available
Solr connector. From there, follow the steps in the
[main guide](../index.md#how-to-use-it) to point it at your Fusion app.
