# Elasticsearch Connector Autocomplete — manual setup guide

**Elasticsearch Connector Autocomplete** (`elasticsearch_connector_autocomp`)
makes search‑as‑you‑type actually work on an Elasticsearch‑backed Search API
index. By default, Search API + Elasticsearch Connector index whole words, so an
autocomplete box returns nothing until the visitor finishes typing a word. This
module adds an **ngram** (or **edge‑ngram**) analyzer so the index matches on
partial words — results start appearing after the first few characters — which is
exactly what you want for typeahead on product names, usernames, tags, and the
like.

You turn it on **per index**. On the Search API index's edit form the module adds
an *Elasticsearch specific index options* section with an "Enable ngram analyzer"
checkbox and a couple of tuning values. Once enabled, a new **Fulltext (ngram)**
field data type (`text_ngram`) becomes available on the index's Fields tab, so you
can apply partial‑word matching only to the fields that need it (say, title and
name) while leaving everything else on standard fulltext. Behind the scenes the
module injects the right Elasticsearch analysis settings and field mappings for
you, so you never have to hand‑write analyzer JSON.

The module requires **Elasticsearch Connector** (`^8.0@alpha`) and **Search API**
(and core's System module). It has **no settings page of its own**, no
permissions, and no Drush commands — all configuration lives on the Search API
index.

> **Heads‑up — enabling ngram rebuilds the index.** Changing the ngram setting on
> an index that already exists deletes and rebuilds that index, which means you
> must re‑index all its content. The form shows a confirmation step before doing
> this.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside Elasticsearch Connector and Search API.
2. [Configuration](configuration/index.md) — enable the ngram analyzer on an index
   and apply the *Fulltext (ngram)* type to fields.

## Where it lives in the admin menu

There is no dedicated page. You configure everything on your Search API index at
**Configuration → Search and metadata → Search API → *(your index)* → Edit**
(and its **Fields** tab), under **Configuration → Search and metadata → Search
API** (`/admin/config/search/search-api`).
