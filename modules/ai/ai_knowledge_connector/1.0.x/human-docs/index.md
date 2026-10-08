# AI Knowledge Connector — manual setup guide

**AI Knowledge Connector** (`ai_knowledge_connector`) connects your Drupal content
to embedding providers and vector stores so that AI features can search it and
ground their answers in your site's own knowledge. It takes entities (such as
nodes), turns their content into **embeddings** through an embedding provider, and
stores those in a **vector store** — the pieces needed for retrieval-augmented
generation (RAG), where an AI answer is backed by relevant passages from your
content rather than the model's general training.

In practice it gives you three things: a place to **manage vector stores**, a place
to **manage the embedding providers** they use, and the **indexing** process that
pushes your entities into those stores and lets you check status or reindex. Once
content is indexed, semantic search and RAG features can look things up and cite
your material.

Because indexing sends content to an embedding provider, it has both a **cost** and
a **data-egress** dimension — each batch of content is sent out to the provider,
and the credentials for that provider must be kept secure and env-backed. The
module ships several permissions covering administration, indexing status,
reindexing, and managing vector stores and providers; restrict them to trusted
roles, since they govern both spending and where your content is sent. This is an
early (alpha) release.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and grant the permissions.

## Where it lives in the admin menu

The module adds an administrative area for managing vector stores and embedding
providers and for running/monitoring indexing. Access is controlled entirely by
its permissions — most importantly **Administer AI Knowledge Connector**, plus
finer-grained ones for viewing indexing status, reindexing, and managing vector
stores and providers. Grant these before anyone can reach the corresponding
screens.

## How to use it

1. Enable the module and grant its permissions to trusted roles (see
   [Installation](installation/index.md)).
2. Configure an embedding provider and a vector store, keeping the provider
   credentials as env-backed secrets.
3. Index your entities into the vector store, and use the indexing-status view to
   confirm coverage or trigger a reindex. Once content is indexed, AI search and
   RAG features can retrieve and ground answers in it.
