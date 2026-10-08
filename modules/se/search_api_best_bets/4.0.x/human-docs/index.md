# Search API Best Bets — manual setup guide

**Search API Best Bets** (`search_api_best_bets`) lets your editors curate search
results. For any entity — a page, an article, a product — an editor can list the
search keywords that should **elevate** that entity to the top of Search API
results, or the keywords that should **exclude** it from results entirely. When a
visitor searches for one of those keywords, the elevated entity jumps to the top
(and excluded ones drop out), giving you editorial control over your most
important or ambiguous search terms without anyone touching the search backend's
configuration.

The module works in two halves. First, you add a **Search API Best Bets field**
to whichever entity bundles should support best bets; its widget gives editors
two simple boxes — one list of "elevate" queries and one list of "exclude"
queries. Second, you enable the **Search API Best Bets processor** on your search
index and tell it which best‑bets field(s) to read, which query handler to use,
and how to score elevated items. From then on the matching happens at query time.

Out of the box the module ships a **Solr query handler** that uses Apache Solr's
native `elevateIds` / `excludeIds` parameters (it also declares support for
Acquia Search). For other backends, the module defines a query‑handler plugin
type so developers can add their own — see the sibling `agent/` docs for that.
Elevated results are also tagged with a `search-api-elevated` CSS class in both
Search API Pages and Views, so you can style them distinctly.

One important detail about matching: it is **exact equality** on the whole,
trimmed, lowercased search string — not substring or token matching. A best bet
for `open source` fires when someone searches exactly `open source`, not when
they search `open`.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Search API.
2. [Configuration](configuration/index.md) — adding the best‑bets field, enabling
   and tuning the index processor, and the permissions editors need.

## Where it lives in the admin menu

There is no single global settings page for this module. Setup happens in two
familiar places: the **Manage fields** tab of the entity bundle (where you add
the best‑bets field) and the **Processors** tab of your Search API index (where
you enable and configure the processor). See
[Configuration](configuration/index.md) for the walk‑through.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Add a *Search API Best Bets* field to the bundles you want to curate.
3. Enable the *Search API Best Bets* processor on your search index and point it
   at that field.
4. Grant editors the best‑bets permissions, then have them fill in elevate/exclude
   keywords on individual entities.
