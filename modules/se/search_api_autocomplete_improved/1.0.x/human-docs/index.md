# Search API Autocomplete Improved — manual setup guide

**Search API Autocomplete Improved** (`search_api_autocomplete_improved`) refines
the autocomplete (typeahead) experience for sites using **Search API Solr**. It adds
smarter caching, suggestion validation, and — importantly — accurate per-suggestion
result counts, fixing a set of well-known quirks in Solr-backed autocomplete.

The problems it targets are real and familiar to anyone running Solr autocomplete:
the "estimated result count" next to suggestions is often wrong (Solr's suggester
reports a term-frequency number, not the number of matching documents); the suggester
can bolt a new token onto your prefix to form a phrase that has *no* results even
though the individual words do; duplicate suggestions appear when several suggester
plugins are combined; and the suggester can propose words that do not actually exist
in the indexed values. This module post-processes the suggestions to fix these — it
validates them, removes duplicates based on normalised text, and calculates real
result counts, all with caching so the extra lookups do not slow things down.

A key convenience is that it is **zero-configuration**: it automatically discovers
your Views and Search API setup from your existing Search API Autocomplete entities,
so it works out of the box with any Solr-plus-Views autocomplete search — there is
nothing you *must* set up. It does its work through Drupal's suggestions alter hook
(using modern object-oriented hook classes on Drupal 11, with a procedural shim for
Drupal 10 compatibility), keeps its own cache bin, and invalidates cached counts when
the search index changes. It has no public write endpoint and adds no request surface
of its own — a small, low-risk enhancement layer. It depends on the Search API Solr
Autocomplete submodule and targets Drupal 10.2+ and 11.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the optional settings form (it works
   without touching it).

## Where it lives in the admin menu

The optional settings form sits under Search API's admin section at
`/admin/config/search/search-api/search_api_autocomplete_improved`, protected by the
**Administer Search API autocomplete** (`administer search_api_autocomplete`)
permission.
