# OpenAI VDB Provider — manual setup guide

**OpenAI VDB Provider** (`ai_vdb_provider_openai`) lets Drupal's AI module use
**OpenAI** as its vector database. A vector database is where AI semantic-search
and RAG (retrieval-augmented generation) features keep the numeric fingerprints —
*embeddings* — of your content, so it can be searched by meaning rather than exact
keywords. This module registers OpenAI as one of those storage backends, so
embedding storage and similarity search route through OpenAI's service rather than
a database you host.

It builds on the existing **OpenAI provider** for Drupal (`ai_provider_openai`)
and the AI module's **AI Search** layer, and it reuses the same OpenAI API key
that provider already uses — stored via the **Key** module and backed by an
environment variable. There is no separate server or cluster to run; the vectors
live in OpenAI's service, reached over the network.

Be deliberate about cost and data. Storing and querying embeddings sends vectors
and text to OpenAI, which is billed by OpenAI and means your content leaves the
site (data egress). Because a vector index is not governed by Drupal's permissions
by default, restrict what you index and make sure any search you expose does not
surface content a viewer shouldn't see. This module is marked **experimental** and
supports Drupal 10.4 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside the AI module, the OpenAI provider, and Key.
2. [Configuration](configuration/index.md) — make sure the OpenAI key is stored as
   a Key and select OpenAI as the AI Search vector database.

## Where it lives in the admin menu

There is no standalone settings page. It reuses the OpenAI credential you set up
for the OpenAI provider (under the AI configuration and **Configuration → System →
Keys**, `/admin/config/system/keys`), and you select OpenAI as the vector database
while configuring AI Search under **Configuration → Search and metadata → Search
API** (`/admin/config/search/search-api`).
