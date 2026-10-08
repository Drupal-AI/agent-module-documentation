# Installation

## Requirements

- **Drupal 8, 9 or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- Core **Search** (`search`) and the **Token** (`token`) module, enabled as
  dependencies.
- A **Google Programmable Search Engine** with its Search Engine ID (`cx`) and a
  **Google API key** — see [Configuration](../configuration/index.md).

## Install with Composer

From the project root:

```bash
composer require drupal/google_json_api -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/google_json_api -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en google_json_api -y
```

## Verify it worked

Go to **Configuration → Search and metadata → Google JSON API**
(`/admin/config/search/google-json-api`) — the global settings form should load. Then
continue to [Configuration](../configuration/index.md) to create a search page backed
by your Programmable Search Engine.
