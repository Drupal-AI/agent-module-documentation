# Installation

## Requirements

- **Drupal 10.4 or 11** (`core_version_requirement: ^10.4 || ^11`).
- The **GraphQL** module (`graphql`, version **below 4.0** for this branch) and
  its **GraphQL Core** submodule (`graphql_core`), with a configured GraphQL
  server.

There are no additional Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/graphql_twig -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/graphql_twig -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable it together with GraphQL and GraphQL Core:

```bash
drush en graphql graphql_core graphql_twig -y
```

## Verify it worked

There is no settings page. Add a `{#graphql … #}` block to one of your theme's
template overrides (see the example on the [module index page](../index.md)),
clear caches with `drush cr`, and load a page that uses that template — the data
from your query should appear via the `graphql` variable.
