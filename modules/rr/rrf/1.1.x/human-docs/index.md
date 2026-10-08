# RRF Search — manual setup guide

**RRF Search** (`rrf`) blends two kinds of search results into a single, better‑ranked
list. On a modern Drupal site you might run a *vector* (semantic/AI) search that
understands meaning, alongside a traditional *keyword* search that matches exact
words. Each returns its own ranked list, and each is good at something the other
misses. RRF Search merges those two lists using the **Reciprocal Rank Fusion**
algorithm — it looks at where each item ranks in each list and combines those
positions into one fused score — so hybrid search returns the best of both.

It plugs into **Search API** and is meant to work with the **AI** module's
**AI Search** submodule (which provides the vector side). It adds no page or block
of its own: it contributes to the search pipeline behind the scenes, and there is
nothing you *must* fill in on a settings screen to get it working — you enable it
and wire it into your search configuration.

This module requires Drupal 10 or 11. It is a young project and is not yet covered
by Drupal's security advisory policy, so weigh that before relying on it in
production.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside Search API and AI Search.

There is **no dedicated configuration page** for this module. You use it from your
existing Search API setup, described in "How to use it" below.

## How to use it

RRF Search is only useful once you already have hybrid search in place — a Search
API server and index, plus the AI module's **AI Search** submodule providing the
vector/semantic side. With those in place, RRF Search contributes the fusion step
that merges the vector results and the keyword results into one blended ranking, so
a single query surfaces the most relevant items from both methods rather than
favouring one. Set up (or review) your Search API index and its AI Search
configuration, and the reciprocal‑rank‑fusion merging comes from having this module
enabled.
