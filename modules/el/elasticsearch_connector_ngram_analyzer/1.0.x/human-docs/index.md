# Elasticsearch Connector Ngram Analyzer — manual setup guide

**Elasticsearch Connector Ngram Analyzer** (`elasticsearch_connector_ngram_analyzer`)
adds an **n-gram analyzer** to the
[Elasticsearch Connector](https://www.drupal.org/project/elasticsearch_connector)
so that searches can match **partial words and substrings** rather than only whole
terms. That's what makes autocomplete-style "match as you type" and mid-word
matching work: with n-gram tokenization, typing `info` can match `information`, and
a substring in the middle of a word can still be found.

It is a small enhancement module, not a standalone search system. It depends on the
Elasticsearch Connector module (and, in practice, on
[Search API](https://www.drupal.org/project/search_api), which manages your indexed
data). Once enabled, it makes an NGram field type available so you can apply n-gram
tokenization to the specific text fields where partial matching matters.

It has **no settings page of its own** and no access-control role — search results
still follow your search index's normal access handling. The setup happens on your
Search API index's field configuration, described in "How to use it" below.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Elasticsearch Connector and Search API.

There is **no configuration page** for this module — you apply the analyzer per
field on your Search API index, as described below.

## Where it lives in the admin menu

The module adds no admin page of its own. You use it entirely from your Search API
index at **Configuration → Search and metadata → Search API**
(`/admin/config/search/search-api`).

## How to use it

1. Go to **Configuration → Search and metadata → Search API** and edit the index
   you want partial matching on.
2. Open the index's **Fields** tab.
3. For each text field where you want substring/partial matching, select the
   **NGram** type in the field settings.
4. Save the field configuration.
5. **Reindex your data** so the new tokenization is applied — from the Search API
   index page, use **Index now** for that index.

After reindexing, searches against those fields will match partial words and
substrings.
