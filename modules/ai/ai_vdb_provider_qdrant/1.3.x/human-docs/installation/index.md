# Installation

## Requirements

- **Drupal 10.2+ or 11** (`core_version_requirement: ^10.2 || ^11`).
- The **[AI](https://www.drupal.org/project/ai)** module (`ai`) and its
  **AI Search** submodule (`ai_search`) — this provider only does anything as a
  backend for AI Search.
- The **[Key](https://www.drupal.org/project/key)** module (`key`) — used to
  store the Qdrant API key as a secret rather than in plain configuration.
- A reachable **Qdrant** instance (self‑hosted or Qdrant Cloud) with an API key.

Drupal will pull the module dependencies (`ai`, `ai_search`, `key`) in with
Composer; you still enable them explicitly if they are not already on.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_vdb_provider_qdrant -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ai_vdb_provider_qdrant -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_vdb_provider_qdrant -y
```

This also ensures `ai`, `ai_search`, and `key` are enabled. Once it is on,
continue to [Configuration](../configuration/index.md) to connect it to your
Qdrant instance.
