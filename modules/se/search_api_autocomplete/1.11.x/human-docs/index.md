# Search API Autocomplete — manual setup guide

**Search API Autocomplete** (`search_api_autocomplete`) adds a type-ahead
dropdown to searches built on the **Search API** framework. As a visitor types in
a search box, they see suggestions — completed keywords, or even live result items
with titles and links — so they can refine or jump straight to what they want
without submitting the form first. It works with Views-based Search API searches
and Search API Pages, and can be extended to custom searches.

Autocomplete is turned on **per search**, at each index's *Autocomplete* tab —
there is no single global switch, and nothing changes on your site the moment you
enable the module. Each search you enable becomes an exportable configuration
entity, so your autocomplete setup deploys between environments like the rest of
your Search API config. For each one you choose which *suggesters* run and tune
how the dropdown behaves (how many suggestions, how many characters before it
fires, how long to wait after a keystroke).

The suggestions themselves come from **suggester** plugins. Three ship with the
module: **Server** (completions supplied by the search backend — this needs a
backend that supports autocomplete, such as Solr), **Live results** (renders
matching result items right in the dropdown, and works with any backend), and a
**Custom script** suggester for bespoke logic. Access is controlled by an
`administer search_api_autocomplete` permission for configuring it, plus an
automatically generated per-search permission that governs who may use each
search's suggestions.

The module depends on **Search API** (`search_api`), and for server-side term
completions it also needs a search server that supports autocomplete. It has no
submodules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — enable autocomplete on a search,
   pick suggesters, and tune the dropdown, field by field.

## Where it lives in the admin menu

Autocomplete is configured from within Search API, not from a settings page of its
own. On each search index you'll find an **Autocomplete** tab at
**Configuration → Search and metadata → Search API → [your index] → Autocomplete**
(`/admin/config/search/search-api/index/{index}/autocomplete`). That tab lists the
autocomplete-capable searches on the index; from there you enable and configure
each one. See [Configuration](configuration/index.md) for the walkthrough.
