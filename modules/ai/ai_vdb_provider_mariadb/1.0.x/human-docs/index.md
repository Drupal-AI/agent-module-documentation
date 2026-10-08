# MariaDB VDB Provider — manual setup guide

**MariaDB VDB Provider** (`ai_vdb_provider_mariadb`) lets Drupal's AI module use
**MariaDB Vector** — MariaDB's own built-in vector support — as its vector
database. A vector database is where AI semantic-search and RAG
(retrieval-augmented generation) features keep the numeric fingerprints —
*embeddings* — of your content, so it can be searched by meaning rather than exact
keywords. Instead of running a separate vector service, this module stores those
embeddings in MariaDB, using the vector features of the database engine itself.

The appeal is that it removes a moving part: if your stack already runs MariaDB,
the embeddings live in the same database boundary and backups as the rest of your
data, with no extra vendor, credential, or service to operate. It registers as a
vector-database provider for the AI module, so anything built on the AI module's
abstraction — search, RAG pipelines, semantic similarity — can use it. The module
also ships **Drush commands** to help manage the vector store.

The one hard requirement is that your MariaDB server must actually support vectors
— this module uses that support, it does not add it — so you need a MariaDB
version new enough to provide vector columns and search. On the data side, the
embeddings represent your content, so if you build AI search on top of this, make
sure it respects content access and doesn't surface restricted material through
semantic search. The module has no access-control role of its own. It supports
Drupal 10.2 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, confirm your
   MariaDB server supports vectors, and enable the module.
2. [Configuration](configuration/index.md) — select MariaDB as the AI module's
   vector database.

## Where it lives in the admin menu

There is no standalone settings page. You select MariaDB as the vector database in
the AI module's vector-database configuration (under **Configuration → AI**), and
you manage the store with the module's Drush commands from the command line.
