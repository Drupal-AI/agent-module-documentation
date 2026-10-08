# AI Vector DB: Elasticsearch — manual setup guide

**AI Vector DB: Elasticsearch** (`ai_vdb_provider_elasticsearch`) lets Drupal's AI
module store and search its vectors in **Elasticsearch**. A vector database is
where AI semantic-search and RAG (retrieval-augmented generation) features keep
the numeric fingerprints — *embeddings* — of your content, so it can be searched
by meaning rather than exact keywords. This module registers Elasticsearch as one
of those backends, so any AI feature built on the AI module's search layer can
keep its embeddings in an Elasticsearch cluster.

Elasticsearch is a search-and-analytics engine you run yourself (self-hosted or as
a managed cluster such as Elastic Cloud). This module talks to it over the network
using the cluster's address and credentials — the vector store is your
Elasticsearch cluster, which you provision and secure separately from Drupal.

Keep the data-handling in mind. The credentials to reach Elasticsearch are a
secret, so the module uses the **Key** module — store them as a Key (backed by an
environment variable), not in plain configuration, and secure the cluster itself.
The content you index is also sent to your configured **AI provider** to generate
the embeddings (data egress + cost). And because a vector index is not governed by
Drupal's permissions by default, restrict what you index and make sure any search
you expose does not surface content a viewer shouldn't see. This module has no
access-control role of its own. It supports Drupal 10.3 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside the AI, AI Search, Key, and Search API modules.
2. [Configuration](configuration/index.md) — store the Elasticsearch credentials
   as a Key and point the AI Search backend at your cluster.

## Where it lives in the admin menu

There is no standalone settings page. You select Elasticsearch as the vector
database while setting up AI Search through Search API, under **Configuration →
Search and metadata → Search API** (`/admin/config/search/search-api`). The
cluster credentials are created first under **Configuration → System → Keys**
(`/admin/config/system/keys`).
