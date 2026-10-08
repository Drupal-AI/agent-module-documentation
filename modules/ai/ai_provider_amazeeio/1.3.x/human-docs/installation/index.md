# Installation

## Requirements

- **Drupal 10.4 or 11** (`core_version_requirement: ^10.4 || ^11`).
- **AI (AI Core)** (`drupal/ai`, `^1.3`) — the module registers its provider with
  AI Core.
- **Key** (`drupal/key`) — the provisioned amazee.ai credentials are stored as
  Key entities.
- **Search API** (`drupal/search_api`, `>1.20`) — a declared dependency.
- The **pgsql** PHP extension (`ext-pgsql`) — required by the Postgres/pgvector
  vector-database provider.
- An **amazee.ai account** (or the anonymous free trial) and network access to
  amazee.ai for authentication and live calls.

Composer installs the module dependencies automatically.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_provider_amazeeio -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install AI Core, Key, and
Search API and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ai_provider_amazeeio -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_provider_amazeeio -y
```

Enabling the module creates two Key entities (`amazeeio_ai` and
`amazeeio_ai_database`) that will hold the provisioned secrets once you connect.

> The module also ships a hidden test helper submodule
> (`ai_provider_amazeeio_test`); it's for the module's own test suite only and
> should not be enabled on a real site.

## Verify it worked

Go to **Configuration → AI → AI Providers → amazee.ai Authentication**
(`/admin/config/ai/providers/amazeeio`). If the authentication form loads, the
module is active. Continue with [Configuration](../configuration/index.md) to
connect your amazee.ai account.
