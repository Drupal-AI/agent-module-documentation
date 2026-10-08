# Elasticsearch Connector Suggester — manual setup guide

**Elasticsearch Connector Suggester** (`elasticsearch_connector_suggester`) lets
Search API autocomplete draw its suggestions from **Elasticsearch's own native
suggester** (completion/term suggestions) rather than the more generic autocomplete
behaviour. The result is faster, cleaner typeahead: as a visitor types into a
search box, suggestions come straight from Elasticsearch, which handles this kind of
"suggest as you type" query natively.

It's a bridge module that ties three things together, so it depends on all of them:
[Elasticsearch Connector](https://www.drupal.org/project/elasticsearch_connector)
(the Elasticsearch connection),
[Search API](https://www.drupal.org/project/search_api) (which manages your indexed
data), and
[Search API Autocomplete](https://www.drupal.org/project/search_api_autocomplete)
(which provides the autocomplete framework and the field where you enable it). On
its own it adds a new suggester option — "Elastic display live results" — that you
select on an index's autocomplete configuration.

It has **no dedicated settings page**. You configure it entirely from the Search API
index's **Autocomplete** tab, described in "How to use it" below. It supports Drupal
9, 10, and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside its Search API dependencies.

There is **no configuration page** for this module — you enable the suggester on
your Search API index's Autocomplete tab, as described below.

## Where it lives in the admin menu

The module adds no admin page of its own. You use it from your Search API index at
**Configuration → Search and metadata → Search API**
(`/admin/config/search/search-api`), under that index's **Autocomplete** tab.

## How to use it

1. Enable the module.
2. Go to **Configuration → Search and metadata → Search API** and open the index
   you want autocomplete on.
3. Open the **Autocomplete** tab and make sure autocomplete is enabled for the
   relevant search.
4. Select the **"Elastic display live results"** suggester.
5. Choose the field or fields you want the suggester to draw suggestions from.
6. Save the autocomplete configuration.

Your search box will now serve typeahead suggestions from Elasticsearch's native
suggester.
