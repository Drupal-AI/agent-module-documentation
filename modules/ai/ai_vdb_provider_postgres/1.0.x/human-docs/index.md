# Postgres VDB Provider — manual setup guide

**Postgres VDB Provider** (`ai_vdb_provider_postgres`) lets Drupal's AI module
store and query its vectors in a **PostgreSQL** database using the **pgvector**
extension, instead of a dedicated vector service. A vector database is where AI
semantic-search and RAG (retrieval-augmented generation) features keep the numeric
fingerprints — *embeddings* — of your content, so it can be searched by meaning
rather than exact keywords. pgvector turns a Postgres database into a competent
vector store, and this module registers it as one of the AI module's backends.

The appeal is the same as the MariaDB provider: if your stack already runs
PostgreSQL, the embeddings live beside the rest of your data, in the same backup
and the same security boundary, with no extra vendor or service to operate. Because
it registers through the AI module's abstraction, anything built on that layer —
search, RAG pipelines, semantic similarity — can use it, and swapping to a
different backend later is a configuration change rather than a rewrite. The main
performance lever is the pgvector **index strategy**, which trades off build time,
memory, and recall.

Credential handling here is done the right way: the settings form uses a Key
selector and stores the **Key entity's id**, not the password itself; the actual
secret is only read in memory to test the connection. So store the database
password as a Key (backed by an environment variable), and nothing sensitive ends
up in exported configuration.

Two caveats. The Postgres server must have the **pgvector extension available** —
this module does not install it, and the connection test on the settings form is
where you will find out if it is missing. And the module is marked
**experimental** (release 1.0.0-alpha3), so treat its API as unsettled. It
supports Drupal 10.2 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, confirm pgvector
   is available, and enable the module.
2. [Configuration](configuration/index.md) — enter the Postgres connection, pick a
   Key for the password and an index strategy, and test the connection.

## Where it lives in the admin menu

Unlike the other vector-database providers, this one has its own settings form at
`ai_vdb_provider_postgres.settings_form`, reached under the site's AI
configuration (**Configuration → AI**). The database password is created first as
a Key under **Configuration → System → Keys** (`/admin/config/system/keys`).
