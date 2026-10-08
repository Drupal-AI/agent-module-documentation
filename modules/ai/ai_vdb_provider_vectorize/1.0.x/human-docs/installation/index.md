# Installation

## Requirements

- **Drupal 10.5+, 11, or 12** (`core_version_requirement: ^10.5 || ^11 || ^12`).
- The **[AI](https://www.drupal.org/project/ai)** module (`ai`) and its
  **AI Search** submodule (`ai_search`).
- The **[Search API](https://www.drupal.org/project/search_api)** module
  (`search_api`).
- The Cloudflare SDK stack: **`cloudflare_ai`**, **`cloudflare_sdk`**, and
  **`cloudflare_api`** — these carry the Cloudflare account connection and
  credentials.
- A **Cloudflare account** with Vectorize enabled and API access.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_vdb_provider_vectorize -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Cloudflare
SDK modules and any shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ai_vdb_provider_vectorize -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_vdb_provider_vectorize -y
```

This ensures `ai`, `ai_search`, `search_api`, and the `cloudflare_*` modules are
enabled as well. Once on, continue to [Configuration](../configuration/index.md).

> **Note:** this release is an alpha (1.0.0‑alpha3). Test before relying on it in
> production.
