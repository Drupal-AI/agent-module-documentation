# Drupal RAG — manual setup guide

**Drupal RAG** (`drupal_rag`) turns your Drupal site into a **Retrieval‑Augmented
Generation (RAG)** system. It indexes your content and media as vector
embeddings, and at query time retrieves the most relevant pieces to give a large
language model grounded, site‑specific context — so an AI can answer questions
using *your* content rather than its general training. Crucially, it does this
**without sending your data to third‑party services**: embeddings and generation
run against a local (or on‑network) **Ollama** server, and the vectors live in
your own PostgreSQL database.

The problem it solves is natural‑language search and Q&A over content you already
have — internal knowledge bases, technical documentation, public records,
document archives, customer support — where privacy matters and shipping content
off to a hosted AI vendor is not acceptable.

Here is how it works. When content is created, updated, or deleted, the module
queues the entity, extracts its text (files like PDF/DOCX/TXT are parsed;
everything else is rendered through a configured view mode and stripped of HTML),
splits the text into overlapping chunks that respect sentence boundaries, sends
each chunk to Ollama to produce an embedding, and stores the chunks and vectors in
a **pgvector**‑enabled PostgreSQL table (with an HNSW index for fast similarity
search). It then exposes three API endpoints: `POST /api/rag/query` returns the
most similar chunks with scores, `POST /api/rag/prompt` returns an assembled
prompt (context + your query) ready for any LLM, and `POST /api/rag/augment`
sends that prompt to Ollama and returns the generated answer plus its sources.

This module needs real infrastructure: **Drupal 11**, **PostgreSQL with the
pgvector extension**, and an **Ollama** server running locally or on your network.
Everything else is configured from a single settings form.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, meet the
   PostgreSQL/pgvector and Ollama requirements, and enable the module.
2. [Configuration](configuration/index.md) — choose which entity types to index
   and tune chunking, the Ollama connection, models, and the prompt template.

## Where it lives in the admin menu

Once enabled, the settings form is at **Configuration → Search and metadata →
Drupal RAG** (`/admin/config/search/drupal-rag`). The three query/prompt/augment
API endpoints are served under `/api/rag/*` and are meant to be called from your
own front‑end or integration code.
