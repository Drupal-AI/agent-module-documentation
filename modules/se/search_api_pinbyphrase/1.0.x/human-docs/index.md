# Search API PinByPhrase — manual setup guide

**Search API PinByPhrase** (`search_api_pinbyphrase`) pins a chosen node to the top
of search results whenever the search query matches a phrase you've configured.
It's the Drupal equivalent of the "best bets" feature familiar from enterprise
search: clients often want a specific page to appear first for a specific search
term, regardless of how the normal relevance ranking would order things, and this
module gives you a straightforward way to arrange that.

You define none-to-many sets of phrases, each tied to a specific node ID and
language code. When a visitor's query matches one of those phrases, an event
subscriber processes the extracted results and lifts the matching node to the top.
So you might pin your official "Contact us" page to the top for the phrase
*contact*, or a particular product page for a branded search term — for the right
query and the right language, that node leads the results.

The module depends on the **Search API** module and, required, the **Search API
Solr** module — it is expected to work on a "content" index. It provides an
`administer search_api_pinbyphrase` permission that gates its configuration form,
and it works on Drupal 10.3+ and 11. A similar project, Search API Exact Match
Boost, boosts matching results but does not pin specific node IDs to a phrase the
way this module does.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Solr dependency.
2. [Configuration](configuration/index.md) — define the pinned phrases with their
   node IDs and languages.

## How to use it

Once installed, open the module's configuration form (reachable via the gear icon
next to it on the Extend page), and add one or more phrase sets, each mapping a
phrase to the node ID and language code that should be pinned when that phrase is
searched. See [Configuration](configuration/index.md) for the walkthrough.
