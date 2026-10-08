# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **JSON:API** (`jsonapi`) and **User** (`user`) modules — both part of
  Drupal core.

There are no modules outside of core to install, and no third‑party PHP library
requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/jsonapi_links -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/jsonapi_links -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en jsonapi_links -y
```

Enabling the module does not change your responses on its own — you still need to
turn on link removal in the settings form (see
[Configuration](../configuration/index.md)).

## Verify it worked

1. Enable link removal at **Configuration → Web services → JSON:API → Links**
   (`/admin/config/services/jsonapi/links`).
2. Request a JSON:API collection, for example `/jsonapi/node/article`, and confirm
   the `links` members are gone from the response.
3. Request `/jsonapi` (the API root) and confirm its links are still present — this
   path is deliberately exempt.
