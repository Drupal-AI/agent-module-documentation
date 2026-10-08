# ES Attachment — manual setup guide

**ES Attachment** (`es_attachment`) makes the *contents* of uploaded documents —
PDFs and similar files — searchable through Elasticsearch. It uses Elasticsearch's
**ingest / attachment pipeline** to extract the text inside a document server‑side
so that text becomes part of your full‑text search index, not just the file's name
or metadata.

It is a glue/integration module that sits on top of the Drupal search stack: it
depends on **Search API**, **Elasticsearch Connector** (for Elasticsearch 8.x) and
**Search API Attachments**. It is a modern fork/rewrite of the older
*search_api_elasticsearch_attachments* project, brought up to date for the current
Elasticsearch Connector and Search API Attachments.

A word on data handling: to extract text, document contents are **sent to your
Elasticsearch cluster** (egress). Confirm that is acceptable for any sensitive
documents you index, and rely on Search API's normal access handling so that
indexed document text is not exposed to users who should not see it. The module
itself plays no access‑control role.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its search‑stack dependencies.

This module has **no settings form of its own**. It works within your existing
Search API + Elasticsearch configuration; the document‑content indexing is set up
as part of your Elasticsearch index and Search API Attachments fields, described in
"How to use it" below.

## How to use it

ES Attachment is one piece of a larger search setup, so it assumes you already have
(or are building) a Search API index backed by Elasticsearch Connector:

1. Have a working **Elasticsearch** server (8.x) connected through **Elasticsearch
   Connector**, and a **Search API** index pointed at it.
2. Use **Search API Attachments** to add the file/attachment field(s) whose
   contents you want to extract to your index.
3. With ES Attachment enabled, the extraction of document text runs through
   Elasticsearch's ingest pipeline as the index is populated, so the extracted text
   becomes searchable.
4. Reindex, then confirm that searching for a word that appears *inside* a PDF (not
   in its title) returns the expected content.

> **Note:** The project notes that using nested documents (for example media) may
> require a patch from the Search API Attachments issue queue — check that project
> if your attachments are attached as media rather than directly on the entity.
