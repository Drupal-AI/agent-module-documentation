# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- The **AI** module (`ai`) — the layer this provider plugs into. It should be
  configured with a working provider so content can be turned into embeddings.
- A **MariaDB server with vector support**. This module uses MariaDB's own vector
  features to store and query embeddings — it does not add that capability, so
  your database server must be a MariaDB version new enough to provide vector
  columns and vector search. If your server does not support vectors, this
  provider will not work.

The AI module is enabled automatically as a dependency. Note that this provider
does **not** require the Key, Search API, or AI Search modules — it works directly
against MariaDB.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_vdb_provider_mariadb -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ai_vdb_provider_mariadb -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_vdb_provider_mariadb -y
```

Enabling it registers MariaDB as an available vector database and adds the
module's Drush commands. Next, select MariaDB as the AI module's vector database —
see [Configuration](../configuration/index.md).
