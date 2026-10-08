# Installation

## Requirements

Drupal RAG has real infrastructure dependencies beyond the module itself:

- **Drupal 11** (`core_version_requirement: ^11`).
- Core **System**, **Node**, and **Media** modules (`system`, `node`, `media`) —
  enabled automatically as dependencies.
- **PostgreSQL with the `pgvector` extension** — the module stores embeddings in
  a native vector column with an HNSW index, so your Drupal database must be
  PostgreSQL and pgvector must be installed and enabled on it.
- An **Ollama** server running locally or on your network, with an embedding
  model pulled (for example `nomic-embed-text`) and, optionally, a chat model for
  answer generation.

> This is an alpha release (`1.0.0-alpha5`) and is not covered by Drupal's
> security advisory policy — evaluate it carefully before production use.

## Install with Composer

From the project root:

```bash
composer require drupal/drupal_rag -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/drupal_rag -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Prepare PostgreSQL and Ollama

Before enabling, make sure the infrastructure is ready:

1. Confirm Drupal is running on **PostgreSQL** and that the **pgvector**
   extension is installed and enabled on that database.
2. Make sure your **Ollama** server is reachable from the Drupal web container,
   and that you have pulled an embedding model (and optionally a chat model).

Because Ollama runs locally/on your network, no third‑party API key is required
and your content is not sent to an external AI vendor. What you do need is
network reachability from Drupal to the Ollama endpoint.

## Enable the module

```bash
drush en drupal_rag -y
```

## Verify it worked

Open **Configuration → Search and metadata → Drupal RAG**
(`/admin/config/search/drupal-rag`) and confirm the settings form loads and can
list embedding models fetched live from your Ollama server (a good sign the
connection works). Then configure it (see
[Configuration](../configuration/index.md)), let some content index, and try a
`POST /api/rag/query` request to confirm you get back relevant chunks with
similarity scores.
