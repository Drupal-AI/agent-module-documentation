# Azure AI Search VDB Provider — manual setup guide

**Azure AI Search VDB Provider** (`ai_vdb_provider_azure_ai_search`) lets Drupal's
AI module use **Microsoft Azure AI Search** as its vector database. A vector
database is where AI "semantic search" and RAG (retrieval-augmented generation)
features keep the numeric fingerprints — *embeddings* — of your content so they
can be searched by meaning rather than by exact keyword. This module registers
Azure AI Search as one of those storage backends, so any AI feature built on the
AI module's search layer can store and query its vectors in Azure.

Azure AI Search is a **managed cloud service from Microsoft** — you provision a
search service in the Azure portal and get an endpoint URL and an API key. This
module connects to that service over the network, so there is nothing to install
on your own server beyond the Drupal modules; the vector store lives in Azure.

Two data-handling points matter. First, the API key is a secret: the module
integrates with the **Key** module, so store the Azure credential as a Key (backed
by an environment variable), never in plain configuration, and always use the
HTTPS Azure endpoint. Second, the embeddings and the content they represent are
sent to Azure (data egress) — make sure that is acceptable for the content you
index. The module has no access-control role, so also make sure whatever AI search
you build on top only surfaces content the viewer is allowed to see. It is marked
experimental and supports Drupal 10.2 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside the AI, AI Search, Key, and Search API modules.
2. [Configuration](configuration/index.md) — store the Azure key as a Key entity
   and point the AI Search backend at your Azure endpoint.

## Where it lives in the admin menu

There is no standalone settings page. You select Azure AI Search as the vector
database when you set up AI Search through Search API, under **Configuration →
Search and metadata → Search API** (`/admin/config/search/search-api`). The Azure
credential is created first under **Configuration → System → Keys**
(`/admin/config/system/keys`).
