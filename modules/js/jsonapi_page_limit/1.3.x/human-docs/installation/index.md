# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **JSON:API** (`jsonapi`) module — the only requirement.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/jsonapi_page_limit -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/jsonapi_page_limit -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en jsonapi_page_limit -y
```

Note that the module **will not do anything by itself** until you add configuration
— see "How to use it" on the [overview page](../index.md). You must declare the
`jsonapi_page_limit.size_max` service parameter with the paths and limits you want,
then rebuild the cache.

## Verify it worked

1. Add a `jsonapi_page_limit.size_max` parameter to a custom `services.yml`, for
   example mapping `/jsonapi/node/article` to `100`.
2. Rebuild the cache: `drush cr`.
3. Request that path asking for more than 50 items, for example
   `/jsonapi/node/article?page[limit]=100`.

You should now receive up to 100 items in the response (assuming that many exist),
where before you were capped at 50. Paths you did not list still cap at 50.
