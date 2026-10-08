# Installation

## Requirements

- **Drupal 10.2 or newer, or Drupal 11** (`core_version_requirement:
  ^10.2 || ^11`).
- The **AI** module (`drupal/ai` `^1.2`) and its **AI Search** submodule
  (`ai_search`) — this module is a vector-database provider *for* the AI ecosystem.
- The **Key** module (`drupal/key` `^1.18`) — used to store the Milvus/Zilliz
  credential securely.
- A reachable **Milvus** server (self-hosted) or a **Zilliz Cloud** account to
  connect to.

Composer pulls the module dependencies in with the command below.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_vdb_provider_milvus -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install AI, AI Search, Key,
and any shared dependencies alongside this module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ai_vdb_provider_milvus -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_vdb_provider_milvus -y
```

This enables the AI, AI Search, and Key modules too if they weren't already on. If
you previously used the older in-`ai` Milvus submodule, this module migrates its
settings automatically on install and uninstalls the old one.

## Next: connect to Milvus

Once enabled, configure the connection and (optionally) the credential Key. See
[Configuration](../configuration/index.md), which also covers running a local
Milvus in DDEV for development.
