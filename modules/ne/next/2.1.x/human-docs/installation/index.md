# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- These contributed modules, all pulled in by Composer as dependencies:
  - **Decoupled Router** (`drupal/decoupled_router`, `^2.0`) — resolves a front-end
    path back to a Drupal entity.
  - **Simple OAuth** (`drupal/simple_oauth`, `^5.0 || ^6.0`) — signs the default
    preview URLs.
  - **Subrequests** (`drupal/subrequests`, `^3.0`) — lets the front end batch
    JSON:API requests.
  - **Pathauto** (`drupal/pathauto`, `^1.11`) — provides the aliases the front end
    uses.
- A running **Next.js application** (built with `next-drupal`) that this module will
  talk to — it lives outside Drupal.

## Install with Composer

From the project root:

```bash
composer require drupal/next -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the four
dependencies above and update any shared packages as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/next -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en next -y
```

The four dependency modules are enabled automatically.

## Choose the data-layer and extra submodules

The base `next` module handles preview and revalidation, but the front end also needs
a way to read content. Enable the submodule(s) that match your build:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Next.js JSON:API** | `next_jsonapi` | Serves content over JSON:API and lets you cap the page size for the front end. The common choice. |
| **Next.js GraphQL** | `next_graphql` | Serves content over GraphQL (via graphql_compose) instead of JSON:API. |
| **Next.js JWT** | `next_jwt` | Adds a JWT-based, user-scoped preview URL generator as an alternative to the default OAuth one. |
| **Next.js Extras** | `next_extras` | Additional editor/integration conveniences. |

For a typical JSON:API-based site:

```bash
drush en next_jsonapi -y
```

## Next steps

Enabling the module does not connect anything yet — you need to register your
Next.js front end and map content to it. Continue to
[Configuration](../configuration/index.md), which also explains how to keep the
preview and revalidate **secrets** out of version control.
