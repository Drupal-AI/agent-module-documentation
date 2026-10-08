# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- A decoupled **Nuxt** front end running the `nuxt-multi-cache` Nuxt module, with a
  reachable cache endpoint Drupal can send purge requests to. This is what the
  module talks to; without it there is nothing to invalidate.
- If you serve the front end through GraphQL, you will also want the GraphQL stack
  the **`graphql_nuxt_multi_cache`** submodule integrates with.

There are no third‑party PHP library requirements on the Drupal side.

## Install with Composer

From the project root:

```bash
composer require drupal/nuxt_multi_cache -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/nuxt_multi_cache -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en nuxt_multi_cache -y
```

## Submodules — enable only what you need

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **GraphQL Nuxt Multi Cache** | `graphql_nuxt_multi_cache` | Integration for sites that serve the Nuxt front end through GraphQL. Enable it if your decoupled stack uses GraphQL. |
| **Nuxt Multi Cache Purger** | `nuxt_multi_cache_purger` | The purge integration that sends invalidation requests to the Nuxt cache endpoint. Enable it to actually perform purges. |

Enable a submodule with `drush en`, for example:

```bash
drush en nuxt_multi_cache_purger -y
```

## Verify it worked

After enabling and [configuring](../configuration/index.md) the endpoint and
credentials, change and save a piece of content in Drupal and confirm the
corresponding Nuxt cache entry is purged (for example, the front‑end page reflects
the change on the next request). Check the site logs if purge requests are not
reaching the endpoint.
