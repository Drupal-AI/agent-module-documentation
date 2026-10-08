# Installation

## Requirements

- **Drupal 10.4 or 11** (`core_version_requirement: ^10.4 || ^11`).
- The **AI** module (`drupal/ai` `^1.3`) — the core AI framework this plugs into.
- The **Key** module (`drupal/key`) — used to store the provisioned credentials
  securely.
- **Search API** (`drupal/search_api` `>1.20`) — for the vector-database / AI Search
  integration.
- The PHP **PDO** and **PDO PostgreSQL** extensions (`ext-pdo`, `ext-pdo_pgsql`) —
  required for the pgvector vector-database features.
- An **amazee.ai account** — but you don't need one in advance; you can start an
  anonymous free trial (30 days, no credit card) right inside the provider's
  settings form.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_provider_amazeeio -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update the AI module, Key,
Search API, and other shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ai_provider_amazeeio -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_provider_amazeeio -y
```

This also enables the AI and Key modules if they aren't already on. The module's
own test submodule (`ai_provider_amazeeio_test`) is a hidden testing helper and is
not meant to be enabled on real sites.

## Verify it worked

Log in as an administrator and go to **Configuration → AI → AI Providers →
amazee.ai** (`/admin/config/ai/providers/amazeeio`). You should see the connection
form (starting with an email field), not a raw API-key field — that's expected. See
[Configuration](../configuration/index.md) to complete the connection.
