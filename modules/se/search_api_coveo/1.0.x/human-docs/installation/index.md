# Installation

## Requirements

Search API Coveo Integration needs:

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ^9.5||^10||^11`).
- **Search API** (`search_api`).
- A **Coveo** organization and an API key with permission to index content and run
  queries.

There are no third-party Composer or PHP library requirements declared by the
module itself.

## Install with Composer

From the project root:

```bash
composer require drupal/search_api_coveo -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. The Composer package name (`drupal/search_api_coveo`)
matches the module's machine name (`search_api_coveo`).

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/search_api_coveo -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en search_api_coveo -y
```

## Submodule

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Search API Coveo Keys** | `search_api_coveo_keys` | Helps manage the Coveo API credentials so keys are stored as secrets rather than in plain configuration. Enable it when you set up the Coveo connection. |

To enable the keys submodule:

```bash
drush en search_api_coveo_keys -y
```

## Verify it worked

Go to **Configuration → Search and metadata → Search API**, click **Add server**,
and confirm that **Coveo** appears as an available backend. From there, follow the
steps in the [main guide](../index.md#how-to-use-it) to connect your Coveo
organization and attach an index.
