# Installation

## Requirements

Search API CLIR needs:

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Language** module (`language`).
- **Search API** (`search_api`).
- **TMGMT Locale** (`tmgmt_locale`), part of the Translation Management Tool
  (TMGMT) project — this is how machine translations are generated and accepted.
- A **Search API Solr** backend. CLIR currently works only with Solr, because
  other backends can't store several language-specific fields in a single record.
- Your **fallback language must be the site's default language**.

Drupal will pull in the module dependencies automatically when you enable CLIR,
but you will need to have the TMGMT project (and a configured translation
provider, such as DeepL, Google, or Microsoft) available for the workflow to
function.

## Install with Composer

From the project root:

```bash
composer require drupal/search_api_clir -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. The Composer package name (`drupal/search_api_clir`)
matches the module's machine name (`search_api_clir`).

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/search_api_clir -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en search_api_clir -y
```

This also enables the Language, Search API, and TMGMT Locale dependencies if they
are not already on.

## Verify it worked

Once enabled, open a Search API index that uses the Solr backend and confirm you
can add a **Language (with fallback)** field and see the option to enable CLIR in
the index's edit form. From there, follow the workflow in the
[main guide](../index.md) to wire up TMGMT continuous jobs and re-index.
