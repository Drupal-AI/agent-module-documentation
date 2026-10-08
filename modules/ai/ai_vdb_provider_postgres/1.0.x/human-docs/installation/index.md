# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- The **AI** module (`ai`) — the layer this provider plugs into. Configure it with
  a working provider so content can be turned into embeddings.
- The **Key** module (`key`) — used to store the Postgres password as a secret.
- A **PostgreSQL server with the pgvector extension available**. This module uses
  pgvector to store and query embeddings; it does **not** install the extension.
  The Postgres server can be the site's own database or a separate host you point
  it at, but pgvector must be present — the connection test on the settings form
  is where a missing extension will show up.

The AI and Key modules are enabled automatically as dependencies when you turn
this module on.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_vdb_provider_postgres -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in and update the AI
and Key dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ai_vdb_provider_postgres -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_vdb_provider_postgres -y
```

Enabling it registers Postgres/pgvector as an available vector database. Next,
enter the connection details and test them — see
[Configuration](../configuration/index.md).
