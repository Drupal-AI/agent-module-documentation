# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- Core's **JSON:API** module (`jsonapi`) enabled — this is the only dependency, and
  Drupal enables it automatically as needed.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/jsonapi_response_alter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/jsonapi_response_alter -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en jsonapi_response_alter -y
```

Enabling the module has **no visible effect on its own** — it ships no default
behavior. It simply makes the `hook_jsonapi_response_alter` hook and the
`JsonApiResponseAlterEvent` available for your own module to implement. See the
*How to use it* section of the [overview](../index.md) for the code.

There is no configuration form and no permissions to grant.

## Verify it worked

Add a simple hook implementation in a custom module (for example one that sets a
`meta` key, as shown in the overview), clear caches (`drush cr`), then request any
JSON:API endpoint (such as `/jsonapi/node/article`). Your added key should appear
in the response body, confirming the hook fires.
