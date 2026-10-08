# Search API Autocomplete — manual setup guide

**Search API Autocomplete** (`search_api_autocomplete`) adds a type-ahead
autocomplete dropdown to searches built on the **Search API** framework — Views-
backed searches, Search API Pages, and custom searches. As users type into a search
box, they see completions and, optionally, live matching results, so they can jump
straight to what they're looking for.

Each autocomplete-enabled search is stored as its own configuration entity and is
configured per index, on the index's **Autocomplete** tab. You get fine-grained
control: which searches offer autocomplete, which **suggesters** produce the
suggestions, how many suggestions show, the minimum number of characters before
suggesting, and the delay before firing. The bundled suggesters include **Server**
(backend-provided completions, e.g. from Solr), **Live results** (renders matching
result items directly in the dropdown), and a **Custom script** suggester.

An important caveat: server-side term completions require a search backend that
**supports autocomplete** (such as Solr) — the *Live results* suggester works with
any backend, but plain database searches can't provide server suggestions. The
module requires the **Search API** module and provides an
`administer search_api_autocomplete` permission plus per-search view permissions.
Everything is exportable configuration, so autocomplete setups deploy between
environments like the rest of your Search API config.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no single configuration page** for this module — autocomplete is set up
per index on its Autocomplete tab, described in "How to use it" below.

## Where it lives in the admin menu

Autocomplete is configured per Search API index at **Configuration → Search and
metadata → Search API → *(index)* → Autocomplete**
(`/admin/config/search/search-api/index/{index}/autocomplete`). Access to those
screens is gated by the **Administer Search API Autocomplete** permission.

## How to use it

1. Make sure you have a working Search API **index** with at least one fulltext
   search (a search View or a Search API Page), served by a backend that supports
   autocomplete if you want server-side term suggestions.
2. Open the index's **Autocomplete** tab and **enable autocomplete** for the
   search(es) you want.
3. Choose the **suggesters** to run (Server, Live results, or both) and set limits
   such as the maximum number of suggestions, the minimum characters, and the
   typing delay.
4. Save. The search box now shows a suggestion dropdown as users type. You can
   quickly disable a search's autocomplete later without deleting the configuration.
