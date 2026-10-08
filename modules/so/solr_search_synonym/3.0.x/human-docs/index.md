# SOLR Search Synonym — manual setup guide

**SOLR Search Synonym** (`solr_search_synonym`) lets editors manage search
synonyms — and common spelling errors — from inside Drupal, then exports them
directly into your Apache Solr configuration so the search engine treats the
terms as equivalent. Telling Solr that "car" and "automobile" mean the same
thing, or that a frequent misspelling should still match, improves **recall** so
searchers find what they meant even when their wording differs from the content.

It is an extended version of the Search API Synonym module. Its headline addition
is direct Solr integration: you no longer have to hand-edit a `synonyms_und.txt`
file on the Solr server — synonyms can be pushed straight into Solr, either with a
Drush command or automatically on cron. It depends on core System, Options and
Views plus the **Search API** and **Search API Solr** modules, provides its own
permissions, and stores synonyms as `solr_search_synonym` entities.

This is a **site-search feature** that operates at the search/index layer: it
shapes how queries match content, not who can see it. Search results still
respect the index and normal entity access. Note that the module is **not
covered** by Drupal's security advisory policy, so factor that into your risk
assessment for production use.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside its Search API Solr dependencies.
2. [Configuration](configuration/index.md) — managing synonyms, the export
   settings, and exporting to Solr.

## Where it lives in the admin menu

Once enabled, you manage synonyms at **Configuration → Search and metadata → SOLR
Search Synonyms** (`/admin/config/search/solr-search-synonyms`), which is the
`solr_search_synonym` entity collection. Export-on-cron settings live under that
page at `/admin/config/search/solr-search-synonyms/settings`.
