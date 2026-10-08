# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **GraphQL** module (`graphql`) — and in practice the **GraphQL Core
  Schema** module, since the search field extends its `core_composable` schema.
- The **Search API** module (`search_api`) with at least one index configured.

There are no additional Composer or PHP library requirements.

> **Heads-up:** This module is *not covered* by Drupal's security advisory
> policy and is minimally maintained. Review it before relying on it in
> production.

## Install with Composer

From the project root:

```bash
composer require drupal/graphql_search_api_query -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/graphql_search_api_query -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable it together with GraphQL and Search API:

```bash
drush en graphql search_api graphql_search_api_query -y
```

## Verify it worked

There is no settings page. Confirm you have an indexed Search API index, then
open GraphiQL or your GraphQL explorer and check that a `searchApiQuery` field
appears in the schema and returns results. If it isn't there, rebuild caches
(`drush cr`) and confirm you're using the `core_composable` schema.
