# Search API Extras — manual setup guide

**Search API Extras** (`search_api_extras`) is a small collection of additional
Search API functionality — a couple of focused improvements to how Search API
parses queries and sorts results. It depends on the **Search API** module
(`search_api`) and adds no configuration screen of its own; its features surface
inside Search API's existing parser and Views sort options.

At the time of writing it contains two features:

- **A "Multiple Terms" parser override.** Search API's stock multiple-terms parser
  breaks a search phrase into its individual words. This override *also* keeps the
  full phrase alongside those words, so a document containing the exact phrase
  ranks more highly than one that merely mentions the words separately — for
  example, a page that says "lunch menu" verbatim will outrank a page that only
  talks about "lunch" and "menu" in different places.
- **A "conditional relevance" sort handler.** This is a Views sort that only
  applies when an exposed search phrase has actually been supplied. It's handy when
  you want a view to sort by relevance *when someone searches*, but fall back to
  another order (such as date or alphabetical) when the search box is empty.

Enabling the module makes these available, but you choose to use them: pick the
parser on your index and add the conditional-relevance sort to a Search API View.
It is a site-search and developer-oriented feature — results still follow the
search index's access rules, and the module has no access-control role of its own.
Note this release is a development version and the project is **not covered** by
Drupal's security advisory policy.

This guide is written for a **human** working through the admin UI. If you are an
AI agent, read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

There is no settings page. The two features appear where you already work with
Search API:

- **Multiple Terms parser** — edit your Search API index (or the search view's
  query settings) and choose the parser provided by this module in place of the
  stock multiple-terms parser, then re-index if needed.
- **Conditional relevance sort** — edit a Search API-backed View, add the
  **conditional relevance** sort criterion, and configure it so relevance sorting
  only kicks in when an exposed search phrase is present.
