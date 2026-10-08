# Search API Lunr — manual setup guide

**Search API Lunr** (`search_api_lunr`) is a Search API *backend* that pairs
Drupal with [Lunr](https://lunrjs.com), a small JavaScript search engine that runs
entirely in the visitor's browser. Instead of sending indexed content to a
server-side engine like Solr, this backend writes your index to JSON files that
are loaded directly into the browser — so every search runs client-side, in
JavaScript, with no server request per query.

You configure it just like any other Search API backend: pick the fields to index
and a pipeline of processors. The difference is where the results go. Because it
uses Search API's own index tracking, items are added to the index on demand as
content is created or updated — you don't have to rebuild the whole index — and
you choose indexable fields through the Search API interface rather than through a
View. That on-demand behavior makes it a good fit for an integrated Drupal
front-end that wants instant-search-style behavior, and less suited to a
statically generated site that runs a separate build step.

Its headline features are per-document boosting (choose a field that pushes
certain results higher or lower), per-field boosting (weight each indexed field's
contribution to ranking), a ready-made instant-search autocomplete block, and a
JavaScript API for running custom searches and weaving index results into your
site however you like. It depends on the **Search API** and **jQuery UI
Autocomplete** modules and works on Drupal 10.2+ and 11.

**Important privacy point.** Because the Lunr index is generated and then
**served to the browser**, everything you put in it is fully downloadable by
anyone who can load the page. Only index content that is safe to be completely
public — never index access-restricted or otherwise non-public content into a
client-side Lunr index, because the entire index, not just the matching results,
is exposed to the client. Before going live, confirm that the index contains only
public content.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — set up the Lunr server and index,
   choose fields and boosting, and add the autocomplete block.

## How to use it

Search API Lunr appears as a backend option when you create a Search API server.
After you index content, use the instant-search autocomplete block or the
module's JavaScript API to run searches directly in the browser. See
[Configuration](configuration/index.md) for the walkthrough.
