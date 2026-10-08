# Installation

## Requirements

- **Drupal 8.8, 9, 10 or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- Core **Views** (`views`).
- **Search API** (`search_api`) and **Search API Solr** (`search_api_solr`), with a
  working Solr server and index.
- **User Reference Field Cache Context** (`user_ref_field_cache_context`) — required
  to cache the personalised search results correctly.

There are no third-party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/search_api_solr_boost_by_user_term -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — it will also pull in the User Reference Field Cache
Context dependency.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/search_api_solr_boost_by_user_term -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en search_api_solr_boost_by_user_term -y
```

## Verify it worked

Edit a View based on a Search API Solr index and open the list of filters to add.
The **Boost by User Term** filter should be available, letting you pick a user
field and a node field to boost against.

> **Using Acquia Search?** Uncheck **Enable eDisMax** in the "Acquia Search Solr"
> fieldset for your index — otherwise this module's boost will have no effect.
