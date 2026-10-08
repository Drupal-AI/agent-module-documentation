# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- The **GraphQL** module (`graphql`).
- The **GraphQL Core Schema** module (`graphql_core_schema`) — the module hooks
  into its route out of the box. (You can use it with a custom schema, but that
  requires writing your own route subscriber; see the module's index page.)

There are no additional Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/graphql_extra_cache -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/graphql_extra_cache -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Make sure GraphQL and GraphQL Core Schema are enabled, then turn on the module:

```bash
drush en graphql graphql_core_schema graphql_extra_cache -y
```

## Verify it worked

There is no settings page to check. Run the same GraphQL query twice and compare
response times — the second request should be noticeably faster as it is served
from the new cache layer. Then follow the correctness test on the
[module index page](../index.md) to confirm access-controlled queries are not
cached across users.
