# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- The **Search API** module (`search_api`) — this is a Search API backend, so it's
  required.
- The **`algolia/algoliasearch-client-php`** PHP library (v4), pulled in
  automatically by Composer.
- An **Algolia account** with an Application ID and a **Write** API Key.
- *Optional:* the **Search API Autocomplete** module
  (`drupal/search_api_autocomplete` `^1.9`) if you want autocomplete via Algolia
  Query Suggestions.

## Install with Composer

From the project root:

```bash
composer require drupal/search_api_algolia -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Search API and the
Algolia PHP client library and update any shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/search_api_algolia -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en search_api_algolia -y
```

This also enables Search API if it is not already on.

## Get your Algolia credentials

You'll need two values from your Algolia dashboard (under **API Keys**,
`https://algolia.com/account/api-keys`):

- your **Application ID**, and
- a **Write API Key** (the admin/write key, not the search‑only key).

Treat the Write API Key as a secret. Store it via the **Key** module or an
environment variable rather than committing it into exported configuration.

## Submodules

Algolia Search ships no submodules.

## Next steps

Head to [Configuration](../configuration/index.md) to add the Algolia server and
point an index at it.
