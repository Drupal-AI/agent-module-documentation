# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- Core's **System** module (always present).
- An **embedding provider** and a **vector store** to connect to. Because the
  module turns content into embeddings through a provider and stores them in a
  vector store, you need working access to both, along with any provider
  credentials.

Keep provider credentials secure and environment-backed — store them as a secret
(for example an environment variable referenced through a **Key** entity) rather
than pasting them into plain configuration. This is an **alpha** release, so try
it in a non-production environment first.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_knowledge_connector -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ai_knowledge_connector -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_knowledge_connector -y
```

There are no submodules.

## Grant permissions

At **People → Permissions**, grant the module's permissions to the roles that
should manage indexing and infrastructure — these govern both spending and where
your content is sent, so keep them to trusted administrators:

- **Administer AI Knowledge Connector** (`administer ai knowledge connector`) —
  overall administration.
- **View AI indexing status** (`view ai indexing status`).
- **Reindex AI knowledge** (`reindex ai knowledge`).
- **Manage vector stores** (`manage vector stores`).
- **Manage AI providers** (`manage ai providers`).

Once enabled and permissioned, configure a provider and vector store and start
indexing — see [How to use it](../index.md#how-to-use-it).
