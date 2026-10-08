# Installation

## Requirements

- **Drupal 11.1+** (`core_version_requirement: ^11.1`).
- Core's **JSON:API** module (`jsonapi`) and **User** module (`user`) — enabled
  automatically as dependencies.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/jsonapi_include -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/jsonapi_include -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en jsonapi_include -y
```

Enabling it also enables core JSON:API if it isn't on already. By default, **every**
JSON:API response is now flattened — there's nothing else you must do. If you'd rather
opt in per request instead, see [Configuration](../configuration/index.md).

## Verify it worked

Request a JSON:API endpoint with an include, for example
`/jsonapi/node/article?include=field_tags`. Instead of a separate `included` array, each
article's tags should now appear inline under `field_tags`.
