# Installation

## Requirements

- **Drupal 9 or newer** (`core_version_requirement: >=9`).
- The **GraphQL** module (`graphql`) and its **GraphQL Core** submodule
  (`graphql_core`) — the module overrides GraphQL's query processor, so these
  must be present.

There are no additional Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/graphql_fragment_include -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/graphql_fragment_include -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable it together with GraphQL and GraphQL Core:

```bash
drush en graphql graphql_core graphql_fragment_include -y
```

## Verify it worked

Go to **Configuration → GraphQL → Fragment Include**
(`/admin/config/graphql/fragment-include`) and confirm the settings form loads.
Then follow [Configuration](../configuration/index.md) to point it at a
fragments directory and try an `# include` in a query.
