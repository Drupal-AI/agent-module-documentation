# Installation

## Requirements

- **Drupal 8, 9, 10 or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core **Field** (`field`).
- **Search API Solr**, version **4.x or newer** (`search_api_solr >= 4.x`), with a
  working Solr server and index — the boosting works by altering Solr indexing and
  queries, so a Solr backend is essential.

There are no third-party PHP library requirements.

> **Note:** this 2.0.x release is a **beta** (2.0.0-beta3) and the project is
> minimally maintained. Test it before relying on it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/search_api_solr_boosted_keyword -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/search_api_solr_boosted_keyword -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en search_api_solr_boosted_keyword -y
```

## Verify it worked

Go to **Structure → Content types → &lt;a content type&gt; → Manage fields** and add
a field. **Search API Solr: Boosted Keyword** should appear in the list of
available field types. Add it, include it in your Solr index, and reindex to put
the boosting to work.
