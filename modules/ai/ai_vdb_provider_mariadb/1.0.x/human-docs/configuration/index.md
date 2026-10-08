# Configuration

Unlike the cloud vector-database providers, MariaDB needs no external endpoint and
no API key — the vectors live in a MariaDB database. Configuration is mostly a
matter of confirming your server can store vectors and then choosing MariaDB as
the vector store for your AI search.

## 1. Confirm MariaDB supports vectors

This provider relies on MariaDB's built-in vector support. Make sure the MariaDB
server your site uses is a version that provides vector columns and vector search.
The module does not install or enable that capability — if the server lacks it,
storing or querying embeddings will fail.

## 2. Select MariaDB as the vector database

MariaDB is chosen within the AI module's vector-database configuration (under
**Configuration → AI**) when you set up an AI search / RAG feature: pick **MariaDB**
as the vector database provider so that embeddings are stored in MariaDB rather
than an external service. Once selected, index your content so its embeddings are
written into the database.

## 3. Manage the store with Drush

The module ships **Drush commands** for working with the vector store from the
command line (for example to set it up or manage collections). List what is
available with:

```bash
drush list --filter=ai
```

and run the relevant `ai_vdb_provider_mariadb` commands it shows.

## Things to check

- **Content leaves your site to be embedded.** Generating embeddings still calls
  your configured AI provider (cost + data egress); only the resulting vectors are
  stored locally in MariaDB.
- **Respect access.** The stored embeddings represent your content, so make sure
  any AI search you build on top does not surface content a viewer shouldn't see —
  a vector index is not governed by Drupal's permissions by default.
- **Back it up.** Because the vectors live in MariaDB, they are included in your
  normal database backups — a convenience, but also account for the added size.
