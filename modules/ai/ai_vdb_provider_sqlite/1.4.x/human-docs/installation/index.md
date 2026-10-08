# Installation

## Requirements

- **Drupal 10.2+ or 11** (`core_version_requirement: ^10.2 || ^11`).
- The **[AI](https://www.drupal.org/project/ai)** module (`ai`), together with
  its AI Search stack, since this provider is a backend for AI vector search.
- The **`sqlite-vec`** SQLite extension available to the PHP/SQLite environment
  that runs the store. This is what gives SQLite its vector search capability.

There are no API keys, hosts, or external services to provision — the store is a
local SQLite database.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_vdb_provider_sqlite -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ai_vdb_provider_sqlite -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_vdb_provider_sqlite -y
```

This pulls in the AI module as a dependency. Once enabled, continue to
[Configuration](../configuration/index.md).

> **Experimental:** this module is experimental. Test it before relying on it in
> production.
