# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Recurring Dates Field** module (`date_recur`) — provides the recurring‑date
  fields being indexed.
- The **Search API** module (`search_api`) — the search framework this integrates
  with.
- The **Computed Field** module — used for the computed occurrence date placed on
  each indexed item.
- No third‑party PHP library requirements.

> **Recommended:** *Search API Common Fields*, if you want to share common fields
> between the recurring‑date datasources and Search API's built‑in Content
> datasources.

> This is a **beta** release (1.0.0‑beta2).

## Install with Composer

From the project root:

```bash
composer require drupal/date_recur_search_api -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Recurring Dates
Field, Search API, Computed Field, and any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/date_recur_search_api -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en date_recur_search_api -y
```

Drush will enable Recurring Dates Field, Search API, and Computed Field as
dependencies if they are not already on.

## Verify it worked

Edit a **Search API index** (**Configuration → Search and metadata → Search API**).
When choosing datasources, you should see a **Date occurrences** datasource for
entity types that have a recurring‑date field. Enabling it, adding the computed
occurrence field, and reindexing should produce one search item per occurrence. See
["How to use it"](../index.md#how-to-use-it-post-installation) for the full
configuration steps.
